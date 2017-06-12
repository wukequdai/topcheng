<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_Down.asp"-->
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
    <span class="nsw_add">当前位置：下载分类 > 栏目管理</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<%
dim Action,ParentID,LayoutID,BrowsePurview,AddPurview,i,FoundErr,ErrMsg
dim SkinCount,LayoutCount
FoundErr=false
Action=trim(Request("Action"))
ParentID=trim(request("ParentID"))
if ParentID="" then
	ParentID=0
else
	ParentID=CLng(ParentID)
end if
%>
<%
if Action="Add" then
	call AddClass()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
elseif Action="Move" then
	call MoveClass()
elseif Action="SaveMove" then
	call SaveMove()
elseif Action="Del" then
	call DeleteClass()
elseif Action="Clear" then
	call ClearClass()
elseif Action="UpOrder" then
	call UpOrder()
elseif Action="DownOrder" then
	call DownOrder()
elseif Action="Order" then
	call Order()
elseif Action="UpOrderN" then
	call UpOrderN()
elseif Action="DownOrderN" then
	call DownOrderN()
elseif Action="OrderN" then
	call OrderN()
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg(errmsg)
end if
call CloseConn()


sub main()
	dim arrShowLine(10)
	for i=0 to ubound(arrShowLine)
		arrShowLine(i)=False
	next
	dim sqlClass,rsClass,i,iDepth
	sqlClass="select * From DownClass where Depth=0 order by RootID,OrderID"
	set rsClass=server.CreateObject("adodb.recordset")
	rsClass.open sqlClass,conn,1,1
%>


<script language="JavaScript" type="text/JavaScript">
function ConfirmDel1()
{
   alert("此栏目下还有子栏目，必须先删除下属子栏目后才能删除此栏目！");
   return false;
}

function ConfirmDel2()
{
   if(confirm("删除栏目将同时删除此栏目中的所有产品，并且不能恢复！确定要删除此栏目吗？"))
     return true;
   else
     return false;

}
function ConfirmDel3()
{
   if(confirm("清空栏目将把栏目（包括子栏目）的所有产品放入回收站中！确定要清空此栏目吗？"))
     return true;
   else
     return false;

}
</script>
<script src="images/jquery.nav.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
    $("#category_nav div.sub-menu-head").click(function() {
    $(this).css({}).next("div.sub-menu-body").slideToggle(300).siblings("div.sub-menu-body").slideUp("slow");
    });
});
</script>
<div class="bord_gray">
    <div class="graybar_one f_cb">
        <div class="wel_name">
            <a class="easyui-linkbutton" href="Admin_Class_Down.asp" iconCls="icon-commonedit" plain="true">栏目管理</a> 
            <a class="easyui-linkbutton" href="Admin_Class_Down.asp?Action=Add" iconCls="icon-add" plain="true">添加栏目</a> 
            <%If session(SiteSn & "AdminPurview")=1 Then%>
            <a class="easyui-linkbutton" href="Admin_Class_Down.asp?Action=Order" iconCls="icon-order" plain="true">一级栏目排序</a> 
            <a class="easyui-linkbutton" href="Admin_Class_Down.asp?Action=OrderN" iconCls="icon-ordern" plain="true">N级栏目排序</a>
            <%End If%>
		</div>
    </div>
</div>

<div class="wel_table">
<table class="nsw_pro_list">
   <tr id="tabHeader">
    <th><strong class="fl" style="padding-left:20px;">栏目名称</strong>
    <strong class="fr" style=" display:block; width:180px; text-align:center;">操作选项</strong></th>
  </tr>
  <tr id="tabBody">
    <td>
    <div id="category_nav">
    <%
    i=1
    do while not rsClass.eof

      response.Write "<div class='sub-menu-head'>"
	  response.Write "<span>"
	  'if rsClass("Depth")=0 then
      	'response.Write "<a href='Admin_Class_Down.asp?Action=Add&ParentID="&rsClass("ClassID")&"' class='pro_add'>添加子栏目</a>"
      'end if
      response.Write "<a href='Admin_Class_Down.asp?Action=Modify&ClassID="&rsClass("ClassID")&"' class='pro_edit'>修改</a>"
	  response.Write "<a href='Admin_Class_Down.asp?Action=Del&ClassID="&rsClass("ClassID")&"'"
	  if rsClass("Child")>0 then
      	response.Write " onClick='return ConfirmDel1();'"
	  else
	  	response.Write " onClick='return ConfirmDel2();'"
	  end if
      response.Write " class='pro_del'>删除</a>"
      response.Write "</span>"

	  if rsClass("Child")>0 then
	  	response.Write "<em class='close'></em>"
	  else
	  	response.Write "<em class='open'></em>"
	  end if	  
	  response.write "<strong>" & rsClass(1) & "</strong>"
	  if rsClass("Child")>0 then
	  	response.write "&nbsp;(" & rsClass("Child") & ")"
	  end if
	  response.Write "</div>"
	  
	  if rsClass("Child")>0 then
	  
	  	response.Write "<div class='sub-menu-body'><ul>"
		Set rsSmall= Server.CreateObject("ADODB.Recordset")
		sqlSmall="select ClassID,ClassName,ParentID,Depth,NextID,Child From DownClass where Depth>0 and RootID="&rsClass("RootID")&" order by RootID,OrderID"
		rsSmall.open sqlSmall,conn,1,1
		if not rsSmall.bof and not rsSmall.eof then	
		do while not rsSmall.eof
	 	
		tmpDepth=rsSmall("Depth")
		tmpNextID=rsSmall("NextID")
		
		if tmpDepth=1 then
			if tmpNextID>0 then
			  response.Write "<li class='tree1'>"
			else
			  response.Write "<li class='tree2'>"
			end if
		else
			response.Write "<li class='tree3'>"
			if tmpNextID>0 then
			  response.Write "<img src='images/Sort_File2.gif' align='absmiddle' class='fl'>"
			else
			  response.Write "<img src='images/Sort_File_End2.gif' align='absmiddle' class='fl'>"
			end if
		end if
		
		response.Write "<span>"
		'if rsSmall("Depth")=1 then
           'response.Write "<a href='Admin_Class_Down.asp?Action=Add&ParentID="&rsSmall("ClassID")&"' class='pro_add'>添加子栏目</a>"
        'end if
        response.Write "<a href='Admin_Class_Down.asp?Action=Modify&ClassID="&rsSmall("ClassID")&"' class='pro_edit'>修改</a>"
        response.Write "<a href='Admin_Class_Down.asp?Action=Del&ClassID="&rsSmall("ClassID")&"'"
		if rsSmall("Child")>0 then
		   response.Write " onClick='return ConfirmDel1();'"
		else
		   response.Write " onClick='return ConfirmDel2();'"
		end if
		response.Write " class='pro_del'>删除</a>"
		response.Write "</span>"

		response.Write rsSmall(1)
		if rsSmall("Depth")=1 then 
			response.Write "&nbsp;(" & rsSmall("Child") & ")"
		end if
		response.Write "</li>"
		rsSmall.movenext
		loop
	  end if
	  rsSmall.close
	  set rsSmall=nothing	
	  response.Write "</ul></div>"	
	end if

	rsClass.movenext
	i=i+1
	loop
	%>
	</div><!--end category-->
    </td>
  </tr>
