<% Response.CodePage=65001%> 
<% Response.Charset="UTF-8" %> 
<%
'Option Explicit
Response.Buffer = True

Dim StarTime
Dim MyDbPath,Db,SqlNow
StarTime=Timer()

Const IsSqlDataBase = 0       '定义数据库类别，1为SQL数据库，0为Access数据库

Dim ConnStr,Conn
If IsSqlDataBase = 1 Then     '数据库类型设置

	'MsSQL数据库设置
	Dim SqlDatabaseName,SqlPassword,SqlUsername,SqlLocalName
	SqlDatabaseName = ""      'SQL数据库名
	SqlPassword = ""          'SQL数据库用户密码
	SqlUsername = ""          'SQL数据库用户名
	SqlLocalName = "(local)"  'SQL主机IP地址（本地可用“127.0.0.1”或“(local)”，非本机请用真实IP）
	ConnStr = "Provider = Sqloledb; User ID = " & SqlUsername & "; Password = " & SqlPassword & "; Initial Catalog = " & SqlDatabaseName & "; Data Source = " & SqlLocalName & ";"
	SqlNow = "GetDate()"

Else
	'Access数据库路径
	'MyDbPath = ""
	Db="sep_data/##xa#os##xa#os##.mdb" 'Access数据库设置
	ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath(MyDbPath & db)
	SqlNow = "Now()"

End If

On Error Resume Next
Set conn = Server.CreateObject("ADODB.Connection")
conn.open ConnStr
If Err Then
	err.Clear
	Set Conn = Nothing
	Response.Write "数据库连接出错，请检查连接字串。"
	Response.End
End If

sub CloseConn()
	conn.close
	set conn=nothing
end Sub
%>
