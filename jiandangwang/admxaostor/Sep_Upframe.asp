<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>iframe上传，返回文件名</title>
<style type="text/css">
<!--
INPUT {FONT-SIZE: 12px;HEIGHT: 20px;}
.sysf{padding-top:5px; height:20px; line-height:20px;}
.sysf input, .sysf lable{ float:left;}
.sysf lable{ margin-top:2px; margin-left:2px;}
-->
</style>
</head>
<body leftmargin="0" topmargin="0">

<%FID=Clng(trim(request.QueryString("FID")))%>
<form action="Sep_Upload.asp" method="post" enctype="multipart/form-data">
<input type="file" name="file<%=FID%>" size="28" /><input type="submit" value="上传" />
<%if Clng(trim(request("TID")))=1 then%>
<input type="hidden" name="C1" value="ON" />
<%end if%>
<input type="hidden" name="FID" value="<%=FID%>">
</form>

</body>
</html>
    