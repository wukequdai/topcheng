<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/Sep_MD5.asp"-->
<!--#include file="Inc/Function.asp"-->
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
FoundErr=false
Action=trim(request("Action"))

if Action="Add" then

	uname=DelStr(trim(request("uname")))
	umail=DelStr(trim(request("umail")))
	upass=DelStr(trim(request("upass")))
	
	If uname="" Then
		founderr=true
		errmsg=errmsg +"注册帐号没有填写<br />"
	end if
	
	If umail="" Then
		founderr=true
		errmsg=errmsg +"注册Email没有填写<br />"
	end if
	
	If upass="" Then
		founderr=true
		errmsg=errmsg +"用户密码没有填写<br />"
	end if
	
	if founderr=false then
		set rs=server.createobject("adodb.recordset")
		sql="select * from Sep_UserInfo"
		rs.open sql,conn,1,3
		rs.addnew
		rs("uname")=uname
		rs("umail")=umail
		rs("upass")=Md5(2,upass)
		rs("utype")=1
		rs("uregtime")=now()
		rs("uregip")=request.servervariables("remote_addr")
		rs.update
		call WriteSuccessMsg("添加","Sep_UserManage.asp")
	else
		founderr=true
		call WriteErrMsg(errmsg)
	end if
	rs.close
	set rs=nothing
end if

%>

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：会员管理 > 添加会员</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_UserManage.asp" iconCls="icon-commonedit" plain="true">会员管理</a> 
            <a class="easyui-linkbutton" href="Sep_UserAdd.asp" iconCls="icon-add" plain="true">添加会员</a> 
        </div>
    </div>
</div>

<form method="POST" action="Sep_UserAdd.asp?Action=Add">
<div class="wel_table">
<table class="nsw_pro_list">
  <tr>
      <td width="150" align="right">注册帐号：</td>
      <td><input type="text" name="uname" size="50" /></td>
  </tr>
  <tr>
      <td align="right">注册邮箱：</td>
      <td><input type="text" name="umail" size="50"></td>
  </tr>
  <tr>
      <td align="right">用户密码：</td>
      <td><input type="text" name="upass" size="50"></td>
  </tr>
  <tr>      
      <td height="25"></td>
      <td><input name="submit1" type="submit" class="button" value="添加"></td>
  </tr>
</table>
</div>
</form>

</body>
</html>