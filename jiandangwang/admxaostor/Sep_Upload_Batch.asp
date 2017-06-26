<!--#include file="Sep_Upfile.asp"-->
<%
Dim Upload,File
set Upload=new MoLibUpload	
Upload.AllowMaxSize="200mb"
Upload.AllowMaxFileSize="200mb"
Upload.AllowFileTypes="*.gif;*.jpg;*.jpeg;*.bmp;*.png;" 
Upload.Charset="utf-8"
if not Upload.GetData() then
	response.Write("{err:true,msg:'" & Upload.Description & "'}")
else
	Upload.SavePath = "/UploadFiles/"& Year(date()) & right("0" & month(Date()),2) &"/"
	set File=Upload.files("filedata") 
	if Upload.Save(File,-1,true).Succeed then
		response.Write("{err:false,msg:'upload',name:'" & File.filename & "',src:'" & File.LocalName & "',name2:'" & Upload.Post("name") & "'}")
	else
		response.Write("{err:true,msg:'" & File.Exception & "'}")
	end if
	set File=nothing
end if
set Upload=nothing
%>