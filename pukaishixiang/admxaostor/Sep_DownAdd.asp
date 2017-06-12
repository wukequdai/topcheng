<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Inc/Function.asp"-->
<!--#include file="Inc/admin_code_Down.asp"-->
<!--#include file="sep_ckeditor/ckeditor/ckeditor.asp"-->
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

if Request.QueryString("Action")="Add" then

	ClassID=DelStr(Trim(Request("ClassID")))
	Title=DelStr(Trim(Request.form("Title")))
	Keyword=KwdDelStr(Trim(Request.form("Keyword")))
	Content=Trim(Request.form("Content"))
	DownUrl=DelStr(Trim(Request.form("DownUrl")))
	
	if ClassID="" then
		founderr=true
		errmsg=errmsg & "未指定信息所属栏目<br />"
	end if

	If Title="" Then
		founderr=true
		errmsg=errmsg +"名称不能为空!<br />"
	end if

	If DownUrl="" Then
		founderr=true
		errmsg=errmsg + "文件地址不能为空!<br />"
	end If
	
	if founderr=false then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql="select * from Down"
		rs.open sql,conn,1,3
		rs.addnew
		rs("ClassID")=ClassID
		rs("Title")=Title
		rs("Keyword")=Keyword
		rs("Content")=Content
		rs("DownUrl")=DownUrl
		rs("UpdateTime")=now()
		rs.update
		rs.close
		call WriteSuccessMsg("添加","Sep_Down.asp?ClassID="&ClassID&"")
	else
		founderr=true
		call WriteErrMsg(errmsg)
	end if
end if
%>

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：下载管理 > 添加下载</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>

<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_Down.asp?ClassID=<%=ClassID%>" iconCls="icon-commonedit" plain="true">下载管理</a> 
            <a class="easyui-linkbutton" href="Sep_DownAdd.asp" iconCls="icon-add" plain="true">添加</a> 
		</div>
	</div>
</div>

<form method="post" name="myform" action="Sep_DownAdd.asp?Action=Add">
<div class="wel_table">
<table class="nsw_pro_list">
  <tr>
    <td width="150" height="22" align="right">所属类别：</td>
    <td><select name='ClassID'><option value=''>请选择所属的栏目</option><%call Admin_ShowClass_Option(3,ClassID)%></select>  
	<font color="#FF0000"><strong>请选择分类</strong> 不能指定为含有子栏目的栏目</font></td>
  </tr>
  <tr>
   <td height="22" align="right">文件名称：</div></td>
   <td> <input name="Title" type="text" size="80" maxlength="80" /></td>
  </tr>
  <%if SubKwdD=1 then%>
  <tr>
     <td height="22" align="right">关 键 字：</td>
     <td> <input name="Keyword" type="text" id="Keyword" size="60" maxlength="50" /> 
	 多个请用 <font color="#FF0000">空格</font> 或 <font color="#FF0000">|</font> 或 <font color="#FF0000">,</font> 隔开</td>
  </tr>
  <%end if%>
  <tr>
      <td align="right">文件地址： </td>
      <td> <input name="DownUrl" type="text" id="DownUrl" size="80" /></td>
  </tr>
  <tr>
    <td align="right">上传文件： </td><td><%call Sep_Upload("DownUrl",0,1)%></td>
  </tr>
  <%if SubContentD=1 then%>
  <tr>
    <td align="right" valign="top">下载说明：</td>
    <td><%call Sep_Editor("Content","")%></td>
  </tr>
  <%end if%>
  <tr>
     <td></td><td><input name="submit" type="submit" value="添加" class="button" /></td>
  </tr>
</form>
</table>
</div>

</body>
</html>