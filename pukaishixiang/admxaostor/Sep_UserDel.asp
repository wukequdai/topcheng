<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="Inc/Function.asp"-->
<%
dim ID,sql,rs,member
ID=DelStr(trim(request("ID")))
member=DelStr(trim(request("member")))
if ID<>"" then
	sql="delete from [Sep_UserInfo] where ID=" & Clng(ID)
	conn.Execute sql
end if
call CloseConn()
response.redirect "Sep_UserManage.asp?member="&member&""
%>