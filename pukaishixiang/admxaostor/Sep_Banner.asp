<!--#include file="conn.asp"-->
<!--#include file="Admin.asp"-->
<!--#include file="inc/function.asp"-->
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

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：管理图片</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Sep_Banner.asp" iconCls="icon-commonedit" plain="true">管理图片</a> 
            <%If session(SiteSn & "AdminPurview")=1 Then%>
            <a class="easyui-linkbutton" href="Sep_Banner.asp?Action=Add" iconCls="icon-add" plain="true">添加图片</a> 
            <%end if%>
        </div>
    </div>
</div>
<%
FoundErr=false
dim strFileName
dim totalPut,CurrentPage,TotalPages
dim sql,rs,ID,LinkType
dim Action,FoundErr,errmsg
Action=trim(request("Action"))
ID=Trim(Request("ID"))
MaxPerPage=20   '每页显示记录数
page=Request("page")
strFileName=""

if ID<>"" then
	if Action="Del" then
		conn.execute "Delete From Sep_Banner Where ID=" & CLng(ID)
	end if
end if
%>
<script LANGUAGE="javascript">
function ConfirmDel()
{
   if(confirm("确定要删除此信息吗？"))
     return true;
   else
     return false;
}
</script>
<%
if Action="Add" then
	call Add()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
else

	sql="select * from Sep_Banner order by ID "
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
%>
<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <td width="50" align="center"><strong>序号</strong></td>
    <td width=""><strong>所在位置</strong></td>
    <td width="150" align="center"><strong>操作</strong></td>
  </tr>
<%
if rs.eof and rs.bof then
	response.write "<tr><td height=28 align='center' class='forumrow' colspan=3>对不起，暂时没有信息！</td></tr></table>"
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
    <td align="center" height="22"><%=rs("ID")%></td>
    <td><%If rs("PicUrl")<>"" then%>
    <span style="float:right;"><%=rs("FTitle")%>【<a href="<%=rs("PicUrl")%>" target="_blank" title="<%=rs("FTitle")%>">预览</a>】</span>
    <%End if%><%=rs("Title")%></td>
    <td align="center">
	<%
    response.write "<a href='Sep_Banner.asp?Action=Modify&ID=" & rs("ID") & "' class='pro_edit'>修改</a>"
    if session(SiteSn & "AdminPurview")=1 Then
	response.write " &nbsp;<a href='Sep_Banner.asp?Action=Del&ID=" & rs("ID") & "' onclick='return ConfirmDel();' class='pro_del'>删除</a>"
	end if
    %> </td>
  </tr>
<%
Rs.MoveNext
i=i+1
if i>maxPerPage then exit do
Loop
%>
</table>
</div>
<%
call pagelist()
End If
rs.close
set rs=nothing
End If

if FoundErr=True then
	call WriteErrMsg(errmsg)
end if

sub Add()
%>
<form method="post" name="myform" action="Sep_Banner.asp">
<div class="wel_table">
<table class="nsw_pro_list">
   <tr id="tabHeader">
      <th colspan="2" align="center">添加图片信息</th>
  </tr>
  <tr>
    <td width="150" align="right"><strong>所在位置：</strong></td>
    <td width="">
    <input name="Title" type="text" id="Title" size="60"  />
    <font color="#FF0000"> *</font></td>
  </tr>
  <tr>
      <td align="right"><strong>图片地址： </strong></td>
      <td><input name="PicUrl" id="PicUrl" type="text" size="60" maxlength="60"></td>
  </tr>
  <tr>
      <td align="right"><strong>上传图片： </strong></td>
      <td><%call Sep_Upload("PicUrl",0,1)%></td>
  </tr>
  <tr>
    <td align="right"><strong>图片描述：</strong></td>
    <td>
      <input name="FTitle" type="text" id="FTitle" size="60" /></td>
  </tr>
  <tr>
    <td align="right"><strong>图片链接：</strong></td>
    <td><input name="WebUrl" type="text" size="60">
    <font color="#FF0000">注意：外部地址请以http://开头</font></td>
  </tr>
  <tr>
    <td></td>
    <td>
      <input name="Action" type="hidden" id="Action" value="SaveAdd">
      <input type="submit" value="添加" name="cmdOk" class="button">
    </td>
  </tr>
</table>
</div>
</form>
<%
end sub

sub Modify()
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "请指定图片ID</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	dim sqlPic,rsPic
	sqlPic="select * from Sep_Banner where ID=" & ID
	set rsPic=Server.CreateObject("Adodb.RecordSet")
	rsPic.open sqlPic,conn,1,3
	if rsPic.bof and rsPic.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "找不到图片！</li>"
		rsPic.close
		set rsPic=nothing
		exit sub
	end if