</table>  
</div>
<%
end sub

sub AddClass()
%>
<form name="myform" method="post" action="Admin_Class_Down.asp" onSubmit="return check()">
<div class="wel_table">
<table class="nsw_pro_list">
    <tr id="tabHeader">
      <th colspan="2">添加栏目</th>
    </tr>
    <tr>
      <td width="120" align="center"><strong>所属栏目：</strong></td>
      <td>&nbsp;<select name="ParentID">
          <%call Admin_ShowClass_Option(0,ParentID)%>
      </select> 
      不能指定为外部栏目 </td>
    </tr>
    <tr>
      <td align="center"><strong>栏目名称：</strong></td>
      <td>&nbsp;<input name="ClassName" type="text" size="40"></td>
    </tr>
    <tr>
      <td height="40"></td>
      <td style="padding:10px;">
      <input name="Action" type="hidden" id="Action" value="SaveAdd">
      <input name="Add" type="submit" value="添加" class="button"> 
      <input name="Cancel" type="button" id="Cancel" value="取消" onClick="window.location.href='Admin_Class_Down.asp'" class="button">
      </td>
    </tr>
  </table>
  </div>
</form>

<script language="JavaScript" type="text/JavaScript">
function check()
{
  if (document.form1.ClassName.value=="")
  {
    alert("栏目名称不能为空！");
	document.form1.ClassName.focus();
	return false;
  }
}
</script>

<%
end sub

