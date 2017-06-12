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

<%
FoundErr=false

Action=Request.QueryString("Action")
ClassID=Trim(Request("ClassID"))
ID=Trim(Request("ID"))
MaxPerPage=20   '每页显示记录数
page=Request("page")
strFileName="ClassID="&ClassID&"&"

if ClassID=1 then
	Sep_Title="链接"
elseif ClassID=2 then
	Sep_Title="合作"
end if
%>
<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：<%=Sep_Title%>管理</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
        <a class="easyui-linkbutton" href="Sep_Links.asp?ClassID=<%=ClassID%>" iconCls="icon-commonedit" plain="true">管理<%=Sep_Title%></a> 
        <a class="easyui-linkbutton" href="Sep_Links.asp?Action=Add&ClassID=<%=ClassID%>" iconCls="icon-add" plain="true">添加<%=Sep_Title%></a>
        </div>
    </div>
</div>
<%
if ID<>"" then
	if Action="Del" then
		conn.execute "Delete From Sep_Links Where ID=" & CLng(ID)
		Response.write "<script language=javascript>location='Sep_Links.asp?ClassID="&ClassID&"';</script> "
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
	if ClassID>0 then
		Set rs=Server.CreateObject("Adodb.RecordSet")
		sql="select * from Sep_Links where ClassID=" & ClassID&" order by ID"
		rs.open sql,conn,1,1
	end if
%>
<div class="wel_table">
   <table class="nsw_pro_list">
      <tr id="tabHeader">
        <td width="60" align="center"><strong>序号</strong></td>
        <td><strong><%=Sep_Title%>名称</strong></td>
        <td><strong>网站链接</strong></td>
        <td width="150" align="center"><strong>操作</strong></td>
      </tr>
    <%
    if rs.eof and rs.bof then
        response.Write "<tr><td class='forumrow' colspan=4 align='center'>暂时没有数据!</td></tr>"
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
        do while not rs.EOF
    %>
      <tr>
        <td align="center"><%=i%></td>
        <td><%=rs("Title")%></td>
        <td><a href="<%=rs("WebUrl")%>" target="_blank"><%=rs("WebUrl")%></a></td>
        <td align="center">
        <a href="Sep_Links.asp?Action=Modify&ID=<%=rs("ID")%>&ClassID=<%=ClassID%>" class="pro_edit">修改</a> 
        <a href="Sep_Links.asp?Action=Del&ID=<%=rs("ID")%>&ClassID=<%=ClassID%>" onClick="return ConfirmDel();" class="pro_del">删除</a>
        </td>
      </tr>
    <%
        Rs.MoveNext
		i=i+1
		if i>maxPerPage then exit do
		Loop
    end if
    %> 
    </table>
    </div>
<%
	call pagelist()
	rs.Close
	set rs=Nothing
End if
%>

<%sub Add()%>

<form method="post" name="myform" action="Sep_Links.asp?Action=SaveAdd">
<div class="wel_table">
    <table class="nsw_pro_list">
       <tr id="tabHeader">
          <th colspan="2">添加<%=Sep_Title%><input type="hidden" name="ClassID" value="<%=ClassID%>"></th>
        </tr>
        <tr>
          <td width="150" align="right"><strong><%=Sep_Title%>名称：</strong></td>
          <td><input type="text" name="Title" size="80" /></td>
        </tr>
        <%if ClassID=2 then%>
        <tr>
          <td align="right"><strong>网站LOGO：</strong></td>
          <td><input name="PicUrl" type="text" id="PicUrl" size="80" value="" /> </td>
        </tr>
        <tr>
          <td align="right"><strong>上传图片：</strong></td>
          <td><%call Sep_Upload("PicUrl",0,1)%></td>
        </tr>
        <%end if%>
        <tr>
          <td align="right"><strong>网站地址：</strong></td>
          <td><input type="text" name="WebUrl" size="80" /></td>
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
	ID=request.querystring("ID")
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open "Select * From Sep_Links where ID="&ID, conn,1,1
%>

<form method="post" name="myform" action="Sep_Links.asp?Action=SaveModify">
<div class="wel_table">
    <table class="nsw_pro_list">
       <tr id="tabHeader">
          <th colspan="2">更新<%=Sep_Title%><input type="hidden" name="ClassID" value="<%=rs("ClassID")%>"></th>
        </tr>    
        <tr>
          <td width="120" align="right"><strong><%=Sep_Title%>名称：</strong></td>
          <td><input type="text" name="Title" size="80" value="<%=rs("Title")%>" />
          <input type="hidden" name="ID" value="<%=rs("ID")%>"></td>
        </tr>
        <%if ClassID=2 then%>
        <tr>
          <td align="right"><strong>网站LOGO：</strong></td>
          <td><input name="PicUrl" type="text" id="PicUrl" size="50" value="<%=rs("PicUrl")%>" /> </td>
        </tr>
        <tr>
          <td align="right"><strong>上传图片：</strong></td>
          <td><%call Sep_Upload("PicUrl",0,1)%></td>
        </tr>
        <%end if%>
        <tr>
          <td align="right"><strong>网站地址：</strong></td>
          <td><input type="text" name="WebUrl" size="80" value="<%=rs("WebUrl")%>" /></td>
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
	WebUrl=DelStr(Trim(Request.Form("WebUrl")))
	PicUrl=DelStr(Trim(Request.Form("PicUrl")))
	
	if ClassID="" then
	  founderr=true
	  errmsg=errmsg +"未指定所属分类!<br />"
	end if
	
	If title="" Then
	  founderr=true
	  errmsg=errmsg +"请输网站名称!<br />"
	end If
	
	If WebUrl="" Then
	  founderr=true
	  errmsg=errmsg +"请输入网站地址!<br />"
	end if
	
	if founderr=false then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql="select * from Sep_Links"
		rs.open sql,conn,1,3
		rs.addnew
		rs("ClassID")=ClassID
		rs("title")=title
		rs("WebUrl")=WebUrl
		rs("PicUrl")=PicUrl
		rs.update
		call WriteSuccessMsg("添加","Sep_Links.asp?ClassID="&ClassID&"")
		rs.close
	else
		founderr=true
		call WriteErrMsg(errmsg)
	end if
end Sub

sub SaveModify()
	ID=DelStr(Trim(request("ID")))
	title=DelStr(Trim(request.Form("title")))
	WebUrl=DelStr(Trim(Request.Form("WebUrl")))
	PicUrl=DelStr(Trim(Request.Form("PicUrl")))
	
	If ID="" Then
	  founderr=true
	  errmsg=errmsg +"未指定ID<br />"
	end if
	
	if ClassID="" then
	  founderr=true
	  errmsg=errmsg +"未指定所属分类!<br />"
	end if
	
	If title="" Then
	  founderr=true
	  errmsg=errmsg +"请输入网站名称!<br />"
	end If
	
	If WebUrl="" Then
	  founderr=true
	  errmsg=errmsg +"请输入网站地址!<br />"
	end if
	
	if founderr=false then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql="select * from Sep_Links where ID="&ID
		rs.open sql,conn,1,3
		rs("ClassID")=ClassID
		rs("title")=title
		rs("WebUrl")=WebUrl
		rs("PicUrl")=PicUrl
		rs.update
		rs.close
		call WriteSuccessMsg("更新","Sep_Links.asp?ClassID="&ClassID&"")
	else
		founderr=true
		call WriteErrMsg(errmsg)
	end if
end sub
%>

</body>
</html>