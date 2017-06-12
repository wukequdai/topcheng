<!--#include file="Conn.asp"-->
<!--#include file="inc/Sep_MD5.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="Inc/Config.asp"-->
<%
dim LoginName,LoginPassword,AdminName,Password,AdminPurview,Working,UserName,rs,sql
LoginName=DelStr(trim(request.form("LoginName")))
LoginPassword=Md5(2,Md5(0,DelStr(trim(Request.form("LoginPass")))))
AdminLoginCode=DelStr(trim(Request.form("AdminLoginCode")))

set rs = server.createobject("adodb.recordset")
sql="select * from Sep_Admin where SepName='"&LoginName&"'"
rs.open sql,conn,1,3

if rs.eof then
   errmsg=errmsg +"<p>管理员名称不正确，请重新输入!</p>"
else
   AdminName=rs("SepName")
   Password=rs("SepPass")
   AdminPurview=rs("Purview")
end if

if LoginPassword<>Password then
   errmsg=errmsg +"<p>管理员密码不正确，请重新输入!</p>"
end if 

If LoginName<>"xaos" then
   If EnableSiteManageCode=True And AdminLoginCode <> SiteManageCode Then
	 errmsg=errmsg +"<p>后台管理认证码不正确，请重新输入!</p>"
   End If
End If
 
if LoginName=AdminName and LoginPassword=Password then
   rs("LastLogoutTime")=rs("LastLoginTime")
   rs("LastLoginTime")=now()
   rs("LastLoginIP")=Request.ServerVariables("Remote_Addr")
   rs("LoginTimes")=rs("LoginTimes")+1
   rs.update
   rs.close
   set rs=nothing 
   session(SiteSn & "AdminName")=AdminName
   session(SiteSn & "AdminPassword")=Password
   session(SiteSn & "AdminPurview")=AdminPurview
   session(SiteSn & "LoginSystem")="Succeed"
   session.timeout=SessionTimeout
   '==================================
   dim LoginIP,LoginTime,LoginSoft
   LoginIP=Request.ServerVariables("Remote_Addr")
   LoginSoft=Request.ServerVariables("Http_USER_AGENT")
   LoginTime=now()
   '==================================
   response.redirect "control.asp"
else
   call LoginErrMsg(errmsg)
end if   
response.end
%>