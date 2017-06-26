<%
'===========================================
'单页面
'ClassID  当前类别ID 
'AID      当前信息ID 
'CID      默认指定ID
'===========================================
Function Show_Page(AID,ClassID,CID)
	if ClassID="" then
		ClassID=CID
	end if
	Set Rs=Server.CreateObject("adodb.recordset")
	if AID="" Then
		Rs.open "select AID,ClassID,Title,PicUrl,Content from Sep_About where ClassID="&ClassID&" order by AID",conn,1,1 '数据库查询
	else
		Rs.open "select AID,ClassID,Title,PicUrl,Content from Sep_About where ClassID="&ClassID&" and AID="&AID&"",conn,1,1 '数据库查询
	end if
	if rs.eof and rs.bof Then
		response.Write("<script language=javascript>alert('对不起，超出范围!');history.go(-1);</script>")
		response.end
	end if
	Sep_ID=rs(0)
	Sep_ClassID=rs(1)
	Sep_Title=rs(2)
	Sep_PicUrl=rs(3)
	Sep_Content=rs(4)
	rs.close
	set rs=nothing
End Function

'===========================================
'内页导航
'ClassID     当前类别ID 
'Cname       导航根名称 
'ParentPath  获取分类路径 
'FileName    文件名
'ClassName   当前类别名
'===========================================
Function Show_SiteMap(Dname,ClassID,Cname,ParentPath,FileName,ClassName)
	response.Write "现在的位置：<a href='./'>首页</a>"
	if Cname<>"" then
		 response.Write " > "& Cname
	end if
	Sep_ParentPath=Split(ParentPath,",")
	if UBound(Sep_ParentPath)>0 then
		For i=1 To UBound(Sep_ParentPath)
			response.Write " > <a href='"& FileName &".asp?/"&Sep_ParentPath(i)&".html'>"
			set rspcn= conn.execute("select ClassName from "&Dname&"Class where ClassID="&Sep_ParentPath(i)&"")
			response.Write rspcn(0)
			response.Write "</a>"
		next
	end if
	response.Write " > <a href='"& FileName &".asp?/"&ClassID&".html'>"&ClassName&"</a>"
End Function

'===========================================
'新闻分类
'ClassID  当前类别ID 
'===========================================
Function Show_News_Class(ClassID)
	if ClassID="" Then
		sqlns="select top 1 ClassID from NewsClass order by RootID,OrderID"
		set rsns= conn.execute(sqlns)
		ClassID=rsns(0)
	end if
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassName,PicUrl,Readme From NewsClass where ClassID=" & ClassID
		set tClass=conn.execute(sqlClass)
		if tClass.bof and tClass.eof then
			FoundErr=True
			Response.write "<script language=javascript>alert('找不到指定的类别!');history.go(-1);</script> "
			response.end
		else
			RootID=tClass(0)	
			ParentID=tClass(1)	
			ParentPath=tClass(2)
			ClassID=tClass(3)
			ClassName=tClass(4)
			PicUrl=tClass(5)
			Readme=tClass(6)
		end if
		tClass.close
	end if
end Function

'===========================================
'新闻列表及翻页
'PageNum 每页显示记录数 
'ClassID 当前类别ID 
'Page    当前页数 
'===========================================
Function Show_News_List(PageNum,ClassID,Page)	
	strFileName="/"&ClassID&"_"
	MaxPerPage=PageNum  '每页显示记录数
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select ID,Title,Updatetime from News where ID>0"
	
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassType,ClassName From NewsClass where ClassID=" & ClassID
		set tClass=conn.execute(sqlClass)
		if tClass.bof and tClass.eof then
			FoundErr=True
			Response.write "<script language=javascript>alert('找不到指定的类别!');history.go(-1);</script> "
			response.end
		else			    	
			RootID=tClass(0)
			ParentID=tClass(1)	
			ParentPath=tClass(2)
			ClassID=tClass(3)
			ClassType=tClass(4)
			ClassName=tClass(5)
		end if
		tClass.close
		arrClassID=ClassID
		if ParentID>0 then
		  set trs=conn.execute("select ClassID from NewsClass where ParentID=" & ClassID & " or ParentPath like '%" & ParentPath & "," & ClassID & ",%'")
		else
		  set trs=conn.execute("select ClassID from NewsClass where RootID=" & RootID & " and Depth>0" )
		end if
		if not trs.eof then
		  do while not trs.eof
		   arrClassID=arrClassID & "," & trs(0)
		  trs.movenext
		  loop				
		  trs.close
		  sql=sql & " and ClassID in (" & arrClassID & ")"
		else
		  sql=sql & " and ClassID=" & ClassID
		end if	
	end if
	
	sql=sql & " order by OrderID desc, ID desc"
	rs.open sql,conn,1,1
	
	if rs.eof and rs.bof then
		response.write "<center class='mt30'>对不起,没有找到相关信息！</center>"
	else
		Rs.movefirst
		if not isempty(Page) then
			pagecount=cint(Page)
		else
			pagecount=1
		end if
		Rs.pagesize=MaxPerPage
		if pagecount>Rs.pagecount or pagecount<=0 then
			pagecount=1
		end if
		Rs.AbsolutePage=pagecount
		i=1            
		response.Write "<div id='text_con'><ul id='text_box'>" 
		do while not Rs.eof
			response.write "<li class='clearfix'>"
			response.write "<a href='listview.asp?/"&rs(0)&".html' title='"&rs(1)&"'><b>【"& ClassName &"】</b>"&rs(1)&"</a>"
			response.write "<span class='rt'>"&datetime(rs(2),1)&"</span></li>"
		Rs.MoveNext
		i=i+1
		if i>maxPerPage then exit do
		Loop
		response.write "</ul><div class='clear'></div></div>"
		call Pagelist(Rs.pagecount,pagecount,strFileName)
	end if
	rs.close
	set rs=nothing
End Function

'===========================================
'新闻详情
'ID  当前信息ID 
'===========================================
Function Show_News_Content(ID)
	if ID&""="" then
		response.Write("<script language=javascript>alert('对不起，超出范围!');history.go(-1);</script>")
		response.end
	end if
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select * from News where ID="&ID
	rs.open sql,conn,1,3
	if rs.eof and rs.bof Then
		response.Write("<script language=javascript>alert('对不起，超出范围!');history.go(-1);</script>")
		response.end
	end if
	rs("Hits")=rs("Hits")+1
	rs.update
	Sep_ID=rs("ID")
	Sep_ClassID=rs("ClassID")
	Sep_Title=rs("Title")
	Sep_Keyword=rs("Keyword")
	Sep_PicUrl=rs("PicUrl")
	Sep_Content=rs("Content")
	Sep_Time=rs("UpdateTime")
	Sep_Hits=rs("Hits")
	rs.close
	set rs=nothing
	
	set rsns= conn.execute("select ParentID,ParentPath,ClassName from NewsClass where ClassID="&Sep_ClassID&"")
	ParentID=rsns(0)
	ParentPath=rsns(1)
	ClassName=rsns(2)
End Function
%>