<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Inc/Function.asp"-->
<%
dim ID,Action,sqlDel,rsDel,FoundErr,ErrMsg,ObjInstalled
ID=trim(request("ID"))
TempID=trim(request("TempID"))
ClassID=trim(Request("ClassID"))
Action=Trim(Request("Action"))
OrderID=trim(Request("OrderID"))

FoundErr=False
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")

'--排序设置-----
if Action="Order" then
	TempID = Request.Form("TempID") '
	OrderID = Request.Form("OrderID") 
	IdTmp = Split(TempID,",")
	OrderTmp = Split(OrderID,",")
	For i = 0 To UBound(IdTmp)
	   conn.execute("update News set OrderID=" & OrderTmp(i) & " where ID=" & IdTmp(i))
	Next
	response.Redirect("Sep_News.asp?ClassID="&ClassID&"")
end if

'--推荐设置-----
if Action="tui" then
	conn.execute "Update News set Elite=1 Where ID=" & CLng(ID)
	response.Redirect("Sep_News.asp?ClassID="&ClassID&"")
elseif Action="tuino" then
	conn.execute "Update News set Elite=0 Where ID=" & CLng(ID)
	response.Redirect("Sep_News.asp?ClassID="&ClassID&"")
end if
'----------


if Action="Del" then
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "参数不足！<br>"
	end if
	if FoundErr=False then
		if instr(ID,",")>0 then
			dim idarr,i
			idArr=split(ID)
			for i = 0 to ubound(idArr)
				call DelProduct(clng(idarr(i)))
			next
		else
			call DelProduct(clng(ID))
		end if
	end if
	if FoundErr=False then
		call CloseConn()
		response.Redirect "Sep_News.asp?ClassID="&ClassID&""
	else
		call CloseConn()
		call WriteErrMsg()
	end if
end if

sub DelProduct(ID)
	PurviewChecked=False
	sqlDel="select * from News where ID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	if FoundErr=False then
		if DelUpFiles="Yes" and ObjInstalled=True then
			dim fso,strUploadFiles,arrUploadFiles
			strUploadPhotos=rsDel("PicUrl") & ""
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