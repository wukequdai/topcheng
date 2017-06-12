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
		sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassName,PicUrl,Readme,Child,ClassType,Content From NewsClass where ClassID=" & ClassID
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
			Child=tClass(7)
			ClassType=tClass(8)
			Content=tClass(9)
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
		sqlClass="select RootID,ParentID,ParentPath,ClassID From NewsClass where ClassID=" & ClassID
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
		response.Write "<div class='news_list'><ul>" 
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
		do while not Rs.eof
			response.write "<li class='clearfix'><a href='newsview.asp?/"&rs(0)&".html'>"&rs(1)&"</a>["&datetime(rs(2),1)&"]</li>"
		Rs.MoveNext
		i=i+1
		if i>maxPerPage then exit do
		Loop
		response.write "</ul><div class='clearboth'></div></div>"
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

'===========================================
'产品分类
'ClassID  当前类别ID 
'===========================================
Function Show_Product_Class(ClassID)
	if ClassID="" Then
		sqlns="select top 1 ClassID from ProductClass order by RootID,OrderID"
		set rsns= conn.execute(sqlns)
		ClassID=rsns(0)
	end if
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassName,PicUrl,Readme,Child,ClassType,Content From ProductClass where ClassID=" & ClassID
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
			Child=tClass(7)
			ClassType=tClass(8)
			Content=tClass(9)
		end if
		tClass.close
	end if
end Function

'===========================================
'产品列表及翻页
'PageNum 每页显示记录数 
'ClassID 当前类别ID 
'Page    当前页数 
'TypeID  显示样式 0 普通样式 1 图片等比例 2 图片与咨询
'===========================================
Function Show_Product_List(PageNum,ClassID,Page)
	strFileName="/"&ClassID&"_"
	MaxPerPage=PageNum 
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select ID,Title,PicUrl from Product where ID>0"
	
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID From ProductClass where ClassID=" & ClassID
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
		end if
		tClass.close
		arrClassID=ClassID
		if ParentID>0 then
		  set trs=conn.execute("select ClassID from ProductClass where ParentID=" & ClassID & " or ParentPath like '%" & ParentPath & "," & ClassID & ",%'")
		else
		  set trs=conn.execute("select ClassID from ProductClass where RootID=" & RootID & " and Depth>0" )
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
		response.Write "<div class='pd-list'><ul>" 
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
		do while not Rs.eof
			response.write "<li><a href='productview.asp?/"&rs(0)&".html'>"
			response.write "<div><img src='"&ImgUrl(rs(2))&"' onload='AutoResizeImage(this, 200, 200)' width='200' height='200' /></div>"
			response.write ""&rs(1)&"</a></li>"
		Rs.MoveNext
		i=i+1
		if i>maxPerPage then exit do
		Loop
		response.write "</ul><div class='clearboth'></div></div>"
		call Pagelist(Rs.pagecount,pagecount,strFileName)
	end if
	rs.close
	set rs=nothing
End Function

'===========================================
'产品详情
'ID  当前信息ID 
'===========================================
Function Show_Product_Content(ID)
	if ID&""="" then
		response.Write("<script language=javascript>alert('对不起，超出范围!');history.go(-1);</script>")
		response.end
	end if
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select * from Product where ID="&ID
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
	Sep_Canshu=rs("Canshu")
	Sep_Content=rs("Content")
	Sep_Time=rs("UpdateTime")
	Sep_Hits=rs("Hits")
	Sep_PicUrls=rs("PicUrls")
	rs.close
	set rs=nothing
	
	set rsns= conn.execute("select ParentID,ParentPath,ClassName from ProductClass where ClassID="&Sep_ClassID&"")
	ParentID=rsns(0)
	ParentPath=rsns(1)
	ClassName=rsns(2)
End Function


'===========================================
'应用分类
'ClassID  当前类别ID 
'===========================================
Function Show_App_Class(ClassID)
	if ClassID="" Then
		sqlns="select top 1 ClassID from AppClass order by RootID,OrderID"
		set rsns= conn.execute(sqlns)
		ClassID=rsns(0)
	end if
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassName,PicUrl,Readme,Child,ClassType,Content From AppClass where ClassID=" & ClassID
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
			Child=tClass(7)
			ClassType=tClass(8)
			Content=tClass(9)
		end if
		tClass.close
	end if
end Function

'===========================================
'应用列表及翻页
'PageNum 每页显示记录数 
'ClassID 当前类别ID 
'Page    当前页数 
'===========================================
Function Show_App_List(PageNum,ClassID,Page)	
	strFileName="/"&ClassID&"_"
	MaxPerPage=PageNum  '每页显示记录数
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select ID,Title,PicUrl,Canshu from App where ID>0"
	
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID From AppClass where ClassID=" & ClassID
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
		end if
		tClass.close
		arrClassID=ClassID
		if ParentID>0 then
		  set trs=conn.execute("select ClassID from AppClass where ParentID=" & ClassID & " or ParentPath like '%" & ParentPath & "," & ClassID & ",%'")
		else
		  set trs=conn.execute("select ClassID from AppClass where RootID=" & RootID & " and Depth>0" )
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
		response.Write "<div class='case-list'><ul>" 
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
		do while not Rs.eof
			response.write "<li><a href='projectview.asp?/"&rs(0)&".html'><div><img src='"&ImgUrl(rs(2))&"' onload='AutoResizeImage(this, 200, 200)' width='200' height='200' /></div></a>"
			response.write "<p><strong>项目名称："&rs(1)&"</strong>"
			response.write ""&rs(3)&"<br />"
			response.write "<a href='projectview.asp?/"&rs(0)&".html'><img src='Images/case_list_btn.gif' /></a></p></li>"
		Rs.MoveNext
		i=i+1
		if i>maxPerPage then exit do
		Loop
		response.write "</ul><div class='clearboth'></div></div>"
		call Pagelist(Rs.pagecount,pagecount,strFileName)
	end if
	rs.close
	set rs=nothing
