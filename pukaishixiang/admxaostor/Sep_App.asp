<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Inc/Function.asp"-->
<!--#include file="Inc/admin_code_app.asp"-->
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
function ConfirmTui()
{
   if(confirm("你确定要取消该推荐吗！"))
     return true;
   else
     return false;

}
function ConfirmTui2()
{
   if(confirm("你确定要设置为推荐吗！"))
     return true;
   else
     return false;

}

function ConfirmOrder()
{
   if(confirm("确定要更新信息排序吗？"))
     return true;
   else
     return false;

}

function CheckForm(f){
with (f){ 
  var s1='';
  var ohide=$Xaos("OrderID");
  for(var i=0;i <ohide.length;i++){
    s1=(s1.length==0)?document.getElementsByName("OrderID")[i].value:s1+","+document.getElementsByName("OrderID")[i].value;
  }
  OrderID.value=s1;
  
  var s2='';
  var ohide2=$Xaos("TempID");
  for(var i=0;i <ohide2.length;i++){
    s2=(s2.length==0)?document.getElementsByName("TempID")[i].value:s2+","+document.getElementsByName("TempID")[i].value;
  }
  TempID.value=s2;
 }
}
</SCRIPT>
<body>
<%
Sep_Title=SubTitleA
FileName="Sep_App.asp"

ClassID=Trim(request("ClassID"))
strFileName="ClassID="&ClassID&"&"
MaxPerPage=10   '每页显示记录数
page=Request("page")
Set Rs=Server.CreateObject("adodb.recordset")
sql="select * from App where ID>0"

if len(ClassID)>0 then
	sqlClass="select RootID,ParentID,ParentPath,ClassID,ClassName,Depth From AppClass where ClassID=" & ClassID
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
	  set trs=conn.execute("select ClassID from AppClass where ParentID=" & ClassID & " or ParentPath like '%" & ParentPath & "," & ClassID & ",%'")
	else
	  set trs=conn.execute("select ClassID from AppClass where RootID=" & RootID & " and Depth>0 " )
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

sql=sql & " order by OrderID desc, ID desc"
rs.open sql,conn,1,1
%>

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：<%call Admin_ShowPath(""&Sep_Title&"管理",ParentPath,ClassID)%></span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_App.asp?ClassID=<%=ClassID%>" iconCls="icon-commonedit" plain="true"><%=Sep_Title%>管理</a> 
            <a class="easyui-linkbutton" href="Sep_AppAdd.asp" iconCls="icon-add" plain="true">添加<%=Sep_Title%></a> 
        </div>
    </div>
</div>
<form name="del" method="Post" action="Sep_AppDel.asp" onSubmit="return ConfirmDel();">
<div class="wel_table">
<table class="nsw_pro_list">
  <tr>
    <td colspan="5"><%call Admin_ShowRootClass(RootID,ClassID)%><span style="float:right; color:#F00;">排序：数字越大越靠前</span></td>
  </tr>
  <tr id="tabHeader">
      <td width="45" align="center"><strong>选中</strong></td>
      <td width="*" ><strong><%=Sep_Title%>标题</strong></td>
      <td width="100" align="center" ><strong>排序</strong></td>
      <td width="100" align="center" ><strong>加入时间</strong></td>
      <td width="200" align="center" ><strong>操作</strong></td>
  </tr>
<%
if rs.eof and rs.bof then
	response.write "<tr><td height=28 align='center' class=""forumrow"" colspan=5>对不起，没有找到相关信息！</td></tr></table>"
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
	<td align="center"><input name='ID' type='checkbox' onClick="unselectall()" id="ID" value='<%=cstr(rs("ID"))%>'></td>
	<td><%=rs("title")%><%if rs("Elite")=1 then%><font color="#ff0000">【荐】</font><%end if%></td>
    <td align="center"><input name="TempID" type="hidden" id="TempID" value="<%=rs("ID")%>">
    <input name="OrderID" type="text" value="<%=rs("OrderID")%>" size="5" onKeyUp="value=value.replace(/[^\d]/g,'')" /></td>
	<td align="center"><%= FormatDateTime(rs("UpdateTime"),2) %></td>
	<td align="center">
    <%if SubEliteA=1 then%>
		<%if rs("Elite")=1 then%>
            <a href="Sep_AppDel.asp?ID=<%=rs("ID")%>&Action=tuino&ClassID=<%=rs("ClassID")%>" onClick="return ConfirmTui();" class="pro_rec">已荐</a>
        <%else%>
            <a href="Sep_AppDel.asp?ID=<%=rs("ID")%>&Action=tui&ClassID=<%=rs("ClassID")%>" onClick="return ConfirmTui2();" class="pro_rec2">推荐</a>
        <%end if%>
    <%end if%>
	<a href="Sep_AppModify.asp?ID=<%=rs("ID")%>&ClassID=<%=ClassID%>" class="pro_edit">修改</a>
	<a href="Sep_AppDel.asp?ID=<%=rs("ID")%>&Action=Del&ClassID=<%=ClassID%>" onClick="return ConfirmDel();" class="pro_del">删除</a></td>
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
<td><input name="chkAll" type="checkbox" id="chkAll" onClick="CheckAll(this.form)" value="checkbox">
<input name="ClassID" type="hidden" id="ClassID" value="<%=ClassID%>"> 全选
<input name="button" type='button' class="button3" value='删除选定的信息' onClick="this.form.action='Sep_AppDel.asp?Action=Del';this.form.submit();return ConfirmDel();">
<input name="button" type='button' class="button4" value='保存输入的排序' onClick="this.form.action='Sep_AppDel.asp?Action=Order';this.form.submit();return ConfirmOrder();"></td>
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