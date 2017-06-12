<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/config.asp"-->
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

<script language=javascript>
function ConfirmDel()
{
   if(confirm("确定要处理此记录吗？"))
     return true;
   else
     return false;
}
</script>
<%
dim ID,rs,FoundErr,ErrMsg
Sep_Title="留言"
ID=trim(request.querystring("ID"))
Action=trim(request.querystring("Action"))
FoundErr=False

if Action="Good" then
  if ID<>"" then
	  conn.execute "Update Sep_Book set IsGood=1 Where ID=" & CLng(ID)
  end if
end if

if Action="ReBook" then

	ReContent=Trim(request.form("ReContent"))	
	
	if founderr=false then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql="select * from Sep_Book where ID="&ID
		rs.open sql,conn,1,3
		rs("ReContent")=ReContent
		rs("ReTime")=date()
		rs("IsGood")=1
		rs.update
		rs.close
		call WriteSuccessMsg("回复","Sep_Book.asp")
	end if
end if

if ID="" then
	response.Redirect("Sep_Book.asp")
end if
sql="select * from Sep_Book where ID=" & ID
Set rs= Server.CreateObject("ADODB.Recordset")
rs.open sql,conn,1,1
if FoundErr=True then
	call WriteErrMsg()
else
%>
<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：<%=Sep_Title%>管理 > <%=Sep_Title%>详情</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>

<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_Book.asp" iconCls="icon-commonedit" plain="true"><%=Sep_Title%>管理</a>
            <a class="easyui-linkbutton" href="Sep_Book.asp?action=looknew" iconCls="icon-add" plain="true">最新<%=Sep_Title%></a> 
		</div>
	</div>
</div>

<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <th colspan="2">查看<%=Sep_Title%>详情  <%if rs("IsGood")=1 then response.write "<font color=red>[已处理]</font>" end if%></th>
  </tr>
  <tr>
    <td width="150" align="right">公司名称：</td>
    <td><%=rs("ucompany")%></td>
  </tr>
  <tr>
    <td align="right">联 系 人：</td>
    <td><%=rs("uname")%></td>
  </tr>
  <tr>
    <td align="right">联系电话：</td>
    <td><%=rs("utel")%></td>
  </tr>
  <tr>
    <td align="right">联系传真：</td>
    <td><%=rs("ufax")%></td>
  </tr>
  <tr>
    <td align="right">邮　　箱：</td>
    <td><%=rs("uemail")%></td>
  </tr>
  <tr>
    <td align="right">留言主题：</td>
    <td><%=rs("utitle")%></td>
  </tr>
  <tr>
    <td align="right" valign="top">留言内容：</td>
    <td><%=rs("ucontent")%></td>
  </tr>
  <tr>
    <td align="right">留言时间：</td>
	<td><%=rs("updatetime")%></td>
  </tr>
  <%if SubReBook=0 then%>
  <tr>
    <td height="25" align="right"></td>
    <td>
    <%if rs("IsGood")=0 then%>
        <a href="Sep_BookShow.asp?Action=Good&ID=<%=rs("ID")%>" onClick="return ConfirmDel();" class="button4">处理该信息</a>
    <%end if%>
    <a href="Sep_Book.asp" class="button4">返回上一页</a>
    </td>
  </tr>
  <%else%>
  <tr>
    <td height="25" align="right">回复时间：</td>
    <td><%=rs("ReTime")%></td>
  </tr>
  <%end if%>
</table>
</div>

<%if SubReBook=1 then%>
<form method="post" action="Sep_BookShow.asp?Action=ReBook&ID=<%=ID%>">
<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
      <th colspan="2">输入回复内容</th>
  </tr>
  <tr>
    <td align="center">
        <textarea name="ReContent" cols="90" rows="10"><%if rs("IsGood")=0 then%><%=rs("uname")%>：您好，<%end if%><%=rs("ReContent")%></textarea>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="submit" value="回复" class="button">
    </td>
  </tr>
</table>
</div>
</form>
<%end if%>
<%
end if
rs.close
set rs=nothing
call CloseConn()
%>