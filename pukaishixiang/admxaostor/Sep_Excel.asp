<!--#include file="Conn.asp"-->
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
    <span class="nsw_add">当前位置：导出Excel文档</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="wel_table">
<table class="nsw_pro_list">
  <tr>
	<td align="center">
<% 
Action=Trim(Request("Action"))

If Action="daochu" then

  Set fs = server.CreateObject("scripting.filesystemobject")  
  '--假设你想让生成的EXCEL文件做如下的存放  
  filename = Server.MapPath("\excel.xls")  
  '--如果原来的EXCEL文件存在的话删除它  
  if fs.FileExists(filename) then  
	  fs.DeleteFile(filename)  
  end  if  
  
  '--创建EXCEL文件  
  set myfile = fs.CreateTextFile(filename,true)  
  strSql = "select * from Sep_UserInfo order by id desc"
  Set rstData = DataToRsStatic(conn,strSql)
  if rstData.EOF and rstData.BOF then  
  	response.write "数据库里暂时没有数据，不能导出EXCEL文件!<br><a href='Sep_UserManage.asp' style='color:#f00;'>返回会员管理</a>" 
  else
	  dim  trLine,responsestr  
	  strLine = "帐号" & chr(9) & "Email" & chr(9) & "电话" & chr(9) & "姓名" & chr(9) & "公司" & chr(9) & "地址" & chr(9) & "手机"
	  '--将表的列名先写入EXCEL  
	  myfile.writeline strLine    
	  Do while Not rstData.EOF  
		strLine=""  
		strLine = rstData("uname") &  chr(9)  & rstData("umail") &  chr(9) & rstData("utel") & chr(9) & rstData("unamec") & chr(9) & rstData("ucompany") & chr(9) & rstData("uadds") & chr(9) & rstData("umobile") & chr(9)& IfSendStr
		myfile.writeline  strLine   
	  rstData.MoveNext  
	  loop
	  Response.Write  "生成EXCEL文件成功，<a href='../excel.xls' target='_blank' style='color:#f00;'>点击下载文件</a>！"
  end if  
  rstData.Close  
  set rstData = nothing
  Conn.Close
  Set Conn = nothing

  Function DataToRsStatic(Conn,strSql)
	Dim RsStatic
	
	Set DataToRsStatic = Nothing
	If Conn Is Nothing Then
			Exit Function
	End If
	Set RsStatic = CreateObject("ADODB.RecordSet")
	RsStatic.CursorLocation = 3
	RsStatic.Open strSql,Conn,3,3
	If Err.Number <> 0 Then 
			Exit Function
	End If
	Set DataToRsStatic = RsStatic
  End Function

end if
%> 
</td>
</tr>
</table>
</div>

</body>
</html>