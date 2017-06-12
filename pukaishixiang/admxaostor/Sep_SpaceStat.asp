<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
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

<%Const SysRootDir = "/" %>

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：网站空间统计</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>

<div class="wel_table">
<table class="nsw_pro_list">
  <tr id="tabHeader">
    <td width="150" nowrap><strong>统计栏目</strong></td>
    <td nowrap><strong>路径</strong></td>
    <td width="100" nowrap><strong>大小</strong></td>
    <td width="100" nowrap><strong>百分比</strong></td>
    <td width="300" nowrap><strong>图示</strong></td>
  </tr>
  <tr>
    <td>系统总占用空间</td>
    <td><%=SysRootDir%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir)),,-1)%></td>
    <td><img src="images/bar.gif" width="260" height="8"></td>
  </tr>
  <tr>
    <td>数据库存放文件夹</td>
    <td><%=SysRootDir&"sep_data"%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&"sep_data"))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&"sep_data")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&"sep_data"))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>网站常规数据库</td>
    <td><%=SysRootDir&Db%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&Db))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&Db)),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&Db))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>前台CSS文件夹</td>
    <td><%=SysRootDir&"css"%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&"css"))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&"css")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&"css"))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>前台图片文件夹</td>
    <td><%=SysRootDir&"Images"%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&"Images"))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&"Images")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&"Images"))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>前台JS脚本文件</td>
    <td><%=SysRootDir&"js"%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&"js"))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&"js")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&"js"))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>前台文件上传保存目录</td>
    <td><%=SysRootDir&"UploadFiles"%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&"UploadFiles"))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&"UploadFiles")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&"UploadFiles"))*260%>" height="8"></td>
  </tr> 
  <tr>
    <td>前台图片预览效果目录</td>
    <td><%=SysRootDir&"fancybox"%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&"fancybox"))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&"fancybox")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&"fancybox"))*260%>" height="8"></td>
  </tr> 
  <tr>
    <td>后台文件夹</td>
    <td><%=SysRootDir&"admxaostor"%></td>
    <td><%=SizeInfo(SizeByte(SysRootDir&"admxaostor"))%></td>
    <td><%=FormatPercent(Percent(SizeByte(SysRootDir&"admxaostor")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte(SysRootDir&"admxaostor"))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>后台图片文件夹</td>
    <td><%="Images"%></td>
    <td><%=SizeInfo(SizeByte("Images"))%></td>
    <td><%=FormatPercent(Percent(SizeByte("Images")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte("Images"))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>后台包含文件</td>
    <td><%="Inc"%></td>
    <td><%=SizeInfo(SizeByte("Inc"))%></td>
    <td><%=FormatPercent(Percent(SizeByte("Inc")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte("Inc"))*260%>" height="8"></td>
  </tr>
  <tr>
    <td>后台在线编辑器文件夹</td>
    <td><%="sep_ckeditor"%></td>
    <td><%=SizeInfo(SizeByte("sep_ckeditor"))%></td>
    <td><%=FormatPercent(Percent(SizeByte("sep_ckeditor")),,-1)%></td>
    <td><img src="images/bar.gif" width="<%=Percent(SizeByte("sep_ckeditor"))*260%>" height="8"></td>
  </tr>
</table>
</div>

</body>
</html>

<%
'============
function SizeByte(UrlPath)
  dim fso,DirPath
  set fso=server.createobject("scripting.filesystemobject") 
  DirPath=server.mappath(UrlPath)
  if fso.FileExists(DirPath) then	
 	SizeByte=fso.getfile(DirPath).size
  elseif fso.FolderExists(DirPath) then
 	SizeByte=fso.getfolder(DirPath).size
  else
    SizeByte="PathError"
  end if
end function
'============
function SizeInfo(SizeByte)
  if SizeByte="PathError" then
    SizeInfo="<font color='red'>未找到</font>"
  else
    if SizeByte>=1024*1024*1024 then
      SizeInfo=round(SizeByte/1024/1024/1024,2) & " GB"		
    elseif 1024*1024<=SizeByte and SizeByte<1024*1024*1024 then
      SizeInfo=round(SizeByte/1024/1024,2) & " MB"		
    elseif 1024<=SizeByte and SizeByte<1024*1024 then
      SizeInfo=round(SizeByte/1024,2) & " KB"	
    else
      SizeInfo=SizeByte & " Byte" 
    end if
  end if
end function
'============

function Percent(SizeByte)
  dim fso,SysSizeByte
  set fso=server.createobject("scripting.filesystemobject") 
  if fso.FolderExists(server.mappath(SysRootDir)) and SizeByte<>"PathError"  then
 	SysSizeByte=fso.getfolder(server.mappath(SysRootDir)).size
    Percent=SizeByte/SysSizeByte
  else
    Percent=0
	exit function
  end if
end function
'============
%>