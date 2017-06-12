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
	   conn.execute("update App set OrderID=" & OrderTmp(i) & " where ID=" & IdTmp(i))
	Next
	response.Redirect("Sep_App.asp?ClassID="&ClassID&"")
end if

'--推荐设置-----
if Action="tui" then
	conn.execute "Update App set Elite=1 Where ID=" & CLng(ID)
	response.Redirect("Sep_App.asp?ClassID="&ClassID&"")
elseif Action="tuino" then
	conn.execute "Update App set Elite=0 Where ID=" & CLng(ID)
	response.Redirect("Sep_App.asp?ClassID="&ClassID&"")
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
				call DelApp(clng(idarr(i)))
			next
		else
			call DelApp(clng(ID))
		end if
	end if
	if FoundErr=False then
		call CloseConn()
		response.Redirect "Sep_App.asp?ClassID="&ClassID&""
	else
		call CloseConn()
		call WriteErrMsg()
	end if
end if

sub DelApp(ID)
	PurviewChecked=False
	sqlDel="select * from App where ID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	if FoundErr=False then
		
		if DelUpFiles="Yes" and ObjInstalled=True then
			dim fso,strUploadFiles,arrUploadFiles
			strUploadFiles=rsDel("PicUrl") & ""
			if strUploadFiles<>"" then
				Set fso = CreateObject("Scripting.FileSystemObject")
				if SubPicBatchA=1 then
					arrUploadFiles=split(strUploadFiles,"@@")
					for i=0 to ubound(arrUploadFiles)-1
						if fso.FileExists(server.MapPath(arrUploadfiles(i))) then
							fso.DeleteFile(server.MapPath(arrUploadfiles(i)))
						end if
					next
				elseif SubPicBatchA=0 then
					if fso.FileExists(server.MapPath(strUploadfiles)) then
						fso.DeleteFile(server.MapPath(strUploadfiles))
					end if
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