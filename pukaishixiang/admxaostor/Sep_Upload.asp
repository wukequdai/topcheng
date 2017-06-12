<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="Sep_Upfile.asp"-->
<!--#include file="Inc/config.asp"-->
<!--#include file="Inc/AntiTrojanPhoto.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
BODY, td{
BACKGROUND-COLOR: #fff;
font-size:9pt;
line-height:22px;
}
-->
</style>
</head>
<body leftmargin="2" topmargin="3" marginwidth="0" marginheight="0" >
<%			
Server.scriptTimeout=999999   '要是你的网站支持上传的文件比较大，就必须设置。

if EnableUploadFile="No" then
	response.write "系统未开放文件上传功能"
else
	if session(SiteSn & "AdminName")="" then
		response.Write("请登录后再使用本功能！")
	Else
%>

<%
		dim Upload,File,returnValue,uploadResult
		set Upload = new MoLibUpload
		Upload.AllowFileTypes = UpFileType
		Upload.AllowMaxFileSize = MaxFileSize
		Upload.AllowMaxSize = "20mb"
		Upload.CharSet = "utf-8"
		uploadResult = false
		if not Upload.GetData() then 
			returnValue = Upload.Description
			ResultText = "<a href='javascript:window.history.go(-1);'>返回重试</a>"
		else
			C1=Upload.Post("C1")
			FID=Upload.Post("FID")
			Upload.SavePath = SaveUpFilesPath &"/"& Year(date()) & right("0" & month(Date()),2) &"/"  '自定义文件路径
			Set File = Upload.Save("file"&FID,-1,true)  '-1为自定义文件名
			if File.Succeed then
				uploadResult = true
				returnValue = SaveUpFilesPath &"/"& Year(date()) & right("0" & month(Date()),2) &"/"& File.FileName
				oFileSize=File.Size	'获取文件大小
				'==========	防木马图片 ==========	
				call AntiTrojan(returnValue)			
				'========== 防木马图片 ==========
				if C1="ON" then
					call CreateView(returnValue,Draw_NewSize,File.Extend,C1) ''''AspJpeg代码
				end If
				ResultText = "文件上传成功！大小为："&GainFileSize (oFileSize)&" <a href='javascript:window.history.go(-1);'>重新上传</a>"			
			else
				returnValue = File.Exception
				ResultText = "<a href='javascript:window.history.go(-1);'>返回重试</a>"
			end If
		end if
		set Upload = nothing
%>
<script type="text/javascript">
window.parent.callback<%=FID%>(<%=lcase(uploadResult)%>,"<%=replace(returnValue,"""","\""")%>");
</script>
<%=ResultText%>
<%	
	end if
end If


'==========	防木马图片	
Function AntiTrojan(F_FileName)
If uCheckIsPic(server.mappath(F_FileName)) Then
Set AntiTrojan=New AntiTrojanPhoto
whichfile=server.mappath(F_FileName)		
Set MyFile  = CreateObject("scripting.filesystemobject")
	 If not AntiTrojan.CheckFileType(whichfile) then
	   Set filedel = MyFile.GetFile(whichfile) 
	   filedel.Delete True
	   set filedel = nothing
	   set MyFile = nothing
		response.write "您上传的文件格式有问题，上传失败！<a href=# onclick=history.go(-1)>返回</a>"
		response.end
	 end if
Set AntiTrojan=Nothing
End If
End Function

'==========	防木马图片检测图片	
Function uCheckIsPic(str)
  If instr(lcase(str),"jpg") > 0 Or instr(lcase(str),"gif") > 0 Or instr(lcase(str),"bmp") > 0 Or instr(lcase(str),"png") > 0 then
   uCheckIsPic = True
  Else
   uCheckIsPic = False
  End If
End Function

'==========判断文件大小
Function GainFileSize (SizeByte)
  if SizeByte < 1024*1024 then
    GainFileSize=round(SizeByte/1024,2) & "&nbsp;KB"
  else  
    GainFileSize=round(SizeByte/1024/1024,2) & "&nbsp;MB"
  end if
End Function


'==========	创建预览图片:Call CreateView(原始文件的路径,图片新尺寸,原文件后缀)
Public Function CreateView(Imagename,NewSize,FileExt,C1)

  ' 读取要处理的原文件
  Dim Logobox
  FileExt = Lcase(FileExt)
  On Error Resume Next
  Set ogvbox = Server.CreateObject("Persits.Jpeg")
  ogvbox.Open Trim(Server.MapPath(Imagename))
  If Err Then
	  err.Clear
	  Exit Function
  End If
	  
  if C1="ON" then
	  if FileExt = "jpg" or FileExt="bmp" or FileExt="jpeg" or FileExt="png" or FileExt="gif" then
		  ogvbox.PreserveAspectRatio = True ' 图片是否需要等比缩略
		  ogvbox.Quality = 100 				' 输出质量
		  'If ogvbox.OriginalWidth > NewSize Or ogvbox.OriginalHeight > NewSize Then
		  If ogvbox.OriginalWidth > NewSize Then
			  'If ogvbox.OriginalWidth > ogvbox.OriginalHeight Then
				  ogvbox.Width = NewSize
			  'Else
				  'ogvbox.Height = NewSize
			  'End if
			  ogvbox.Save Server.MapPath(Imagename)
		  End If
	  End If
  end if
  
End Function
%>