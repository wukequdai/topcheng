<!--#include file="Conn.asp"-->
<!--#include file="Admin.asp"-->
<!--#include file="inc/config.asp"-->
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
Dim xaosok,xaosno
xaosok="<img src='images/tree_dnd_yes.png' align='absmiddle' />"
xaosno="<img src='images/tree_dnd_no.png' align='absmiddle' />"
%>
<%
set rs = Server.CreateObject("ADODB.Recordset")
sqltext="select * from Sep_Admin where SepName='"+Session(SiteSn & "AdminName")+"'"
rs.Open sqltext,conn,1,1
if not rs.EOF then
	LoginTimes=rs("LoginTimes")
	LastLoginTime=rs("LastLoginTime")
	LastLogoutTime=rs("LastLogoutTime")
	idcount=rs(0)
end if
rs.Close

okIIS = Request.ServerVariables("SERVER_SOFTWARE")
If Len(okIIS) > 1 And Len(Request.ServerVariables("OS")) = 0 Then
	If InStr(okIIS,"/5.0") > 0 Then
		okOS="Windows Server 2000"
	ElseIf InStr(okIIS,"/5.1") > 0 Then
		okOS= "Windows XP"
	ElseIf InStr(okIIS,"/6.0") > 0 Then
		okOS="Windows Server 2003"
	ElseIf InStr(okIIS,"/7.0") > 0 Then
		okOS="Windows Server 2008"
	ElseIf InStr(okIIS,"/7.5") > 0 Then
		okOS="Windows 7 "
	Else
		okOS=okOS & "(可能是最新版 Windows)"
	End If
End If
If Len(okOS) = 0 Then
	okOS = Request.ServerVariables("OS")
	If Len(okOS) = 0 Then okOS="Windows NT"
End If
If Err.Number <> 0 Then Err.Clear
%>

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：后台首页</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>

<div class="bord_gray">
    <div class="graybar_one f_cb" style="border-bottom: 1px solid #dedede;">
        <div class="wel_name">
     	您好！<span class="color_orange"><%=session(SiteSn & "AdminName")%></span> ，欢迎进入网站管理系统！
        </div>
    </div>
	<%if SubBook=1 then%>
    <div class="wel_info">
        <table class="admin_table table_class1">
        <tr><td><b>最新留言：</b><%set rs00= server.CreateObject ("adodb.recordset")
          rs00.open "select * from Sep_Book where IsGood=0",conn,1,1
          response.Write "<a href='Sep_Book.asp?action=looknew' style='font-size:12px;'><font color='#F00'>("&rs00.recordcount&")</font>条</a>"
          rs00.close
          set rs00=nothing%></td></tr>
        </table>
    </div>
    <%end if%>
	<div class="wel_info">
        <table class="admin_table table_class1">
        <tr><th colspan="2"><b>程序信息：</b></th></tr>
        <tr>
            <td width="50%">用户身份：<%If session(SiteSn & "AdminPurview")=1 Then%>超级<%end if%>管理员</td>
            <td>当前的IP：<%=Request.ServerVariables("REMOTE_ADDR")%></td>
        </tr>
        <tr>
            <td>身份过期：<%=Session.timeout%> 分钟</td>
            <td>登录次数：<%=LoginTimes%>次</td>
        </tr>
        <tr>
            <td>本次登录时间：<%=LastLoginTime%></td>
            <td>上次登录时间：<%=LastLogoutTime%></td>
        </tr>
        <tr>
            <td>服务器类型：<%=okOS%></td>
            <td>服务器IP和端口：IP：<%=Request.ServerVariables("local_addr")%>,
            端口：<%=Request.ServerVariables("SERVER_PORT")%></td>
        </tr>
        <tr>
            <td>站点物理路径：<%=request.ServerVariables("APPL_PHYSICAL_PAth")%></td>
            <td>脚本解释引擎：<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
        </tr>
        <tr>
            <td>IIS 版本：<%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
            <td>脚本超时时间：<%=Server.ScriptTimeout%>秒</td>
        </tr>
        <tr>
            <%=discreteness(3)%>
            <%=discreteness(6)%>
        </tr>
        <tr>
            <%=discreteness(1)%>
            <%=discreteness(2)%>
        </tr>
        <tr>
            <%'=discreteness(7)%>
            <%'=discreteness(10)%>
        </tr>
        <tr>
            <%=discreteness(11)%>
            <%=discreteness(12)%>
        </tr>
        <tr style=" display:none;">
            <%=discreteness(4)%>
            <%=discreteness(5)%>
        </tr>
        <tr style=" display:none;">
            <%=discreteness(8)%>
            <%=discreteness(9)%>
        </tr>
        </table>
    </div>

	<div class="wel_info">
        <table class="admin_table">
        <tr><th colspan="2"><b>版本信息：</b></th></tr>
        <tr>
          <td width="50%">产品名称：晋辉网站内容管理系统 <%=WebVersion%>&nbsp;
		  	<%if IsSqlDataBase=1 then response.Write("Mssql") else response.Write("Access") end If%>商业版</td>
          <td>程序开发：Sepsky</td>
        </tr>
        <tr>
          <td>公司名称：晋辉网络</td>
          <td>官方网址：<a href="http://www.jinhuiwangluo.com/" target="_blank" title="晋辉网络">www.jinhuiwangluo.com</a></td>
        </tr>
        </table>
    </div>
</div>
<%
Function discreteness(i)

Dim theInstalledObjects(12)
theInstalledObjects(1) = "ADODB.Stream"
theInstalledObjects(2) = "adodb.connection"
theInstalledObjects(3) = "Scripting.FileSystemObject"
theInstalledObjects(4) = "SoftArtisans.ImageGen"
theInstalledObjects(5) = "SoftArtisans.FileManager"
theInstalledObjects(6) = "JMail.Message"
theInstalledObjects(7) = "CDONTS.NewMail"
theInstalledObjects(8) = "Persits.MailSender"
theInstalledObjects(9) = "LyfUpload.UploadFile"
theInstalledObjects(10) = "Persits.Upload.1"
theInstalledObjects(11) = "msxml2.XMLHTTP"
theInstalledObjects(12) = "Persits.Jpeg"

Response.Write "<td class='tdnr'>"
select case i
case 1
Response.Write "无组件上传类："
case 2
Response.Write "ADO(数据库访问)版本："
case 3
Response.Write "FSO文件读写："
case 4
Response.Write "SA-ImgWriter组件："
case 5
Response.Write "SoftArtisans文件管理："
case 6
Response.Write "JMail邮件发送组件："
case 7
Response.Write "CDONTS发送邮件组件："
case 8
Response.Write "AspEmail发送邮件组件："
case 9
Response.Write "刘云峰文件上传："
case 10
Response.Write "AspUpload上传支持："
case 11
Response.Write "远程采集组件："
case 12
Response.Write "AspJpeg组件："
end select
If Not IsObjInstalled(theInstalledObjects(i)) Then
Response.Write xaosno
Else
Response.Write xaosok & "&nbsp;" & getver(theInstalledObjects(i)) & ""
End If
Response.Write "</td>"
end Function

''''''''''''''''''''''''''''''
Function IsObjInstalled(strClassString)
On Error Resume Next
IsObjInstalled = False
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(strClassString)
If 0 = Err Then IsObjInstalled = True
Set xTestObj = Nothing
Err = 0
End Function
''''''''''''''''''''''''''''''
Function getver(Classstr)
On Error Resume Next
getver=""
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(Classstr)
If 0 = Err Then getver=xtestobj.version
Set xTestObj = Nothing
Err = 0
End Function
%>