sub Modify()
	dim ClassID,sql,rsClass,i
	ClassID=trim(request("ClassID"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
		exit sub
	else
		ClassID=CLng(ClassID)
	end if
	sql="select * From DownClass where ClassID=" & ClassID
	set rsClass=server.CreateObject ("Adodb.recordset")
	rsClass.open sql,conn,1,3
	if rsClass.bof and rsClass.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>找不到指定的栏目！</li>"
	else
%>
<form name="myform" method="post" action="Admin_Class_Down.asp" onSubmit="return check()">
<div class="wel_table">
<table class="nsw_pro_list">
    <tr id="tabHeader">
      <th colspan="2">修改栏目</th>
    </tr>
    <tr>
      <td width="150" align="center"><strong>所属栏目：</strong></td>
      <td>&nbsp;
	  <%
	if rsClass("ParentID")<=0 then
	  	response.write "无（作为一级栏目）"
	else
    	dim rsParentClass,sqlParentClass
		sqlParentClass="Select * From DownClass where ClassID in (" & rsClass("ParentPath") & ") order by Depth"
		set rsParentClass=server.CreateObject("adodb.recordset")
		rsParentClass.open sqlParentClass,conn,1,1
		do while not rsParentClass.eof
			for i=1 to rsParentClass("Depth")
				response.write "&nbsp;&nbsp;&nbsp;"
			next
			if rsParentClass("Depth")>0 then
				response.write "└"
			end if
			response.write "&nbsp;" & rsParentClass("ClassName") & ""
			rsParentClass.movenext
		loop
		rsParentClass.close
		set rsParentClass=nothing
	end if
	%>
    <span style="margin-left:100px;">
    	如果想改变所属栏目，请 <strong><a href='Admin_Class_Down.asp?Action=Move&ClassID=<%=ClassID%>'><font color="#ff0000">点此移动栏目</font></a></strong>
    </span></td>
    </tr>
    <tr>
      <td align="center"><strong>栏目名称：</strong></td>
      <td>&nbsp;<input name="ClassName" type="text" value="<%=rsClass("ClassName")%>" size="40">
      <input name="ClassID" type="hidden" id="ClassID" value="<%=rsClass("ClassID")%>"></td>
    </tr>    
    <tr>
      <td height="40"></td>
      <td style="padding:10px;">
      <input name="Action" type="hidden" id="Action" value="SaveModify">
      <input name="Submit" type="submit" value="修改" class="button">
      <input name="Cancel" type="button" id="Cancel" value="取消" onClick="window.location.href='Admin_Class_Down.asp'" class="button">
      </td>
    </tr>
  </table>
  </div>
</form>
<script language="JavaScript" type="text/JavaScript">
function check()
{
  if (document.form1.ClassName.value=="")
  {
    alert("栏目名称不能为空！");
	document.form1.ClassName.focus();
	return false;
  }
}
</script>
<%
	end if
	rsClass.close
	set rsClass=nothing
end sub

sub MoveClass()
	dim ClassID,sql,rsClass,i
	dim SkinID,LayoutID,BrowsePurview,AddPurview
	ClassID=trim(request("ClassID"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
		exit sub
	else
		ClassID=CLng(ClassID)
	end if

	sql="select * From DownClass where ClassID=" & ClassID
	set rsClass=server.CreateObject ("Adodb.recordset")
	rsClass.open sql,conn,1,3
	if rsClass.bof and rsClass.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>找不到指定的栏目！</li>"
	else
%>
<form name="form1" method="post" action="Admin_Class_Down.asp">
<div class="wel_table">
<table class="nsw_pro_list">
    <tr id="tabHeader">
      <th colspan="2">移动栏目</th>
    </tr>
    <tr>
      <td width="200"><strong>栏目名称：</strong></td>
      <td><%=rsClass("ClassName")%> <input name="ClassID" type="hidden" id="ClassID" value="<%=rsClass("ClassID")%>"></td>
    </tr>
    <tr>
      <td width="200"><strong>当前所属栏目：</strong></td>
      <td>
        <%
	if rsClass("ParentID")<=0 then
	  	response.write "无（作为一级栏目）"
	else
    	dim rsParent,sqlParent
		sqlParent="Select * From DownClass where ClassID in (" & rsClass("ParentPath") & ") order by Depth"
		set rsParent=server.CreateObject("adodb.recordset")
		rsParent.open sqlParent,conn,1,1
		do while not rsParent.eof
			for i=1 to rsParent("Depth")
				response.write "&nbsp;&nbsp;&nbsp;"
			next
			if rsParent("Depth")>0 then
				response.write "└"
			end if
			response.write "&nbsp;" & rsParent("ClassName") & ""
			rsParent.movenext
		loop
		rsParent.close
		set rsParent=nothing
	end if
	%>
      </td>
    </tr>
    <tr>
      <td width="200"><strong>移动到：</strong><br>
        不能指定为当前栏目的下属子栏目<br>
      不能指定为外部栏目</td>
      <td>
	  <select name="ParentID" size="2" style="height:300px;width:500px;">
	  <%call Admin_ShowClass_Option(ShowType,CurrentID)%></select>
	  </td>
    </tr>
    <tr>
      <td height="40"></td>
      <td height="40">
	  <input name="Action" type="hidden" id="Action" value="SaveMove">
        <input name="Submit" type="submit" value="移动" class="button">
        &nbsp;
      <input name="Cancel" type="button" id="Cancel" value="取消" onClick="window.location.href='Admin_Class_Down.asp'" class="button"></td></tr>
  </table>
  </div>
</form>
<%
	end if
	rsClass.close
	set rsClass=nothing
end sub

sub Order()
	dim sqlClass,rsClass,i,iCount,j
	sqlClass="select * From DownClass where ParentID=0 order by RootID"
	set rsClass=server.CreateObject("adodb.recordset")
	rsClass.open sqlClass,conn,1,1
	iCount=rsClass.recordcount
%>
<div class="wel_table">
<table class="nsw_pro_list">
    <tr id="tabHeader">
    <th colspan="4">一级栏目排序</th>
  </tr>
  <%
j=1
do while not rsClass.eof
%>
    <tr>
      <td width="200"><img src='images/tree_folder3.gif' width='15' height='15' valign='abvmiddle'> <b><%=rsClass("ClassName")%></b></td>
<%
	if j>1 then
  		response.write "<form action='Admin_Class_Down.asp?Action=UpOrder' method='post'><td width='250' >"
		response.write "<select name=MoveNum size=1><option value=0>向上移动</option>"
		for i=1 to j-1
			response.write "<option value="&i&">"&i&"</option>"
		next
		response.write "</select>"
		response.write "<input type=hidden name=ClassID value="&rsClass("ClassID")&">"
		response.write "<input type=hidden name=cRootID value="&rsClass("RootID")&">&nbsp;<input type=submit name=Submit value=修改 class=button2>"
		response.write "</td></form>"
	else
		response.write "<td width='250'>&nbsp;</td>"
	end if
	if iCount>j then
  		response.write "<form action='Admin_Class_Down.asp?Action=DownOrder' method='post'><td width='250'>"
		response.write "<select name=MoveNum size=1><option value=0>向下移动</option>"
		for i=1 to iCount-j
			response.write "<option value="&i&">"&i&"</option>"
		next
		response.write "</select>"
		response.write "<input type=hidden name=ClassID value="&rsClass("ClassID")&">"
		response.write "<input type=hidden name=cRootID value="&rsClass("RootID")&">&nbsp;<input type=submit name=Submit value=修改 class=button2>"
		response.write "</td></form>"
	else
		response.write "<td width='250'>&nbsp;</td>"
	end if
%>
      <td>&nbsp;</td>
	</tr>
  <%
	j=j+1
	rsClass.movenext
loop
%>
</table>
</div>
<%
	rsClass.close
	set rsClass=nothing
end sub

sub OrderN()
	dim sqlClass,rsClass,i,iCount,trs,UpMoveNum,DownMoveNum
	sqlClass="select * From DownClass order by RootID,OrderID"
	set rsClass=server.CreateObject("adodb.recordset")
	rsClass.open sqlClass,conn,1,1
%>
<div class="wel_table">
<table class="nsw_pro_list">
    <tr id="tabHeader">
    <th colspan="4">N级栏目排序</th>
  </tr>
  <%
do while not rsClass.eof
%>
    <tr>
      <td width="300">
	  <%
	for i=1 to rsClass("Depth")
	  	response.write "&nbsp;&nbsp;&nbsp;"
	next
	if rsClass("Child")>0 then
		response.write "<img src='images/tree_folder4.gif' width='15' height='15' valign='abvmiddle'>"
	else
	  	response.write "<img src='images/tree_folder3.gif' width='15' height='15' valign='abvmiddle'>"
	end if
	if rsClass("ParentID")=0 then
		response.write "<b>"
	end if
	response.write rsClass("ClassName")
	if rsClass("Child")>0 then
		response.write "(" & rsClass("Child") & ")"
	end if
	%></td>
<%
	if rsClass("ParentID")>0 then   '如果不是一级栏目，则算出相同深度的栏目数目，得到该栏目在相同深度的栏目中所处位置（之上或者之下的栏目数）
		'所能提升最大幅度应为For i=1 to 该版之上的版面数
		set trs=conn.execute("select count(ClassID) From DownClass where ParentID="&rsClass("ParentID")&" and OrderID<"&rsClass("OrderID")&"")
		UpMoveNum=trs(0)
		if isnull(UpMoveNum) then UpMoveNum=0
		if UpMoveNum>0 then
  			response.write "<form action='Admin_Class_Down.asp?Action=UpOrderN' method='post'><td width='250'>"
			response.write "<select name=MoveNum size=1><option value=0>向上移动</option>"
			for i=1 to UpMoveNum
				response.write "<option value="&i&">"&i&"</option>"
			next
			response.write "</select>"
			response.write "<input type=hidden name=ClassID value="&rsClass("ClassID")&">&nbsp;<input type=submit name=Submit value=修改 class=button2>"
			response.write "</td></form>"
		else
			response.write "<td width='250'>&nbsp;</td>"
		end if
		trs.close
		'所能降低最大幅度应为For i=1 to 该版之下的版面数
		set trs=conn.execute("select count(ClassID) From DownClass where ParentID="&rsClass("ParentID")&" and orderID>"&rsClass("orderID")&"")
		DownMoveNum=trs(0)
		if isnull(DownMoveNum) then DownMoveNum=0
		if DownMoveNum>0 then
  			response.write "<form action='Admin_Class_Down.asp?Action=DownOrderN' method='post'><td width='250'>"
			response.write "<select name=MoveNum size=1><option value=0>向下移动</option>"
			for i=1 to DownMoveNum
				response.write "<option value="&i&">"&i&"</option>"
			next
			response.write "</select>"
			response.write "<input type=hidden name=ClassID value="&rsClass("ClassID")&">&nbsp;<input type=submit name=Submit value=修改 class=button2>"
			response.write "</td></form>"
		else
			response.write "<td width='250'>&nbsp;</td>"
		end if
		trs.close
	else
		response.write "<td colspan=2>&nbsp;</td>"
	end if
%>
      <td>&nbsp;</td>
	</tr>
  <%
	UpMoveNum=0
	DownMoveNum=0
	rsClass.movenext
loop
%>
</table>
</div>
<%
	rsClass.close
	set rsClass=nothing
end sub
%>
</body>
</html>


<%
sub SaveAdd()
	dim ClassID,ClassName,IsElite,ShowOnTop,Setting,ClassMaster,ClassPicUrl,PrevOrderID
	dim sql,rs,trs
	dim RootID,ParentDepth,ParentPath,ParentStr,ParentName,MaxClassID,MaxRootID
	dim PrevID,NextID,Child

	ClassName=trim(request("ClassName"))
	if ClassName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>栏目名称不能为空！</li>"
	end if
	if FoundErr=True then
		exit sub
	end if

	set rs = conn.execute("select Max(ClassID) From DownClass")
	MaxClassID=rs(0)
	if isnull(MaxClassID) then
		MaxClassID=0
	end if
	rs.close
	ClassID=MaxClassID+1
	set rs = conn.execute("select Max(RootID) From DownClass")
	MaxRootID=rs(0)
	if isnull(MaxRootID) then
		MaxRootID=0
	end if
	rs.close
	RootID=MaxRootID+1

	if ParentID>0 then
		sql="select * From DownClass where ClassID=" & ParentID & ""
		set rs=server.createobject("adodb.recordset")
		rs.open sql,conn,1,1
		if rs.bof and rs.eof then
			FoundErr=True
			ErrMsg=ErrMsg & "<li>所属栏目已经被删除！</li>"
		end if
		if FoundErr=True then
			rs.close
			set rs=nothing
			exit sub
		else
			RootID=rs("RootID")
			ParentName=rs("ClassName")
			ParentDepth=rs("Depth")
			ParentPath=rs("ParentPath")
			Child=rs("Child")
			ParentPath=ParentPath & "," & ParentID     '得到此栏目的父级栏目路径
			PrevOrderID=rs("OrderID")
			if Child>0 then
				dim rsPrevOrderID
				'得到与本栏目同级的最后一个栏目的OrderID
				set rsPrevOrderID=conn.execute("select Max(OrderID) From DownClass where ParentID=" & ParentID)
				PrevOrderID=rsPrevOrderID(0)
				set trs=conn.execute("select ClassID from DownClass where ParentID=" & ParentID & " and OrderID=" & PrevOrderID)
				PrevID=trs(0)

				'得到同一父栏目但比本栏目级数大的子栏目的最大OrderID，如果比前一个值大，则改用这个值。
				set rsPrevOrderID=conn.execute("select Max(OrderID) From DownClass where ParentPath like '" & ParentPath & ",%'")
				if (not(rsPrevOrderID.bof and rsPrevOrderID.eof)) then
					if not IsNull(rsPrevOrderID(0))  then
				 		if rsPrevOrderID(0)>PrevOrderID then
							PrevOrderID=rsPrevOrderID(0)
						end if
					end if
				end if
			else
				PrevID=0
			end if

		end if
		rs.close
	else
		if MaxRootID>0 then
			set trs=conn.execute("select ClassID from DownClass where RootID=" & MaxRootID & " and Depth=0")
			PrevID=trs(0)
			trs.close
		else
			PrevID=0
		end if
		PrevOrderID=0
		ParentPath="0"
	end if

	sql="Select * From DownClass Where ParentID=" & ParentID & " AND ClassName='" & ClassName & "'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,conn,1,1
	if not(rs.bof and rs.eof) then
		FoundErr=True
		if ParentID=0 then
			ErrMsg=ErrMsg & "<li>已经存在一级栏目：" & ClassName & "</li>"
		else
			ErrMsg=ErrMsg & "<li>“" & ParentName & "”中已经存在子栏目“" & ClassName & "”！</li>"
		end if
		rs.close
		set rs=nothing
		exit sub
	end if
	rs.close

	sql="Select top 1 * From DownClass"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,3
    rs.addnew
	rs("ClassID")=ClassID
   	rs("ClassName")=ClassName
	rs("RootID")=RootID
	rs("ParentID")=ParentID
	if ParentID>0 then
		rs("Depth")=ParentDepth+1
	else
		rs("Depth")=0
	end if
	rs("ParentPath")=ParentPath
	rs("OrderID")=PrevOrderID
	rs("Child")=0
	rs("PrevID")=PrevID
	rs("NextID")=0
	rs.update
	rs.Close
    set rs=Nothing

	'更新与本栏目同一父栏目的上一个栏目的“NextID”字段值
	if PrevID>0 then
		conn.execute("update DownClass set NextID=" & ClassID & " where ClassID=" & PrevID)
	end if

	if ParentID>0 then
		'更新其父类的子栏目数
		conn.execute("update DownClass set child=child+1 where ClassID="&ParentID)

		'更新该栏目排序以及大于本需要和同在本分类下的栏目排序序号
		conn.execute("update DownClass set OrderID=OrderID+1 where rootid=" & rootid & " and OrderID>" & PrevOrderID)
		conn.execute("update DownClass set OrderID=" & PrevOrderID & "+1 where ClassID=" & ClassID)
	end if

    call CloseConn()
	Response.Redirect "Admin_Class_Down.asp"
end sub

sub SaveModify()
	dim ClassName,IsElite,ShowOnTop,Setting,ClassMaster,ClassPicUrl,SkinID,LayoutID,BrowsePurview,AddPurview
	dim trs,rs
	dim ClassID,sql,rsClass,i
	dim SkinCount,LayoutCount
	ClassID=trim(request("ClassID"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
	else
		ClassID=CLng(ClassID)
	end if
	ClassName=trim(request("ClassName"))
	if ClassName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>栏目名称不能为空！</li>"
	end if

	if FoundErr=True then
		exit sub
	end if

	sql="select * From DownClass where ClassID=" & ClassID
	set rsClass=server.CreateObject ("Adodb.recordset")
	rsClass.open sql,conn,1,3
	if rsClass.bof and rsClass.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>找不到指定的栏目！</li>"
		rsClass.close
		set rsClass=nothing
		exit sub
	end if
	'if rsClass("Child")>0 then
	'	FoundErr=True
	'	ErrMsg=ErrMsg & "<li>本栏目有子栏目，所以不能修改。</li>"
	'end if

	if FoundErr=True then
		rsClass.close
		set rsClass=nothing
		exit sub
	end if

   	rsClass("ClassName")=ClassName
	rsClass.update
	rsClass.close
	set rsClass=nothing
	set rs=nothing
	set trs=nothing

    call CloseConn()
	Response.Redirect "Admin_Class_Down.asp"
end sub


sub DeleteClass()
	dim sql,rs,PrevID,NextID,ClassID
	ClassID=trim(Request("ClassID"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
		exit sub
	else
		ClassID=CLng(ClassID)
	end if

	sql="select ClassID,RootID,Depth,ParentID,Child,PrevID,NextID From DownClass where ClassID="&ClassID
	set rs=server.CreateObject ("Adodb.recordset")
	rs.open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>栏目不存在，或者已经被删除</li>"
	else
		if rs("Child")>0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<li>该栏目含有子栏目，请删除其子栏目后再进行删除本栏目的操作</li>"
		end if
	end if
	if FoundErr=True then
		rs.close
		set rs=nothing
		exit sub
	end if
	PrevID=rs("PrevID")
	NextID=rs("NextID")
	if rs("Depth")>0 then
		conn.execute("update DownClass set child=child-1 where ClassID=" & rs("ParentID"))
	end if
	rs.delete
	rs.update
	rs.close
	set rs=nothing
	'删除本栏目的所有下载和评论
	conn.execute("delete from Down where ClassID=" & ClassID)


	'修改上一栏目的NextID和下一栏目的PrevID
	if PrevID>0 then
		conn.execute "update DownClass set NextID=" & NextID & " where ClassID=" & PrevID
	end if
	if NextID>0 then
		conn.execute "update DownClass set PrevID=" & PrevID & " where ClassID=" & NextID
	end if
	call CloseConn()
	response.redirect "Admin_Class_Down.asp"

end sub

sub ClearClass()
	dim strClassID,rs,trs,SuccessMsg,ClassID
	ClassID=trim(Request("ClassID"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
		exit sub
	else
		ClassID=CLng(ClassID)
	end if
	strClassID=cstr(ClassID)
	set rs=conn.execute("select ClassID,Child,ParentPath from DownClass where ClassID=" & ClassID)
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>栏目不存在，或者已经被删除</li>"
		exit sub
	end if
	if rs(1)>0 then
		set trs=conn.execute("select ClassID from DownClass where ParentID=" & rs(0))
		do while not trs.eof
			strClassID=strClassID & "," & trs(0)
			trs.movenext
		loop
		trs.close
		set trs=conn.execute("select ClassID from DownClass where ParentPath like '" & rs(2) & "," & rs(0) & ",%'")
		do while not trs.eof
			strClassID=strClassID & "," & trs(0)
			trs.movenext
		loop
		trs.close
		set trs=nothing
	end if
	rs.close
	set rs=nothing
end sub


sub SaveMove()
	dim ClassID,sql,rsClass,i
	dim rParentID
	dim trs,rs
	dim ParentID,RootID,Depth,Child,ParentPath,ParentName,iParentID,iParentPath,PrevOrderID,PrevID,NextID
	ClassID=trim(request("ClassID"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
		exit sub
	else
		ClassID=CLng(ClassID)
	end if

	sql="select * From DownClass where ClassID=" & ClassID
	set rsClass=server.CreateObject ("Adodb.recordset")
	rsClass.open sql,conn,1,3
	if rsClass.bof and rsClass.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>找不到指定的栏目！</li>"
		rsClass.close
		set rsClass=nothing
		exit sub
	end if

	rParentID=trim(request("ParentID"))
	if rParentID="" then
		rParentID=0
	else
		rParentID=CLng(rParentID)
	end if

	if rsClass("ParentID")<>rParentID then   '更改了所属栏目，则要做一系列检查
		if rParentID=rsClass("ClassID") then
			FoundErr=True
			ErrMsg=ErrMsg & "<li>所属栏目不能为自己！</li>"
		end if
		'判断所指定的栏目是否为外部栏目或本栏目的下属栏目
		if rsClass("ParentID")=0 then
			if rParentID>0 then
				set trs=conn.execute("select rootid From DownClass where ClassID="&rParentID)
				if trs.bof and trs.eof then
					FoundErr=True
					ErrMsg=ErrMsg & "<li>不能指定外部栏目为所属栏目</li>"
				else
					if rsClass("rootid")=trs(0) then
						FoundErr=True
						ErrMsg=ErrMsg & "<li>不能指定该栏目的下属栏目作为所属栏目</li>"
					end if
				end if
				trs.close
				set trs=nothing
			end if
		else
			set trs=conn.execute("select ClassID From DownClass where ParentPath like '"&rsClass("ParentPath")&"," & rsClass("ClassID") & "%' and ClassID="&rParentID)
			if not (trs.eof and trs.bof) then
				FoundErr=True
				ErrMsg=ErrMsg & "<li>您不能指定该栏目的下属栏目作为所属栏目</li>"
			end if
			trs.close
			set trs=nothing
		end if

	end if

	if FoundErr=True then
		rsClass.close
		set rsClass=nothing
		exit sub
	end if

	if rsClass("ParentID")=0 then
		ParentID=rsClass("ClassID")
		iParentID=0
	else
		ParentID=rsClass("ParentID")
		iParentID=rsClass("ParentID")
	end if
	Depth=rsClass("Depth")
	Child=rsClass("Child")
	RootID=rsClass("RootID")
	ParentPath=rsClass("ParentPath")
	PrevID=rsClass("PrevID")
	NextID=rsClass("NextID")
	rsClass.close
	set rsClass=nothing


  '假如更改了所属栏目
  '需要更新其原来所属栏目信息，包括深度、父级ID、栏目数、排序、继承版主等数据
  '需要更新当前所属栏目信息
  '继承版主数据需要另写函数进行更新--取消，在前台可用ClassID in ParentPath来获得
  dim mrs,MaxRootID
  set mrs=conn.execute("select max(rootid) From DownClass")
  MaxRootID=mrs(0)
  set mrs=nothing
  if isnull(MaxRootID) then
	MaxRootID=0
  end if
  dim k,nParentPath,mParentPath
  dim ParentSql,ClassCount
  dim rsPrevOrderID
  if clng(parentid)<>rParentID and not (iParentID=0 and rParentID=0) then  '假如更改了所属栏目
	'更新原来同一父栏目的上一个栏目的NextID和下一个栏目的PrevID
	if PrevID>0 then
		conn.execute "update DownClass set NextID=" & NextID & " where ClassID=" & PrevID
	end if
	if NextID>0 then
		conn.execute "update DownClass set PrevID=" & PrevID & " where ClassID=" & NextID
	end if

	if iParentID>0 and rParentID=0 then  	'如果原来不是一级分类改成一级分类
		'得到上一个一级分类栏目
		sql="select ClassID,NextID from DownClass where RootID=" & MaxRootID & " and Depth=0"
		set rs=server.CreateObject("Adodb.recordset")
		rs.open sql,conn,1,3
		PrevID=rs(0)      '得到新的PrevID
		rs(1)=ClassID     '更新上一个一级分类栏目的NextID的值
		rs.update
		rs.close
		set rs=nothing

		MaxRootID=MaxRootID+1
		'更新当前栏目数据
		conn.execute("update DownClass set depth=0,OrderID=0,rootid="&maxrootid&",parentid=0,ParentPath='0',PrevID=" & PrevID & ",NextID=0 where ClassID="&ClassID)
		'如果有下属栏目，则更新其下属栏目数据。下属栏目的排序不需考虑，只需更新下属栏目深度和一级排序ID(rootid)数据
		if child>0 then
			i=0
			ParentPath=ParentPath & ","
			set rs=conn.execute("select * From DownClass where ParentPath like '%"&ParentPath & ClassID&"%'")
			do while not rs.eof
				i=i+1
				mParentPath=replace(rs("ParentPath"),ParentPath,"")
				conn.execute("update DownClass set depth=depth-"&depth&",rootid="&maxrootid&",ParentPath='"&mParentPath&"' where ClassID="&rs("ClassID"))
				rs.movenext
			loop
			rs.close
			set rs=nothing
		end if

		'更新其原来所属栏目的栏目数，排序相当于剪枝而不需考虑
		conn.execute("update DownClass set child=child-1 where ClassID="&iParentID)

	elseif iParentID>0 and rParentID>0 then    '如果是将一个分栏目移动到其他分栏目下
		'得到当前栏目的下属子栏目数
		ParentPath=ParentPath & ","
		set rs=conn.execute("select count(*) From DownClass where ParentPath like '%"&ParentPath & ClassID&"%'")
		ClassCount=rs(0)
		if isnull(ClassCount) then
			ClassCount=1
		end if
		rs.close
		set rs=nothing

		'获得目标栏目的相关信息
		set trs=conn.execute("select * From DownClass where ClassID="&rParentID)
		if trs("Child")>0 then
			'得到与本栏目同级的最后一个栏目的OrderID
			set rsPrevOrderID=conn.execute("select Max(OrderID) From DownClass where ParentID=" & trs("ClassID"))
			PrevOrderID=rsPrevOrderID(0)
			'得到与本栏目同级的最后一个栏目的ClassID
			sql="select ClassID,NextID from DownClass where ParentID=" & trs("ClassID") & " and OrderID=" & PrevOrderID
			set rs=server.createobject("adodb.recordset")
			rs.open sql,conn,1,3
			PrevID=rs(0)    '得到新的PrevID
			rs(1)=ClassID     '更新上一个栏目的NextID的值
			rs.update
			rs.close
			set rs=nothing

			'得到同一父栏目但比本栏目级数大的子栏目的最大OrderID，如果比前一个值大，则改用这个值。
			set rsPrevOrderID=conn.execute("select Max(OrderID) From DownClass where ParentPath like '" & trs("ParentPath") & "," & trs("ClassID") & ",%'")
			if (not(rsPrevOrderID.bof and rsPrevOrderID.eof)) then
				if not IsNull(rsPrevOrderID(0))  then
			 		if rsPrevOrderID(0)>PrevOrderID then
						PrevOrderID=rsPrevOrderID(0)
					end if
				end if
			end if
		else
			PrevID=0
			PrevOrderID=trs("OrderID")
		end if

		'在获得移动过来的栏目数后更新排序在指定栏目之后的栏目排序数据
		conn.execute("update DownClass set OrderID=OrderID+" & ClassCount & "+1 where rootid=" & trs("rootid") & " and OrderID>" & PrevOrderID)

		'更新当前栏目数据
		conn.execute("update DownClass set depth="&trs("depth")&"+1,OrderID="&PrevOrderID&"+1,rootid="&trs("rootid")&",ParentID="&rParentID&",ParentPath='" & trs("ParentPath") & "," & trs("ClassID") & "',PrevID=" & PrevID & ",NextID=0 where ClassID="&ClassID)

		'如果有子栏目则更新子栏目数据，深度为原来的相对深度加上当前所属栏目的深度
		set rs=conn.execute("select * From DownClass where ParentPath like '%"&ParentPath&ClassID&"%' order by OrderID")
		i=1
		do while not rs.eof
			i=i+1
			iParentPath=trs("ParentPath") & "," & trs("ClassID") & "," & replace(rs("ParentPath"),ParentPath,"")
			conn.execute("update DownClass set depth=depth-"&depth&"+"&trs("depth")&"+1,OrderID="&PrevOrderID&"+"&i&",rootid="&trs("rootid")&",ParentPath='"&iParentPath&"' where ClassID="&rs("ClassID"))
			rs.movenext
		loop
		rs.close
		set rs=nothing
		trs.close
		set trs=nothing

		'更新所指向的上级栏目的子栏目数
		conn.execute("update DownClass set child=child+1 where ClassID="&rParentID)

		'更新其原父类的子栏目数
		conn.execute("update DownClass set child=child-1 where ClassID="&iParentID)
	else    '如果原来是一级栏目改成其他栏目的下属栏目
		'得到移动的栏目总数
		set rs=conn.execute("select count(*) From DownClass where rootid="&rootid)
		ClassCount=rs(0)
		rs.close
		set rs=nothing

		'获得目标栏目的相关信息
		set trs=conn.execute("select * From DownClass where ClassID="&rParentID)
		if trs("Child")>0 then
			'得到与本栏目同级的最后一个栏目的OrderID
			set rsPrevOrderID=conn.execute("select Max(OrderID) From DownClass where ParentID=" & trs("ClassID"))
			PrevOrderID=rsPrevOrderID(0)
			sql="select ClassID,NextID from DownClass where ParentID=" & trs("ClassID") & " and OrderID=" & PrevOrderID
			set rs=server.createobject("adodb.recordset")
			rs.open sql,conn,1,3
			PrevID=rs(0)
			rs(1)=ClassID
			rs.update
			set rs=nothing

			'得到同一父栏目但比本栏目级数大的子栏目的最大OrderID，如果比前一个值大，则改用这个值。
			set rsPrevOrderID=conn.execute("select Max(OrderID) From DownClass where ParentPath like '" & trs("ParentPath") & "," & trs("ClassID") & ",%'")
			if (not(rsPrevOrderID.bof and rsPrevOrderID.eof)) then
				if not IsNull(rsPrevOrderID(0))  then
			 		if rsPrevOrderID(0)>PrevOrderID then
						PrevOrderID=rsPrevOrderID(0)
					end if
				end if
			end if
		else
			PrevID=0
			PrevOrderID=trs("OrderID")
		end if

		'在获得移动过来的栏目数后更新排序在指定栏目之后的栏目排序数据
		conn.execute("update DownClass set OrderID=OrderID+" & ClassCount &"+1 where rootid=" & trs("rootid") & " and OrderID>" & PrevOrderID)

		conn.execute("update DownClass set PrevID=" & PrevID & ",NextID=0 where ClassID=" & ClassID)
		set rs=conn.execute("select * From DownClass where rootid="&rootid&" order by OrderID")
		i=0
		do while not rs.eof
			i=i+1
			if rs("parentid")=0 then
				ParentPath=trs("ParentPath") & "," & trs("ClassID")
				conn.execute("update DownClass set depth=depth+"&trs("depth")&"+1,OrderID="&PrevOrderID&"+"&i&",rootid="&trs("rootid")&",ParentPath='"&ParentPath&"',parentid="&rParentID&" where ClassID="&rs("ClassID"))
			else
				ParentPath=trs("ParentPath") & "," & trs("ClassID") & "," & replace(rs("ParentPath"),"0,","")
				conn.execute("update DownClass set depth=depth+"&trs("depth")&"+1,OrderID="&PrevOrderID&"+"&i&",rootid="&trs("rootid")&",ParentPath='"&ParentPath&"' where ClassID="&rs("ClassID"))
			end if
			rs.movenext
		loop
		rs.close
		set rs=nothing
		trs.close
		set trs=nothing
		'更新所指向的上级栏目栏目数
		conn.execute("update DownClass set child=child+1 where ClassID="&rParentID)

	end if
  end if

  call CloseConn()
  Response.Redirect "Admin_Class_Down.asp"
end sub

sub UpOrder()
	dim ClassID,sqlOrder,rsOrder,MoveNum,cRootID,tRootID,i,rs,PrevID,NextID
	ClassID=trim(request("ClassID"))
	cRootID=Trim(request("cRootID"))
	MoveNum=trim(request("MoveNum"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
	else
		ClassID=CLng(ClassID)
	end if
	if cRootID="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
	else
		cRootID=Cint(cRootID)
	end if
	if MoveNum="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
	else
		MoveNum=Cint(MoveNum)
		if MoveNum=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<li>请选择要提升的数字！</li>"
		end if
	end if
	if FoundErr=True then
		exit sub
	end if

	'得到本栏目的PrevID,NextID
	set rs=conn.execute("select PrevID,NextID from DownClass where ClassID=" & ClassID)
	PrevID=rs(0)
	NextID=rs(1)
	rs.close
	set rs=nothing
	'先修改上一栏目的NextID和下一栏目的PrevID
	if PrevID>0 then
		conn.execute "update DownClass set NextID=" & NextID & " where ClassID=" & PrevID
	end if
	if NextID>0 then
		conn.execute "update DownClass set PrevID=" & PrevID & " where ClassID=" & NextID
	end if

	dim mrs,MaxRootID
	set mrs=conn.execute("select max(rootid) From DownClass")
	MaxRootID=mrs(0)+1
	'先将当前栏目移至最后，包括子栏目
	conn.execute("update DownClass set RootID=" & MaxRootID & " where RootID=" & cRootID)

	'然后将位于当前栏目以上的栏目的RootID依次加一，范围为要提升的数字
	sqlOrder="select * From DownClass where ParentID=0 and RootID<" & cRootID & " order by RootID desc"
	set rsOrder=server.CreateObject("adodb.recordset")
	rsOrder.open sqlOrder,conn,1,3
	if rsOrder.bof and rsOrder.eof then
		exit sub        '如果当前栏目已经在最上面，则无需移动
	end if
	i=1
	do while not rsOrder.eof
		tRootID=rsOrder("RootID")       '得到要提升位置的RootID，包括子栏目
		conn.execute("update DownClass set RootID=RootID+1 where RootID=" & tRootID)
		i=i+1
		if i>MoveNum then
			rsOrder("PrevID")=ClassID
			rsOrder.update
			conn.execute("update DownClass set NextID=" & rsOrder("ClassID") & " where ClassID=" & ClassID)
			exit do
		end if
		rsOrder.movenext
	loop
	rsOrder.movenext
	if rsOrder.eof then
		conn.execute("update DownClass set PrevID=0 where ClassID=" & ClassID)
	else
		rsOrder("NextID")=ClassID
		rsOrder.update
		conn.execute("update DownClass set PrevID=" & rsOrder("ClassID") & " where ClassID=" & ClassID)
	end if
	rsOrder.close
	set rsOrder=nothing

	'然后再将当前栏目从最后移到相应位置，包括子栏目
	conn.execute("update DownClass set RootID=" & tRootID & " where RootID=" & MaxRootID)
	call CloseConn()
	response.Redirect "Admin_Class_Down.asp?Action=Order"
end sub

sub DownOrder()
	dim ClassID,sqlOrder,rsOrder,MoveNum,cRootID,tRootID,i,rs,PrevID,NextID
	ClassID=trim(request("ClassID"))
	cRootID=Trim(request("cRootID"))
	MoveNum=trim(request("MoveNum"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<li>参数不足！</li>"
	else
		ClassID=CLng(ClassID)
	end if
	if cRootID="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
	else
		cRootID=Cint(cRootID)
	end if
	if MoveNum="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
	else
		MoveNum=Cint(MoveNum)
		if MoveNum=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<li>请选择要提升的数字！</li>"
		end if
	end if
	if FoundErr=True then
		exit sub
	end if

	'得到本栏目的PrevID,NextID
	set rs=conn.execute("select PrevID,NextID from DownClass where ClassID=" & ClassID)
	PrevID=rs(0)
	NextID=rs(1)
	rs.close
	set rs=nothing
	'先修改上一栏目的NextID和下一栏目的PrevID
	if PrevID>0 then
		conn.execute "update DownClass set NextID=" & NextID & " where ClassID=" & PrevID
	end if
	if NextID>0 then
		conn.execute "update DownClass set PrevID=" & PrevID & " where ClassID=" & NextID
	end if

	dim mrs,MaxRootID
	set mrs=conn.execute("select max(rootid) From DownClass")
	MaxRootID=mrs(0)+1
	'先将当前栏目移至最后，包括子栏目
	conn.execute("update DownClass set RootID=" & MaxRootID & " where RootID=" & cRootID)

	'然后将位于当前栏目以下的栏目的RootID依次减一，范围为要下降的数字
	sqlOrder="select * From DownClass where ParentID=0 and RootID>" & cRootID & " order by RootID"
	set rsOrder=server.CreateObject("adodb.recordset")
	rsOrder.open sqlOrder,conn,1,3
	if rsOrder.bof and rsOrder.eof then
		exit sub        '如果当前栏目已经在最下面，则无需移动
	end if
	i=1
	do while not rsOrder.eof
		tRootID=rsOrder("RootID")       '得到要提升位置的RootID，包括子栏目
		conn.execute("update DownClass set RootID=RootID-1 where RootID=" & tRootID)
		i=i+1
		if i>MoveNum then
			rsOrder("NextID")=ClassID
			rsOrder.update
			conn.execute("update DownClass set PrevID=" & rsOrder("ClassID") & " where ClassID=" & ClassID)
			exit do
		end if
		rsOrder.movenext
	loop
	rsOrder.movenext
	if rsOrder.eof then
		conn.execute("update DownClass set NextID=0 where ClassID=" & ClassID)
	else
		rsOrder("PrevID")=ClassID
		rsOrder.update
		conn.execute("update DownClass set NextID=" & rsOrder("ClassID") & " where ClassID=" & ClassID)
	end if
	rsOrder.close
	set rsOrder=nothing

	'然后再将当前栏目从最后移到相应位置，包括子栏目
	conn.execute("update DownClass set RootID=" & tRootID & " where RootID=" & MaxRootID)
	call CloseConn()
	response.Redirect "Admin_Class_Down.asp?Action=Order"
end sub

sub UpOrderN()
	dim sqlOrder,rsOrder,MoveNum,ClassID,i
	dim ParentID,OrderID,ParentPath,Child,PrevID,NextID
	ClassID=Trim(request("ClassID"))
	MoveNum=trim(request("MoveNum"))
	if ClassID="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
	else
		ClassID=CLng(ClassID)
	end if
	if MoveNum="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
	else
		MoveNum=Cint(MoveNum)
		if MoveNum=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<li>请选择要提升的数字！</li>"
		end if
	end if
	if FoundErr=True then
		exit sub
	end if

	dim sql,rs,oldorders,ii,trs,tOrderID
	'要移动的栏目信息
	set rs=conn.execute("select ParentID,OrderID,ParentPath,child,PrevID,NextID From DownClass where ClassID="&ClassID)
	ParentID=rs(0)
	OrderID=rs(1)
	ParentPath=rs(2) & "," & ClassID
	child=rs(3)
	PrevID=rs(4)
	NextID=rs(5)
	rs.close
	set rs=nothing
	if child>0 then
		set rs=conn.execute("select count(*) From DownClass where ParentPath like '%"&ParentPath&"%'")
		oldorders=rs(0)
		rs.close
		set rs=nothing
	else
		oldorders=0
	end if
	'先修改上一栏目的NextID和下一栏目的PrevID
	if PrevID>0 then
		conn.execute "update DownClass set NextID=" & NextID & " where ClassID=" & PrevID
	end if
	if NextID>0 then
		conn.execute "update DownClass set PrevID=" & PrevID & " where ClassID=" & NextID
	end if

	'和该栏目同级且排序在其之上的栏目------更新其排序，范围为要提升的数字
	sql="select ClassID,OrderID,child,ParentPath,PrevID,NextID From DownClass where ParentID="&ParentID&" and OrderID<"&OrderID&" order by OrderID desc"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,conn,1,3
	i=1
	do while not rs.eof
		tOrderID=rs(1)
		conn.execute("update DownClass set OrderID="&tOrderID+oldorders+i&" where ClassID="&rs(0))
		if rs(2)>0 then
			ii=i+1
			set trs=conn.execute("select ClassID,OrderID From DownClass where ParentPath like '%"&rs(3)&","&rs(0)&"%' order by OrderID")
			if not (trs.eof and trs.bof) then
				do while not trs.eof
					conn.execute("update DownClass set OrderID="&tOrderID+oldorders+ii&" where ClassID="&trs(0))
					ii=ii+1
					trs.movenext
				loop
			end if
			trs.close
			set trs=nothing
		end if
		i=i+1
		if i>MoveNum then
			rs(4)=ClassID
			rs.update
			conn.execute("update DownClass set NextID=" & rs(0) & " where ClassID=" & ClassID)
			exit do
		end if
		rs.movenext
	loop
	rs.movenext
	if rs.eof then
		conn.execute("update DownClass set PrevID=0 where ClassID=" & ClassID)
	else
		rs(5)=ClassID
		rs.update
		conn.execute("update DownClass set PrevID=" & rs(0) & " where ClassID=" & ClassID)
	end if
	rs.close
	set rs=nothing

	'更新所要排序的栏目的序号
	conn.execute("update DownClass set OrderID="&tOrderID&" where ClassID="&ClassID)
	'如果有下属栏目，则更新其下属栏目排序
	if child>0 then
		i=1
		set rs=conn.execute("select ClassID From DownClass where ParentPath like '%"&ParentPath&"%' order by OrderID")
		do while not rs.eof
			conn.execute("update DownClass set OrderID="&tOrderID+i&" where ClassID="&rs(0))
			i=i+1
			rs.movenext
		loop
		rs.close
		set rs=nothing
	end if
	call CloseConn()
	response.Redirect "Admin_Class_Down.asp?Action=OrderN"
end sub

sub DownOrderN()
	dim sqlOrder,rsOrder,MoveNum,ClassID,i
	dim ParentID,OrderID,ParentPath,Child,PrevID,NextID
	ClassID=Trim(request("ClassID"))
	MoveNum=trim(request("MoveNum"))
	if ClassID="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
		exit sub
	else
		ClassID=Cint(ClassID)
	end if
	if MoveNum="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<li>错误参数！</li>"
		exit sub
	else
		MoveNum=Cint(MoveNum)
		if MoveNum=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<li>请选择要下降的数字！</li>"
			exit sub
		end if
	end if

	dim sql,rs,oldorders,ii,trs,tOrderID
	'要移动的栏目信息
	set rs=conn.execute("select ParentID,OrderID,ParentPath,child,PrevID,NextID From DownClass where ClassID="&ClassID)
	ParentID=rs(0)
	OrderID=rs(1)
	ParentPath=rs(2) & "," & ClassID
	child=rs(3)
	PrevID=rs(4)
	NextID=rs(5)
	rs.close
	set rs=nothing

	'先修改上一栏目的NextID和下一栏目的PrevID
	if PrevID>0 then
		conn.execute "update DownClass set NextID=" & NextID & " where ClassID=" & PrevID
	end if
	if NextID>0 then
		conn.execute "update DownClass set PrevID=" & PrevID & " where ClassID=" & NextID
	end if

	'和该栏目同级且排序在其之下的栏目------更新其排序，范围为要下降的数字
	sql="select ClassID,OrderID,child,ParentPath,PrevID,NextID From DownClass where ParentID="&ParentID&" and OrderID>"&OrderID&" order by OrderID"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,conn,1,3
	i=0      '同级栏目
	ii=0     '同级栏目和子栏目
	do while not rs.eof
		conn.execute("update DownClass set OrderID="&OrderID+ii&" where ClassID="&rs(0))
		if rs(2)>0 then
			set trs=conn.execute("select ClassID,OrderID From DownClass where ParentPath like '%"&rs(3)&","&rs(0)&"%' order by OrderID")
			if not (trs.eof and trs.bof) then
				do while not trs.eof
					ii=ii+1
					conn.execute("update DownClass set OrderID="&OrderID+ii&" where ClassID="&trs(0))
					trs.movenext
				loop
			end if
			trs.close
			set trs=nothing
		end if
		ii=ii+1
		i=i+1
		if i>=MoveNum then
			rs(5)=ClassID
			rs.update
			conn.execute("update DownClass set PrevID=" & rs(0) & " where ClassID=" & ClassID)
			exit do
		end if
		rs.movenext
	loop
	rs.movenext
	if rs.eof then
		conn.execute("update DownClass set NextID=0 where ClassID=" & ClassID)
	else
		rs(4)=ClassID
		rs.update
		conn.execute("update DownClass set NextID=" & rs(0) & " where ClassID=" & ClassID)
	end if
	rs.close
	set rs=nothing

	'更新所要排序的栏目的序号
	conn.execute("update DownClass set OrderID="&OrderID+ii&" where ClassID="&ClassID)
	'如果有下属栏目，则更新其下属栏目排序
	if child>0 then
		i=1
		set rs=conn.execute("select ClassID From DownClass where ParentPath like '%"&ParentPath&"%' order by OrderID")
		do while not rs.eof
			conn.execute("update DownClass set OrderID="&OrderID+ii+i&" where ClassID="&rs(0))
			i=i+1
			rs.movenext
		loop
		rs.close
		set rs=nothing
	end if
	call CloseConn()
	response.Redirect "Admin_Class_Down.asp?Action=OrderN"
end sub
%>