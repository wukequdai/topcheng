<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
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
FileName="Sep_UserManage.asp"
member=trim(request("member"))
umail=trim(request("umail"))
strFileName="member="&member&"&"
MaxPerPage=20   '每页显示记录数
page=Request("page")
Set Rs=Server.CreateObject("adodb.recordset")

if member="" or member=9 then '全部用户
	member=9
	sql="select * from Sep_UserInfo where 0=0 "
elseif member=0 then '锁定用户
	sql="select * from Sep_UserInfo where utype=0 "
elseif member=1 then '普通用户
	sql="select * from Sep_UserInfo where utype=1 "
elseif member=2 then '高级用户
	sql="select * from Sep_UserInfo where utype=2 "
end if

if umail<>"" then
	sql=sql & " and umail = '" & umail & "' "
end if

sql=sql&" order by ID desc"
rs.Open sql,conn,1,1
%>
<script language=javascript>
function ConfirmDel()
{
   if(confirm("确定要删除此用户吗？"))
     return true;
   else
     return false;
}
</script>

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

<div class="wel_table">
<table class="nsw_pro_list">
    <form name="search" method="get" action="Sep_UserManage.asp">
    <tr>
        <td colspan="5"> 
		<input type="button" name="Submit" value="导出Excel" onClick="location.href='Sep_Excel.asp?Action=daochu'" class="button1" style="float: right;" />
		<strong>查找会员：</strong>
        <input name="umail" type="text" class="smallInput" id="umail" value="<%=umail%>" style="width:300px;" /> 
        <input name="Query" type="submit" id="Query" value="搜索" /> &nbsp;&nbsp;请输入Email地址。如果为空，则查找所有会员。
        </td>
    </tr>
    </form>  
    <tr>
        <td colspan="5"><b>会员类型：</b>
          <a href="Sep_UserManage.asp" <%if member=9 then response.Write "style='color:#f00;'"%>>所有会员</a> 
          | <a href="Sep_UserManage.asp?member=0" <%if member=0 then response.Write "style='color:#f00;'"%>>未验证会员</a> 
          | <a href="Sep_UserManage.asp?member=1" <%if member=1 then response.Write "style='color:#f00;'"%>>普通会员</a>
          | <a href="Sep_UserManage.asp?member=2" <%if member=2 then response.Write "style='color:#f00;'"%>>高级会员</a>
        </td>
    </tr>
    <tr id="tabHeader">
      <td width="45" height="22" align="center"><strong>ID</strong></td>
      <td width="100"><strong>账号</strong></td>
      <td><strong>Email</strong></td>
      <td width="100" align="center"><strong>会员状态</strong></td>
      <td width="150" align="center"><strong>管理操作</strong></td>
    </tr>
<%
if rs.eof and rs.bof then
  response.write "<tr><td align='center' class='forumrow' colspan='5'>没有找到会员信息!</td></tr>"
else
  num1=Rs.recordcount  '总记录数
  Rs.movefirst
  if not isempty(request("page")) then
  pagecount=cint(request("page"))
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
%>
<tr>
    <td height="22" align="center"><%=rs("ID")%></td>
    <td><%=rs("uname")%></td>
    <td><%=rs("umail")%></td>
    <td align="center">
    <%if rs("utype")=0 then
    	response.write "<font color=red>未验证用户</font>"
	elseif rs("utype")=1 then 
		response.Write "普通会员" 
	elseif rs("utype")=2 then 
		response.Write "<font color=blue>高级会员</font>"
    end if
	%> </td>
    <td align="center">
    <a href="Sep_UserModify.asp?ID=<%=rs("ID")%>&member=<%=member%>" class="pro_edit">修改</a>
    <a href="Sep_UserDel.asp?ID=<%=rs("ID")%>&member=<%=member%>" onClick="return ConfirmDel();" class="pro_del">删除</a></td>
</tr>
<%
Rs.MoveNext
i=i+1
if i>maxPerPage then exit do
Loop
%>
</table>
</div>

<%call pagelist()%>
<%
End If
rsClass.close
set rsClass=nothing
call CloseConn()
%>
</body>
</html>