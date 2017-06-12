<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="Inc/config.asp"-->
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
dim rs,sql,errmsg,FoundErr
dim ID,ClassID,ClassName,Title,Content,PicUrl,UpdateTime,Hits
dim ObjInstalled
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")
FoundErr=false
Action=DelStr(Trim(Request.Form("Action")))
ID=DelStr(Trim(Request.Form("ID")))
ClassID=DelStr(Trim(Request.Form("ClassID")))
Title=DelStr(trim(request.Form("Title")))
Keyword=KwdDelStr(trim(request.form("Keyword")))
Canshu=htmlcode2(trim(request.form("Canshu")))
Content=trim(request.form("Content"))
PicUrl=DelStr(trim(request.form("PicUrl"))) 
Elite=DelStr(trim(request.form("Elite")))
UpdateTime=DelStr(trim(request("UpdateTime")))
Hits=DelStr(trim(request.form("Hits")))
OrderID=DelStr(trim(request.form("OrderID")))
PicUrls=DelStr(trim(request.form("PicUrls"))) 

if ClassID="" then
	founderr=true
	errmsg=errmsg + "未指定信息所属栏目或者指定的栏目有下属子栏目<br />"
else
	ClassID=CLng(ClassID)
	if ClassID<=0 then
		FoundErr=True
		errmsg=errmsg + "指定了非法的栏目（外部栏目或不存在的栏目）<br />"
	else

		sqlClass="select ClassName,Depth,ParentPath,Child,ParentID From ProductClass where ClassID=" & ClassID
		set tClass=conn.execute(sqlClass)
		if tClass.bof and tClass.eof then
			FoundErr=True
			errmsg=errmsg + "找不到指定的栏目<br />"
		else
			ClassName=tClass(0)
			Depth=tClass(1)
			ParentPath=tClass(2)
			Child=tClass(3)
			if Child>0 then
				FoundErr=True
				errmsg=errmsg + "指定的栏目有下属子栏目<br />"
			end if
		 end if
	end if
end if

if Title="" then
	founderr=true
	errmsg=errmsg + "标题不能为空<br />"
end if

if SubKwdP=1 then
	if Keyword="" then
		founderr=true
		errmsg=errmsg+"关键词不能为空<br />"
	end if
end if

if Content="" then
	founderr=true
	errmsg=errmsg+"描述不能为空<br />"
end if

if founderr=false then

	if Hits<>"" then
		Hits=CLng(Hits)
	else
		Hits=100
	end if
	
	if UpdateTime="" then
		UpdateTime=now()
	end if

	set rs=server.createobject("adodb.recordset")
	if Action="SaveAdd" then
		sql="select * from Product where (ID is null)"
		rs.open sql,conn,1,3
		rs.addnew
		call SaveData()
		rs.update
		ID=rs("ID")
		rs.close
		set rs=nothing

	elseif request("Action")="SaveModify" then
  		if ID<>"" then
			sql="select * from Product where ID=" & ID
			rs.open sql,conn,1,3
			if not (rs.bof and rs.eof) then
				call SaveData()
				rs.update
				rs.close
				set rs=Nothing
 			else
				founderr=true
				errmsg=errmsg+"找不到此信息，可能已经被删除。<br />"
				call Writeerrmsg(errmsg)
			end if
		else
			founderr=true
			errmsg=errmsg+"不能确定信息ID的值<br />"
			call Writeerrmsg(errmsg)
		end if
	else
		founderr=true
		errmsg=errmsg+"没有选定参数<br />"
		call Writeerrmsg(errmsg)
	end if

	call CloseConn()
%>
<link href='Images/hi.xaos.css' rel='stylesheet' />
 <div class="center_div loading_block">
 <div class="loading_logo"><img src="Images/load_logo.gif" width="210" height="29" /></div>
 <div class="loading_bar">
   <p><img src="Images/ok.gif" width="16" height="16" align="absmiddle" /> &nbsp;
   <b>恭喜你！<%if Action="SaveAdd" then%>添加成功<%else%>修改成功<%end if%></b></p>
 </div>
 <div class="loading_onclick" style="padding-top:12px; line-height:22px;">
    序号：<%=ID%>
    <div align="center">标题：<%=Title%></div>
    <div align="center">类别：<%=ClassName%></div>
    <p align="center" style="padding-top:10px;">
    【<a href="Sep_ProductModify.asp?ID=<%=ID%>&ClassID=<%=ClassID%>">修改信息</a>】&nbsp;
    【<a href="Sep_ProductAdd.asp?ClassID=<%=ClassID%>">继续添加</a>】&nbsp;
    【<a href="Sep_Product.asp?ClassID=<%=ClassID%>">信息管理</a>】
    </p>
 </div>
 </div>
 <div class="hiddenDiv"></div>      
<%
else
	call Writeerrmsg(errmsg)
end if

sub SaveData()
	rs("ClassID")=ClassID
	rs("Title")=Title
	rs("Keyword")=Keyword
	rs("Canshu")=Canshu
	rs("Content")=Content
	rs("PicUrl")=PicUrl
	if Elite="yes" then
		rs("Elite")=1
	else
		rs("Elite")=0
	end if
	rs("Hits")=Hits
	rs("UpdateTime")=UpdateTime
	if OrderID<>"" then
		rs("OrderID")=OrderID
	else
		rs("OrderID")=0
	end if
	rs("PicUrls")=PicUrls
end sub
%>
</body>
</html>