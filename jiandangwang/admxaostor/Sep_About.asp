<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Inc/Function.asp"-->
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

Action=Request.QueryString("Action")
ClassID=Trim(Request("ClassID"))
AID=Trim(Request("AID"))
%>
<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：单页 > 栏目管理</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_About.asp?ClassID=<%=ClassID%>" iconCls="icon-commonedit" plain="true">管理栏目</a> 
            <%If session(SiteSn & "AdminPurview")=1 Then%>
            <a class="easyui-linkbutton" href="Sep_About.asp?Action=Add&ClassID=<%=ClassID%>" iconCls="icon-add" plain="true">添加栏目</a>
            <%end if%>
        </div>
    </div>
</div>
<%
if AID<>"" then
	if Action="Del" then
		conn.execute "Delete From Sep_About Where AID=" & CLng(AID)
		Response.write "<script language=javascript>location='Sep_About.asp?ClassID="&ClassID&"';</script> "
	end if
end If

if Action="Add" then
	call Add()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
else
	call main()
end if


sub main()
	
	if ClassID>0 then
		Set rs=Server.CreateObject("Adodb.RecordSet")
		sql="select * from Sep_About where ClassID=" & ClassID&" order by OrderID desc, Aid"
		rs.open sql,conn,1,1
	end if
%>
<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <td width="60" align="center"><strong>排序</strong></td>
    <td><strong>信息名称</strong></td>
    <td width="150" align="center"><strong>操作</strong></td>
  </tr>
    <%
    if rs.eof and rs.bof then
        response.Write "<tr><td class='forumrow' colspan=4 align='center'>暂时没有数据!</td></tr>"
    else
        i=1
        do while not rs.EOF
    %>
      <tr>
        <td align="center"><%=i%></td>
        <td><%=rs("Title")%></td>
        <td align="center">
        <a href="Sep_About.asp?Action=Modify&AID=<%=rs("AID")%>&ClassID=<%=ClassID%>" class="pro_edit">修改</a> 
        <%If session(SiteSn & "AdminPurview")=1 Then%>
        <a href="Sep_About.asp?Action=Del&AID=<%=rs("AID")%>&ClassID=<%=ClassID%>" onClick="return ConfirmDel();" class="pro_del">删除</a>
        <%end if%>
        </td>
      </tr>
    <%
        rs.movenext
        i=i+1
        loop
    end if
    %> 
    </table>
</div>
<%
	rs.Close
	set rs=Nothing
End sub
%>

<%sub Add()%>
<form method="post" name="myform" action="Sep_About.asp?Action=SaveAdd">
<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <th colspan="2">添加信息<input type="hidden" name="ClassID" value="<%=ClassID%>"></th>
  </tr>
  <tr>
    <td width="120" align="right"><strong>信息名称：</strong></td>
    <td><input type="text" name="Title" size="80" /></td>
  </tr>
  <%if SubBanner=1 then%>
  <tr>
    <td align="right">栏目图片： </td>
    <td><input name="PicUrl" type="text" id="PicUrl" size="50" value="" /> </td>
  </tr>
  <tr>
    <td align="right">上传图片： </td>
    <td><%call Sep_Upload("PicUrl",0,1)%></td>
  </tr>
  <%end if%>
  <tr>
    <td align="right" valign="top"><strong>信息内容：</strong><br />
    换行请按Shift+Enter<br />	  另起一段请按Enter</td>
    <td><%call Sep_Editor("Content","")%></td>
  </tr>
  <tr>
    <td align="right"><strong>栏目排序：</strong></td>
    <td><input type="text" name="OrderID" size="5" /> 数字越大，排列越靠前</td>
  </tr>
  <tr>
    <td></td>
    <td><input name="submit1" type="submit" class="button" value="添加"></td>
  </tr>
</table>
</div>
</form>

<%end sub%>

