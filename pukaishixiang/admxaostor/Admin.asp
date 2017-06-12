<%
'判断文件来路地址===============================================================
Dim ComeUrl,tUrl
ComeUrl=lcase(trim(request.ServerVariables("HTTP_REFERER")))
If ComeUrl="" then
	response.write "<br><p align=center><font color='red'>对不起，为了系统安全，不允许直接输入地址访问本系统的后台管理页面。</font></p>"
	Response.end
Else
	tUrl=Trim("http://" & Request.ServerVariables("SERVER_NAME"))
	If Mid(ComeUrl,len(tUrl)+1,1)=":" then
		tUrl=tUrl & ":" & Request.ServerVariables("SERVER_PORT")
	End If
	tUrl=Lcase(tUrl & request.ServerVariables("SCRIPT_NAME"))
	If Lcase(left(ComeUrl,instrrev(ComeUrl,"/")))<>lcase(left(tUrl,instrrev(tUrl,"/"))) then
		response.write "<br><p align=center><font color='red'>对不起，为了系统安全，不允许从外部链接地址访问本系统的后台管理页面。</font></p>"
		Response.end
	End If
End If

'判断是否登录或登录超时===============================================================
if session(SiteSn & "AdminName")="" or session(SiteSn & "AdminPurview")="" or session(SiteSn & "LoginSystem")<>"Succeed" then
	response.redirect "Sep_login.asp"
	response.End()
end If
'========
sql="select SepName from Sep_Admin where SepName='" & session(SiteSn & "AdminName") & "' and SepPass='" & session(SiteSn & "AdminPassword") & "'"
set rs=conn.execute(sql)
if rs.eof and rs.bof then
  rs.close
  call CloseConn()
  response.Redirect("Sep_login.asp")
  response.End()
end If
%>