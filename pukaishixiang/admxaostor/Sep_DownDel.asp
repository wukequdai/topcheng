<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Inc/Function.asp"-->
<%
dim ID,Action,sqlDel,rsDel,FoundErr,ErrMsg,ObjInstalled
ID=trim(request("ID"))
ClassID=trim(Request("ClassID"))
Action=Trim(Request("Action"))
FoundErr=False
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")

if ID="" or Action<>"Del" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>参数不足！</li>"
end if
if FoundErr=False then
	if ID>0 then
		call DelDown(clng(ID))
	end if
end if
if FoundErr=False then
	call CloseConn()
	Response.write "<script language=javascript>alert('删除成功!');location='Sep_Down.asp?ClassID="&ClassID&"'</script> " 
else
	call CloseConn()
	call WriteErrMsg()
end if

sub DelDown(ID)
	PurviewChecked=False
	sqlDel="select * from Down where ID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	if FoundErr=False then
		if DelUpFiles="Yes" and ObjInstalled=True then
			dim fso,strUploadFiles,arrUploadFiles
			strUploadPhotos=rsDel("DownUrl") & ""
			if strUploadPhotos<>"" then
				Set fso = CreateObject("Scripting.FileSystemObject")
                if fso.FileExists(server.MapPath(strUploadPhotos)) then
				fso.DeleteFile(server.MapPath(strUploadPhotos))
				end if
				Set fso = nothing
			end if
		end if
		rsDel.delete
		rsDel.update
		set rsDel=nothing
	end if
end sub
%>