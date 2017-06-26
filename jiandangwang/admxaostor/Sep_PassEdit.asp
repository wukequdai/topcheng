<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/Sep_MD5.asp"-->
<!--#include file="inc/function.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-cn" xml:lang="zh-cn">
<head>
<title>右侧主页管理导航菜单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="images/common.css" rel="stylesheet" type="text/css" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
<SCRIPT type=text/javascript src="images/jquery.js"></SCRIPT>
<SCRIPT type=text/javascript src="images/jquery.easyui.min.js"></SCRIPT>
</head>
<body>
<%
action=DelStr(trim(Request("action")))
AdminName=DelStr(session(SiteSn & "AdminName"))

if Action="Modify" then

ID=trim(Request("ID"))
NewPassword=DelStr(trim(Request("NewPassword")))
OldPassword=DelStr(trim(Request("OldPassword")))
if strLength(NewPassword)>16 or strLength(NewPassword)<6 then
  response.write  "<script language=javascript>alert('请输入的密码位数不能小于6位或大于16位!');history.go(-1);</script>"
  response.End
end if

set rs=server.createobject("adodb.recordset")
sql="select * from Sep_Admin where ID="&ID&""
'response.Write sql
rs.open sql,conn,1,3

'更新管理员密码
if Md5(2,Md5(0,OldPassword))<>rs("SepPass")  then
  response.write  "<script language=javascript>alert('原密码错误，请返回重新输入!');history.go(-1);</script>"
  response.End
else
rs("SepPass")=Md5(2,Md5(0,NewPassword))
end if
rs.update
rs.close
Response.write "<script language=javascript>alert('密码更新成功!');location='Sep_Main.asp'</script> "
end if
%>
<SCRIPT language=javascript>
<!--
function myform_onsubmit()
{
if (document.myform.NewPassword.value!=document.myform.ConPassword.value)
{
alert ("新密码和确认密码不一致。");
document.myform.NewPassword.value='';
document.myform.ConPassword.value='';
document.myform.NewPassword.focus();
return false;
}
}
//-->
</SCRIPT>
<%
set rs=server.createobject("adodb.recordset")
sql="select * from Sep_Admin where SepName='"&AdminName&"'"
'response.Write sql
rs.open sql,conn,1,1
%>

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：密码修改</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>

<FORM name=myform  onsubmit="return myform_onsubmit()" action="Sep_PassEdit.asp?Action=Modify" method=post>
<input type=hidden name=ID value=<%=rs("ID")%>>
<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <th align="center">管理员帐号：<%=rs("SepName")%></th>
  </tr>
  <tr>
    <td align="center">原始密码：<input name="OldPassword" type="password" size="16" maxlength="16"></td>
  </tr>
  <tr>
    <td align="center">新 密 码：<input name="NewPassword" type="password" size="16" maxlength="16"></td>
  </tr>
  <tr>
    <td align="center">密码确认：<input name="ConPassword" type="password" size="16" maxlength="16"></td>
  </tr>
  <tr>
    <td align="center">
        <INPUT name=Submit2  type=submit value='修改' class="button"></td>
  </tr>
</table>
</div>
</form>

</body>
</html>