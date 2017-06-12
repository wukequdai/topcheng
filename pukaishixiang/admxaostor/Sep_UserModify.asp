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
ID=DelStr(trim(request("ID")))
member=DelStr(trim(request("member")))

if Action="SaveModify" then

	upass=DelStr(trim(request("upass")))
	ucpass=DelStr(trim(request("ucpass")))
	uadds=DelStr(trim(request("uadds")))
	utel=DelStr(trim(request("utel")))
	umobile=DelStr(trim(request("umobile")))
	unamec=DelStr(trim(request("unamec")))
	usex=DelStr(trim(request("usex")))
	ucompany=DelStr(trim(request("ucompany")))
	utype=DelStr(trim(request("utype")))
	uquestion=DelStr(trim(request("uquestion")))
	uanswer=DelStr(trim(request("uanswer")))
	
	If ucpass<>"" Then
		If upass="" Then
			FoundErr=true
			errmsg=errmsg +"用户密码没有填写<br />"
		end if
	end if
	
	if FoundErr=false then
	
		set rs=server.createobject("adodb.recordset")
		sql="select * from Sep_UserInfo where ID="&ID
		rs.open sql,conn,1,3
		if ucpass="yes" then
			rs("upass")=Md5(2,upass)
		end if
		rs("uadds")=uadds
		rs("utel")=utel
		rs("umobile")=umobile
		rs("unamec")=unamec
		rs("usex")=usex
		rs("ucompany")=ucompany
		rs("utype")=utype
		rs("uquestion")=uquestion
		rs("uanswer")=uanswer
		rs.update
		call WriteSuccessMsg("更新","Sep_UserManage.asp?member="&member&"")
		
	else
		FoundErr=true
		call WriteErrMsg(errmsg)
	end if
	rs.close
	set rs=nothing
end if

set rs=server.createobject("adodb.recordset")
sql="select * from Sep_UserInfo where ID="&ID
rs.open sql,conn,1,1
%>
<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：会员管理 > 会员管理</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_UserManage.asp?member=<%=member%>" iconCls="icon-commonedit" plain="true">会员管理</a> 
            <a class="easyui-linkbutton" href="Sep_UserAdd.asp" iconCls="icon-add" plain="true">添加会员</a> 
        </div>
    </div>
</div>

<form method="POST" action="Sep_UserModify.asp?ID=<%=rs("ID")%>&Action=SaveModify&member=<%=member%>">
<div class="wel_table">
<table class="nsw_pro_list">
    <tr>
    	<td align="right">用 户 名：</td>
    	<td><b><font color="#FF0000"><%=rs("uname")%></font></b></td>
    </tr>
    <tr>
    	<td align="right">联系邮箱：</td>
    	<td><b><font color="#FF0000"><%=rs("umail")%></font></b></td>
    </tr>
    <tr>
    	<td align="right">修改密码：</td>
    	<td><input type="text" name="upass" size="20">&nbsp;&nbsp;
    	<input type="checkbox" name="ucpass" value="yes">如需修改密码请选中此框</td>
    </tr>
    <tr>
    	<td align="right">会员等级：</td>
    	<td>
        <input name="utype" type="radio" value="0" <% if rs("utype")=0 then response.Write("checked")%> />未验证会员
        <input name="utype" type="radio" value="1" <% if rs("utype")=1 then response.Write("checked")%> />普通会员
        <input name="utype" type="radio" value="2" <% if rs("utype")=2 then response.Write("checked")%> />高级会员
        </td>
    </tr>
    <tr>
        <td align="right">公司名称：</td>
        <td><input type="text" name="ucompany" size="50" value="<%=rs("ucompany")%>" /></td>
    </tr>
    <tr>
        <td align="right">联系地址：</td>
        <td><input type="text" name="uadds" size="50" value="<%=rs("uadds")%>" /></td>
    </tr>
    <tr>
    	<td align="right">真实姓名：</td>
    	<td><input type="text" name="unamec" size="20" value="<%=rs("unamec")%>" /></td>
    </tr>    
    <tr>
    	<td align="right">性　　别：</td>
    	<td>
        <input name="usex" type="radio" value="女" <% if rs("usex")="女" then response.Write("checked")%> />女
        <input name="usex" type="radio" value="男" <% if rs("usex")="男" then response.Write("checked")%> />男</td>
    </tr>
    <tr>
    	<td align="right">联系电话：</td>
    	<td><input type="text" name="utel" size="20" value="<%=rs("utel")%>" /></td>
    </tr>
    <tr>
    	<td align="right">联系手机：</td>
    	<td><input type="text" name="umobile" size="20" value="<%=rs("umobile")%>" /></td>
    </tr>
    <tr>
    	<td align="right">密保问题：</td>
    	<td><input type="text" name="uquestion" size="20" value="<%=rs("uquestion")%>" /></td>
    </tr>
    <tr>
    	<td align="right">密保答案：</td>
    	<td><input type="text" name="uanswer" size="20" value="<%=rs("uanswer")%>" /></td>
    </tr>
    <tr>
   		<td align="right"></td>
        <td><input name="submit1" type="submit" class="button" value="更新" /></td>
    </tr>
</table>
</div>
</form>

<%
rs.close
set rs=nothing
call CloseConn()
%>

</body>
</html>