End Function

'===========================================
'应用详情
'ID  当前信息ID 
'===========================================
Function Show_App_Content(ID)
	if ID&""="" then
		response.Write("<script language=javascript>alert('对不起，超出范围!');history.go(-1);</script>")
		response.end
	end if
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select * from App where ID="&ID
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
	Sep_Canshu=rs("Canshu")
	Sep_Content=rs("Content")
	Sep_Time=rs("UpdateTime")
	Sep_Hits=rs("Hits")
	Sep_PicUrls=rs("PicUrls")
	rs.close
	set rs=nothing
	
	set rsns= conn.execute("select top 1 ParentID,ClassName from AppClass where ClassID="&Sep_ClassID&"")
	ParentID=rsns(0)
	ClassName=rsns(1)
End Function


'===========================================
'下载分类
'ClassID  当前类别ID 
'===========================================
Function Show_Down_Class(ClassID)
	if ClassID="" Then
		sqlns="select top 1 ClassID from DownClass order by RootID,OrderID"
		set rsns= conn.execute(sqlns)
		ClassID=rsns(0)
	end if
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassName,PicUrl,Readme From DownClass where ClassID=" & ClassID
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
'下载列表及翻页
'PageNum 每页显示记录数 
'ClassID 当前类别ID 
'Page    当前页数 
'===========================================
Function Show_Down_List(PageNum,ClassID,Page)	
	strFileName="/"&ClassID&"_"
	MaxPerPage=PageNum  '每页显示记录数
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select ID,Title,DownUrl,Content from Down where ID>0"
	
	if len(ClassID)>0 then
		sqlClass="select RootID,ParentID,ParentPath,ClassID From DownClass where ClassID=" & ClassID
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
		end if
		tClass.close
		arrClassID=ClassID
		if ParentID>0 then
		  set trs=conn.execute("select ClassID from DownClass where ParentID=" & ClassID & " or ParentPath like '%" & ParentPath & "," & ClassID & ",%'")
		else
		  set trs=conn.execute("select ClassID from DownClass where RootID=" & RootID & " and Depth>0" )
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
	
	sql=sql & " order by ID desc"
	rs.open sql,conn,1,1
	
	if rs.eof and rs.bof then
		response.write "<center class='mt30'>对不起,没有找到相关信息！</center>"
	else
		response.Write "<div class='down-list'><ul>" 
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
		do while not Rs.eof
			response.write "<li class='clearfix'><a href='downview.asp?/"&rs(0)&".html' class='dow-text'>"&rs(1)&"</a>"
			response.write "<a href='downview.asp?Action=Down&XaosID="&rs(0)&"' class='dow-xz' target='_blank'>点击下载</a></li>"
		Rs.MoveNext
		i=i+1
		if i>maxPerPage then exit do
		Loop
		response.write "</ul><div class='clearboth'></div></div>"
		call Pagelist(Rs.pagecount,pagecount,strFileName)
	end if
	rs.close
	set rs=nothing
End Function

'===========================================
'下载详情
'ID  当前信息ID 
'===========================================
Function Show_Down_Content(ID,Action)
	if ID&""="" then
		response.Write("<script language=javascript>alert('对不起，超出范围!');history.go(-1);</script>")
		response.end
	end if
	Set Rs=Server.CreateObject("adodb.recordset")
	sql="select * from Down where ID="&ID
	rs.open sql,conn,1,3
	if rs.eof and rs.bof Then
		response.Write("<script language=javascript>alert('对不起，超出范围!');history.go(-1);</script>")
		response.end
	end if
	
	Sep_ID=rs("ID")
	Sep_ClassID=rs("ClassID")
	Sep_Title=rs("Title")
	Sep_Keyword=rs("Keyword")
	Sep_DownUrl=rs("DownUrl")
	Sep_Content=rs("Content")
	Sep_Time=rs("UpdateTime")
	Sep_Hits=rs("Hits")
	
	if Action="Down" and ID<>"" then
		rs("Hits")=rs("Hits")+1
		rs.update
		Response.Redirect Sep_DownUrl
		response.end
	end if
	
	rs.close
	set rs=nothing
	
	set rsns= conn.execute("select top 1 ParentID,ClassName from DownClass where ClassID="&Sep_ClassID&"")
	ParentID=rsns(0)
	ClassName=rsns(1)

End Function
%>