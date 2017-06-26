<%
'Option Explicit'开启强制变量定义

'--------定义部份------------------
Dim Xaos_Post,Xaos_Get,Xaos_Inject,Xaos_Inject_Keyword
Dim Xaos_Alert_Url,Xaos_Alert_Info,Xaos_Kill_Info,Xaos_Alert_Type
Dim Xaos_Sec_Forms,Xaos_Sec_Form_open,Xaos_Sec_Form

'获取配置信息
Xaos_Inject = "'|;|and|(|)|exec|insert|select|delete|update|count|chr|mid|master|truncate|char|declare" '需要过滤的关键字
Xaos_Alert_Type = 2    '出错后的处理方式
Xaos_Alert_Url = "/"   '出错后跳转Url
Xaos_Alert_Info = "请不要在参数中包含非法字符尝试注入！" '警告提示信息
Xaos_Kill_Info = "SQL通用防注入系统提示你\n你的Ip已经被本系统自动锁定！\n如想访问本站请和管理员联系！" '阻止访问提示信息
Xaos_Sec_Form_open = 1 '是否启用安全表单
Xaos_Sec_Forms = ""    '安全的表单

'安全表单参数
Xaos_Sec_Form = split(Xaos_Sec_Forms,"|")
Xaos_Inject_Keyword = split(Xaos_Inject,"|")

If Request.Form<>"" Then StopInjection(Request.Form)

If Request.QueryString<>"" Then StopInjection(Request.QueryString)

If Request.Cookies<>"" Then StopInjection(Request.Cookies)


'sql通用防注入主函数
Function StopInjection(values)
	Dim Xaos_Get,Xaos_i
	For Each Xaos_Get In values
		'安全表单功能
		If Xaos_Sec_Form_open = 1 Then 
			For Xaos_i=0 To UBound(Xaos_Sec_Form)
				If LCase(Xaos_Get)=LCase(Xaos_Sec_Form(Xaos_i)) Then 
					Exit Function
				else
					Call Select_BadChar(values,Xaos_Get)
				End If 
			Next			
		Else
			Call Select_BadChar(values,Xaos_Get)
		End If 
	Next
End Function 

'查找关键字
Function Select_BadChar(values,Xaos_Get)
	Dim Xaos_Xh
	Dim Xaos_ip,Xaos_url,Xaos_sql
	Xaos_ip = Request.ServerVariables("REMOTE_ADDR")
	Xaos_url = Request.ServerVariables("URL")

	For Xaos_Xh=0 To Ubound(Xaos_Inject_Keyword)
		If Instr(LCase(values(Xaos_Get)),Xaos_Inject_Keyword(Xaos_Xh))<>0 Then	
			N_Alert(Xaos_Alert_Info)
			Response.End
		End If
	Next
End Function

'输出警告信息
Function N_Alert(Xaos_Alert_Info)
	Dim str
	'response.write "test"
	str = "<"&"Script Language=JavaScript"&">"
	Select Case Xaos_Alert_Type
		Case 1 '直接关闭网页
			str = str & "window.opener=null; window.close();"
		Case 2 '警告后关闭
			str = str & "alert('"&Xaos_Alert_Info&"');window.opener=null; window.close();"
		Case 3 '跳转到指定页面
			str = str & "location.href='"&Xaos_Alert_Url&"';"
		Case 4 '警告后跳转
			str = str & "alert('"&Xaos_Alert_Info&"');location.href='"&Xaos_Alert_Url&"';"
	end Select
	str = str & "<"&"/Script"&">"
	response.write  str
End Function 

'判断注入类型函数
Function intype(values)
	Select Case values
		Case Request.Form
			intype = "Post"
		Case Request.QueryString
			intype = "Get"
		Case Request.Cookies
			intype = "Cookies"
	end Select
End Function

'干掉xss脚本
Function N_Replace(N_urlString)
	N_urlString = Replace(N_urlString,"'","''")
    N_urlString = Replace(N_urlString, ">", "&gt;")
    N_urlString = Replace(N_urlString, "<", "&lt;")
    N_Replace = N_urlString
End Function
%>