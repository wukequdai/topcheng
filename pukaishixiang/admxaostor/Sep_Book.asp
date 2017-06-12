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

<SCRIPT language=javascript>
function unselectall()
{
    if(document.del.chkAll.checked){
	document.del.chkAll.checked = document.del.chkAll.checked&0;
    }
}
function CheckAll(form)
  {
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.Name != "chkAll")
       e.checked = form.chkAll.checked;
    }
  }
function ConfirmDel()
{
   if(confirm("确定要删除选中的信息吗？一旦删除将不能恢复！"))
     return true;
   else
     return false;

}
</SCRIPT>
<%
Sep_Title="留言"

Action=trim(request("Action"))
ID=trim(request("ID"))
MaxPerPage=20   '每页显示记录数
page=Request("page")
Set Rs=Server.CreateObject("adodb.recordset")

select case action
case "looknew"
	sql="select * from Sep_Book where ID>0 and IsGood=0 order by ID desc"
case "Del"
	if ID<>"" then
		if instr(ID,",")>0 then
			dim idarr,i
			idArr=split(ID)
			for i = 0 to ubound(idArr)
				call DelBook(clng(idarr(i)))
			next
		else
			call DelBook(clng(ID))
		end If
		response.Redirect "Sep_Book.asp"
	end if
case else
	sql="select * from Sep_Book where ID>0 order by ID desc"
end Select

sub DelBook(ID)
	conn.execute "Delete From Sep_Book Where ID=" & CLng(ID)
end sub

rs.open sql,conn,1,1
%>
<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：<%=Sep_Title%>管理 > <%If action="looknew" then%>最新<%=Sep_Title%><%else%>所有<%=Sep_Title%><%End if%></span>
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

<form name="del" method="Post" action="Sep_Book.asp" onSubmit="return ConfirmDel();">
<div class="wel_table">
<table class="nsw_pro_list">
<%
if not Rs.eof then
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
end if
i=1
if rs.eof and rs.bof then
response.write "<tr><td height=28 align='center' class=""forumrow"">对不起，没有找到相关信息！</td></tr>"
else
%>
  <tr id="tabHeader">
      <td width="45" align="center"><strong>选中</strong></td>
      <td><strong>主题</strong></td>
      <td width="80" align="center"><strong>状态</strong></td>
      <td width="100" align="center" ><strong>提交时间</strong></td>
      <td width="150" align="center" ><strong>操作</strong></td>
  </tr>
<%
do while not Rs.eof
%>
<tr>
	<td align="center"><input name='ID' type='checkbox' onClick="unselectall()" id="ID" value='<%=cstr(rs("ID"))%>'></td>
	<td><%=rs("utitle")%></td>
    <td align="center"><%if rs("IsGood")=1 then
	response.write "<font color=#999999>已处理</font>"
	else
	response.write "<font color=red>未处理</font>"
	end if%></td>
	<td align="center"><%= FormatDateTime(rs("UpdateTime"),2) %></td>
	<td align="center">
	<a href="Sep_BookShow.asp?ID=<%=rs("ID")%>" class="pro_view">查看</a>
	<a href="Sep_Book.asp?ID=<%=rs("ID")%>&Action=Del" onClick="return ConfirmDel();" class="pro_del">删除</a></td>
</tr>
<%
Rs.MoveNext
i=i+1
if i>maxPerPage then exit do
Loop
%>

</table>
</div>

<div class="wel_table">
<table class="nsw_pro_list">
<tr>
<td><input name="chkAll" type="checkbox" id="chkAll" onclick="CheckAll(this.form)" value="checkbox"> 全选
<input name="submit" type='submit' class="button3" value='删除选定的信息'> <input name="Action" type="hidden" id="Action" value="Del"></td>
</tr>
</table>
</div>
</form>

<%call pagelist()%>

<%
End If
rs.close
set rs=nothing
call CloseConn()
%>
</body>
</html>