%>
<form method="post" name="myform" action="Sep_Banner.asp">
<div class="wel_table">
<table class="nsw_pro_list">
   <tr id="tabHeader">
      <th colspan="2" align="center">修改图片信息</span></th>
    </tr>
    <tr>
      <td width="150" align="right" valign="middle"><strong>图片位置：</strong></td>
      <td width="">
        <input name="Title" type="text" id="Title" size="60" value="<%=rsPic("Title")%>" />
		<font color="#FF0000"> *</font></td>
    </tr>
    <tr>
      <td align="right"><strong>图片地址： </strong></td>
      <td><input name="PicUrl" id="PicUrl" type="text" value="<%=rsPic("PicUrl")%>" size="60" maxlength="60">  </td>
    </tr>
	<tr>
      <td align="right"><strong>上传图片： </strong></td>
      <td><%call Sep_Upload("PicUrl",0,1)%></td>
    </tr>
    <tr>
      <td align="right" valign="middle"><strong>图片描述：</strong></td>
      <td>
      <input name="FTitle" type="text" id="FTitle" size="60" value="<%=rsPic("FTitle")%>" /> </td>
    </tr>
    <tr>
      <td align="right"><strong>图片链接：</strong></td>
      <td>
      <input name="WebUrl" type="text" value="<%=rsPic("WebUrl")%>" size="60" />
      <font color="#FF0000">注意：外部地址请以http://开头</font></td>
    </tr>
    <tr>
      <td></td>
      <td>
      <input name="ID" type="hidden" id="ID" value="<%=rsPic("ID")%>">
      <input name="Action" type="hidden" id="Action" value="SaveModify"> 
      <input type="submit" value="修改" name="cmdOk" class="button">
      </td>
    </tr>
</table>
</div>
</form>
<%
	rsPic.close
	set rsPic=nothing
end sub
%>


<%
sub SaveAdd()
	dim Title,FTitle,Jiage,WebUrl,PicUrl
	Title=trim(request("Title"))
	FTitle=trim(request("FTitle"))
	PicUrl=trim(request("PicUrl"))
	WebUrl=trim(request("WebUrl"))
	
	if Title="" then
		FoundErr=True
		ErrMsg=ErrMsg & "图片所在位置不能为空！<br />"
	end if	
	
	if PicUrl="" then
		FoundErr=True
		ErrMsg=ErrMsg & "图片地址不能为空！<br />"
	end if
	
	if WebUrl="" then
		FoundErr=True
		ErrMsg=ErrMsg & "图片链接不能为空！<br />"
	end if

	if FoundErr=false then
		dim sqlPic,rsPic
		    set rsPic=Server.CreateObject("Adodb.RecordSet")
		   	sql="select * from Sep_Banner where (id is null)"
		    rsPic.open sql,conn,1,3
			rsPic.Addnew
			rsPic("Title")=Title
			rsPic("FTitle")=FTitle
			rsPic("PicUrl")=PicUrl
			rsPic("WebUrl")=WebUrl
			rsPic.update
			ID=rsPic("ID")
			rsPic.close
			set rsPic=nothing
			
			call CloseConn()	
			call WriteSuccessMsg("添加","Sep_Banner.asp")	
	else
		founderr=true
		call WriteErrMsg(errmsg)	
	end if
end sub

sub SaveModify()
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "请指定图片ID<br />"
		exit sub
	else
		ID=Clng(ID)
	end if
	dim Title,FTitle,WebUrl,PicUrl
	Title=trim(request("Title"))
	FTitle=trim(request("FTitle"))
	PicUrl=trim(request("PicUrl"))
	WebUrl=trim(request("WebUrl"))
	
	if Title="" then
		FoundErr=True
		ErrMsg=ErrMsg & "图片所在位置不能为空！<br />"
	end if

	if PicUrl="" then
		FoundErr=True
		ErrMsg=ErrMsg & "图片地址不能为空！<br />"
	end if
	
	if WebUrl="" then
		FoundErr=True
		ErrMsg=ErrMsg & "图片链接不能为空！<br />"
	end if

	if FoundErr=false then
		dim sqlPic,rsPic
		sqlPic="select * from Sep_Banner where ID=" & ID
		set rsPic=Server.CreateObject("Adodb.RecordSet")
		rsPic.open sqlPic,conn,1,3
		if rsPic.bof and rsPic.eof then
			FoundErr=True
			ErrMsg=ErrMsg & "找不到图片！<br />"
		else
			
			rsPic("Title")=Title
			rsPic("FTitle")=FTitle
			rsPic("PicUrl")=PicUrl
			rsPic("WebUrl")=WebUrl
				
			rsPic.update
			rsPic.close
			set rsPic=nothing
			
			call CloseConn()	
			call WriteSuccessMsg("更新","Sep_Banner.asp")	
		end if
		rsPic.close
		set rsPic=nothing
	else
		founderr=true
		call WriteErrMsg(errmsg)
	end if
end sub
%>
</body>
</html>
