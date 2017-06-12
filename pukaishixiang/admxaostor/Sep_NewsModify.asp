<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Inc/Function.asp"-->
<!--#include file="inc/admin_code_news.asp"-->
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
Sep_Title=SubTitleN
dim id,rs,FoundErr,ErrMsg
id=trim(request("id"))
ClassID=Trim(Request("ClassID"))

FoundErr=False
if id="" then
	response.Redirect("Sep_News.asp")
end if
sql="select * from News where id=" & id & ""
Set rs= Server.CreateObject("ADODB.Recordset")
rs.open sql,conn,1,1
if FoundErr=True then
	call WriteErrMsg()
else
%>
<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：<%=Sep_Title%>管理 > 更新<%=Sep_Title%></span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>

<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_News.asp?ClassID=<%=ClassID%>" iconCls="icon-commonedit" plain="true"><%=Sep_Title%>管理</a> 
            <a class="easyui-linkbutton" href="Sep_NewsAdd.asp" iconCls="icon-add" plain="true">添加<%=Sep_Title%></a> 
        </div>
    </div>
</div>

<form method="POST" name="myform" action="Sep_NewsSave.asp">
<input name="Action" type="hidden" value="SaveModify" />
<div class="wel_table">
<table class="nsw_pro_list">
  <tr>
    <td width="120" align="right">所属类别：</td>
    <td width=""><select name='ClassID'><option value=''>请选择所属的栏目</option><%call Admin_ShowClass_Option(3,rs("ClassID"))%></select> 
	<font color="#FF0000"><strong>请选择分类</strong> 不能指定为含有子栏目的栏目</font></td>
  </tr>
  <tr>
    <td align="right"><%=Sep_Title%>标题：</td>
    <td> <input name="Title" type="text" id="Title" value="<%=rs("Title")%>" size="80" maxlength="80" /></strong></td>
  </tr>
  <%if SubKwdN=1 then%>
  <tr>
      <td align="right">关 键 字：</td>
      <td> <input name="Keyword" type="text" id="Keyword" size="60" maxlength="50" value="<%=rs("Keyword")%>" /> 
	  多个请用 <font color="#FF0000">空格</font> 或 <font color="#FF0000">|</font> 或 <font color="#FF0000">,</font> 隔开</td>
  </tr>
  <%end if%>
  <%if SubEliteN=1 then%>
  <tr>
    <td align="right">是否推荐：</td>
    <td><input name="Elite" type="checkbox" id="Elite" value="yes" <% if rs("Elite")=1 then response.Write("checked") end if%> /> 
    是（<font color="#FF0000">如选中将在首页显示</font>）</td>
  </tr>
  <%end if%>
  <%if SubCanshuN=1 then%>
  <tr>
      <td align="right" valign="top"><%=Sep_Title%>简述：</td>
      <td><textarea name="Canshu" style="width:98%; height:50px;"><%=rs("Canshu")%></textarea></td>
  </tr>
  <%end if%>
  <tr>
    <td align="right" valign="top"><%=Sep_Title%>内容：</td>
    <td><%call Sep_Editor("Content",CheckEmpty(rs("Content")))%></td>
  </tr>
  <%if SubPicN=1 then%>
  <tr>
    <td align="right"><%=Sep_Title%>图片： </td>
    <td><input name="PicUrl" type="text" id="PicUrl" size="50" value="<%=rs("PicUrl")%>" /> </td>
  </tr>
  <tr>
    <td align="right" valign="top">上传图片： </td>
    <td valign="top"><%call Sep_Upload("PicUrl",1,1)%></td>
  </tr>
  <%end if%>
  <tr>
    <td align="right">排列顺序：</td>
    <td><input name="OrderID" type="text" id="OrderID" size="5" maxlength="5" value="<%=rs("OrderID")%>" /> 
	<font color="#FF0000">只能填数字，数字越大越靠前</font></td>
  </tr>
  <tr>
      <td></td>
      <td>
    <input name="ID" type="hidden" id="ID" value="<%=rs("ID")%>" />
    <input name="Hits" type="hidden" id="Hits" value="<%=rs("Hits")%>" />
    <input name="UpdateTime" type="hidden" id="UpdateTime" value="<%=rs("UpdateTime")%>" />
    <input  name="Save" type="submit"  id="Save" value="更新" class='button' />
    <input name="Cancel" type="button" id="Cancel" value="取消" onClick="window.location.href='Sep_News.asp?ClassID=<%=ClassID%>'" class="button" />

    </td>
  </tr>
</table>
</div>
</form>
<%
end if
rs.close
set rs=nothing
call CloseConn()
%>
</body>
</html>