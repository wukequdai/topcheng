<%
sub Admin_ShowRootClass(RootID,ClassID)
	dim sqlRoot,rsRoot
	sqlRoot="select ClassID,ClassName,RootID,Child From ProductClass where ParentID=0 and RootID="&RootID&" and ClassType<2 order by RootID"
	Set rsRoot= Server.CreateObject("ADODB.Recordset")
	rsRoot.open sqlRoot,conn,1,1
	if rsRoot.bof and rsRoot.eof then
		response.Write("还没有任何栏目，请首先添加栏目。")
	else
			
		Set rsSmall= Server.CreateObject("ADODB.Recordset")
		sqlSmall="select ClassID,ClassName,ParentID,Depth,NextID From ProductClass where Depth>0 and RootID="&rsRoot(2)&" and ClassType<2 order by RootID,OrderID"
		rsSmall.open sqlSmall,conn,1,1
		if not rsSmall.bof and not rsSmall.eof then
		response.write "<b>分类：</b>"
			response.write "<select onChange='if(this.selectedIndex && this.selectedIndex!=0){window.location=this.value;}this.selectedIndex=0;'><option selected>--请选择小类--</option>"				
			do while not rsSmall.eof
			
			tmpDepth=rsSmall("Depth")
			tmpNextID=rsSmall("NextID")
			
			if tmpDepth=1 then
				response.Write "<option value='"&FileName&"?ClassID="&rsSmall(0)&"'"
				if rsSmall(0)=ClassID then
					response.Write " selected"
				end if
				
				if tmpNextID>0 then
				  response.Write ">├&nbsp;"
				else
				  response.Write ">└&nbsp;"
				end if
				response.Write ""&rsSmall(1)&"</option>"
			else
				response.Write "<option value='"&FileName&"?ClassID="&rsSmall(0)&"'"
				if rsSmall(0)=ClassID then
					response.Write " selected"
				end if
				if tmpNextID>0 then
				  response.Write ">│&nbsp;&nbsp;├&nbsp;"
				else
				  response.Write ">│&nbsp;&nbsp;└&nbsp;"
				end if
				response.Write ""&rsSmall(1)&"</a>"
			end if
			rsSmall.movenext
			loop
			response.write "</select>"
		end if
		rsSmall.close
		set rsSmall=nothing
				
	end if
	rsRoot.close
	set rsRoot=nothing
end Sub

sub Admin_ShowClass_Option(ShowType,CurrentID)
	if ShowType=0 then
	    response.write "<option value='0'"
		if CurrentID=0 then response.write " selected"
		response.write ">无（作为一级栏目）</option>"
	end if
	dim rsClass,sqlClass,strTemp,tmpDepth,i
	dim arrShowLine(20)
	for i=0 to ubound(arrShowLine)
		arrShowLine(i)=False
	next
	sqlClass="Select * From ProductClass where Depth=0 and ClassType<2 order by RootID,OrderID"
	set rsClass=server.CreateObject("adodb.recordset")
	rsClass.open sqlClass,conn,1,1
	if rsClass.bof and rsClass.bof then
		response.write "<option value=''>请先添加栏目</option>"
	else
		do while not rsClass.eof
			if rsClass("Child")>0 then
				Set rsSmall= Server.CreateObject("ADODB.Recordset")
				sqlSmall="select * From ProductClass where Depth>0 and RootID="&rsClass("RootID")&" and ClassType<2 order by RootID,OrderID"
				rsSmall.open sqlSmall,conn,1,1
				if rsSmall.recordcount>0 then
					response.write "<option value='" & rsClass("ClassID") & "'"
					if CurrentID>0 and rsClass("ClassID")=CurrentID then
						 response.write " selected"
					end if
					response.write ">"& rsClass("ClassName")&"</option>"
					if not rsSmall.bof and not rsSmall.eof then			
						do while not rsSmall.eof
							tmpDepth=rsSmall("Depth")
							if rsSmall("NextID")>0 then
								arrShowLine(tmpDepth)=True
							else
								arrShowLine(tmpDepth)=False
							end if
							strTemp="<option value='" & rsSmall("ClassID") & "'"
							if CurrentID>0 and rsSmall("ClassID")=CurrentID then
								 strTemp=strTemp & " selected"
							end if
							strTemp=strTemp & ">"
				
							if tmpDepth>0 then
								for i=1 to tmpDepth
									strTemp=strTemp & "&nbsp;&nbsp;"
									if i=tmpDepth then
										if rsSmall("NextID")>0 then
											strTemp=strTemp & "├&nbsp;"
										else
											strTemp=strTemp & "└&nbsp;"
										end if
									else
										if arrShowLine(i)=True then
											strTemp=strTemp & "│"
										else
											strTemp=strTemp & "&nbsp;"
										end if
									end if
								next
							end if
							strTemp=strTemp & rsSmall("ClassName")
							strTemp=strTemp & "</option>"
							response.write strTemp
						rsSmall.movenext
						loop
					end if
				end if
				rsSmall.close
				set rsSmall=nothing
			else
				strTemp="<option value='" & rsClass("ClassID") & "'"
				if CurrentID>0 and rsClass("ClassID")=CurrentID then
					 strTemp=strTemp & " selected"
				end if
				strTemp=strTemp & ">"& rsClass("ClassName")& "</option>"
				response.write strTemp
			end if
		rsClass.movenext
		loop
	end if
	rsClass.close
	set rsClass=nothing
end Sub


sub Admin_ShowPath(RootName,ParentPath,ClassID)
	response.write "您现在的位置：&nbsp;" & RootName
	if ClassID="" then
		response.write "&nbsp;&gt;&nbsp;全部信息"
	else
		Sep_ParentPath=Split(ParentPath,",")
		if UBound(Sep_ParentPath)>0 then
			For i=1 To UBound(Sep_ParentPath)
				set rscn= conn.execute("select ClassName from ProductClass where ClassID="&Sep_ParentPath(i))
				response.Write "&nbsp;&gt;&nbsp;"&rscn(0)
			next
		end if
		response.Write "&nbsp;&gt;&nbsp;"&ClassName
	end if
end sub
%>