<%
sub Modify()
	Aid=request.querystring("Aid")
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open "Select * From Sep_About where Aid="&Aid, conn,1,1
%>
<form method="post" name="myform" action="Sep_About.asp?Action=SaveModify">
<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <th colspan="2">更新信息<input type="hidden" name="ClassID" value="<%=rs("ClassID")%>"></th>
  </tr>    
  <tr>
    <td width="120" align="right"><strong>信息名称：</strong></td>
    <td><input type="text" name="Title" size="80" value="<%=rs("Title")%>" />
    <input type="hidden" name="Aid" value="<%=rs("Aid")%>"></td>
  </tr>
  <%if SubBanner=1 then%>
  <tr>
    <td align="right"><strong>栏目图片：</strong></td>
    <td><input name="PicUrl" type="text" id="PicUrl" size="50" value="<%=rs("PicUrl")%>" /> </td>
  </tr>
  <tr>
    <td align="right"><strong>上传图片：</strong></td>
    <td><%call Sep_Upload("PicUrl",0,1)%></td>
  </tr>
  <%end if%>
  <tr>
    <td align="right" valign="top"><strong>信息内容：</strong><br />
    换行请按Shift+Enter<br />	  另起一段请按Enter</td>
    <td><%call Sep_Editor("Content",CheckEmpty(rs("Content")))%></td>
  </tr>
  <tr>
    <td align="right"><strong>栏目排序：</strong></td>
    <td><input type="text" name="OrderID" size="5" value="<%=rs("OrderID")%>" /> 数字越大，排列越靠前</td>
  </tr>
  <tr>
    <td></td>
    <td><input name="submit1" type="submit" class="button" value="更新"></td>
  </tr>
</table>
</div>
</form>
<%end sub%>


<%
sub SaveAdd()
	title=DelStr(Trim(request.Form("title")))
	PicUrl=DelStr(Trim(Request.Form("PicUrl")))
	Content=Trim(Request.Form("Content"))
	OrderID=DelStr(Trim(Request.Form("OrderID")))
	
	if ClassID="" then
	  founderr=true
	  errmsg=errmsg &"未指定所属栏目!<br />"
	end if
	
	If title="" Then
	  founderr=true
	  errmsg=errmsg &"请输入栏目名称!<br />"
	end If
	
	If Content="" Then
	  founderr=true
	  errmsg=errmsg +"请输入栏目内容!<br />"
	end if
	
	if OrderID="" then
		OrderID=0
	end if
	
	if founderr=false then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql="select * from Sep_About"
		rs.open sql,conn,1,3
		rs.addnew
		rs("ClassID")=ClassID
		rs("title")=title
		rs("PicUrl")=PicUrl
		rs("Content")=Content
		rs("OrderID")=OrderID
		rs.update
		call WriteSuccessMsg("添加","Sep_About.asp?ClassID="&ClassID&"")
		rs.close
	else
		founderr=true
		call WriteErrMsg(errmsg)
	end if
end Sub

sub SaveModify()
	Aid=DelStr(Trim(request("Aid")))
	title=DelStr(Trim(request.Form("title")))
	PicUrl=DelStr(Trim(Request.Form("PicUrl")))
	Content=Trim(Request.Form("Content"))
	OrderID=DelStr(Trim(Request.Form("OrderID")))
	
	If Aid="" Then
	founderr=true
	errmsg=errmsg +"未指定栏目ID<br />"
	end if
	
	if ClassID="" then
	founderr=true
	errmsg=errmsg +"未指定所属栏目!<br />"
	end if
	
	If title="" Then
	founderr=true
	errmsg=errmsg +"请输入栏目名称!<br />"
	end If
	
	If Content="" Then
	founderr=true
	errmsg=errmsg +"请输入栏目内容!<br />"
	end if
	
	if OrderID="" then
		OrderID=0
	end if
	
	if founderr=false then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql="select * from Sep_About where Aid="&Aid
		rs.open sql,conn,1,3
		rs("ClassID")=ClassID
		rs("title")=title
		rs("PicUrl")=PicUrl
		rs("Content")=Content	
		rs("OrderID")=OrderID
		rs.update
		rs.close
		call WriteSuccessMsg("更新","Sep_About.asp?ClassID="&ClassID&"")
	else
		founderr=true
		call WriteErrMsg(errmsg)
	end if
end sub
%>
</body>
</html>