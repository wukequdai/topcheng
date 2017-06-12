<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="Inc/Function.asp"-->
<!--#include file="Inc/admin_code_Down.asp"-->
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
function ConfirmDel()
{
   if(confirm("确定要删除选中的信息吗？一旦删除将不能恢复！"))
     return true;
   else
     return false;

}
</SCRIPT>

<%
FileName="Sep_Down.asp"
ClassID=Trim(request("ClassID"))
strFileName="ClassID="&ClassID&"&"
MaxPerPage=10   '每页显示记录数
page=Request("page")
Set Rs=Server.CreateObject("adodb.recordset")
sql="select * from Down where id>0"

if len(ClassID)>0 then
	sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassName,Depth From DownClass where ClassID=" & ClassID
	set tClass=conn.execute(sqlClass)
	
	if tClass.bof and tClass.eof then
		FoundErr=True
		Response.write "<script language=javascript>alert('找不到指定的类别!');window.parent.location.reload();</script> "
		response.end
	else			    	
		RootID=tClass(0)	
		ParentID=tClass(1)	
		ParentPath=tClass(2)
		ClassID=tClass(3)
		ClassName=tClass(4)
		Depth=tClass(5)
	end if
	tClass.close

	arrClassID=ClassID
	if ParentID>0 then
	  set trs=conn.execute("select ClassID from DownClass where ParentID=" & ClassID & " or ParentPath like '%" & ParentPath & "," & ClassID & ",%'")
	else
	  set trs=conn.execute("select ClassID from DownClass where RootID=" & RootID & " and Depth>0 " )
	end if
	if not trs.eof then
	  do while not trs.eof
	   arrClassID=arrClassID & "," & trs(0)
	  trs.movenext
	  loop				
	  trs.close
	  sql=sql & " and ClassID in (" & arrClassID & ")"
	else
	  sql=sql & " and ClassID=" & ClassID
	end if	
end if

sql=sql & " order by ID desc"		
rs.open sql,conn,1,1
%>
<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：<%call Admin_ShowPath("下载管理",ParentPath,ClassID)%></span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
        <a class="easyui-linkbutton" href="Sep_Down.asp?ClassID=<%=ClassID%>" iconCls="icon-commonedit" plain="true">下载管理</a> 
        <a class="easyui-linkbutton" href="Sep_DownAdd.asp" iconCls="icon-add" plain="true">添加下载</a>
        </div>
	</div>
</div>
<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <td width="50" align="center"><strong>ID</strong></td>
    <td><strong>文件名称</strong></td>
    <td width="100" align="center"><strong>下载次数</strong></td>
    <td width="100" align="center"><strong>添加时间</strong></td>
    <td width="150" align="center"><strong>操作</strong></td>
  </tr>
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
response.write "<tr><td height=28 align='center' colspan=5 class=forumrow>对不起，没有找到相关信息！</td></tr></table>"
else
do while not Rs.eof
%>
<tr>
  <td align="center"><%=i%></td>
  <td><%=rs("title")%></td>
  <td align="center"><%=rs("hits")%></td>
  <td align="center"><%= FormatDateTime(rs("UpdateTime"),2) %></td>
  <td align="center">
  <a href="Sep_DownEdit.asp?id=<%=rs("id")%>&ClassID=<%=ClassID%>" class="pro_edit">修改</a>  
  <a href="Sep_DownDel.asp?Action=Del&id=<%=rs("id")%>&ClassID=<%=ClassID%>" onClick="return ConfirmDel();" class="pro_del">删除</a></td></tr>
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
rs.close
set rs=nothing
call CloseConn()
%>

</body>
</html>