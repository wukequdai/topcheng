<!--#include file="Sep_SqlIn.Asp"-->
<%
'===========================================
'禁止外部提交数据
'===========================================
Function ComeUrl()
server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
if mid(server_v1,8,len(server_v2))<>server_v2 then
response.write "<center><div style='width:450px;font-size:12px;border:#f00 solid 1px;height:60px;line-height:60px;color:#f00;'>"
response.write "你提交的路径有误，禁止从站点外部提交数据,请不要乱改参数！"
response.write "</div></center>"
response.end
end If
End Function

'===========================================
'表单数据过滤，敏感字符被替换
'===========================================
Function DelStr(Str)
If IsNull(Str) Or IsEmpty(Str) Then
Str= ""
End If
DelStr=Replace(Str,"'","")
DelStr=Replace(DelStr,"&","")
DelStr=Replace(DelStr,"%20","")
DelStr=Replace(DelStr,"<","")
DelStr=Replace(DelStr,">","")
DelStr=Replace(DelStr,"%","")
DelStr=Replace(DelStr," ","")
End Function

'===========================================
'转化HTML代码
'===========================================
function htmlencode2(str)
dim result
dim l
if isNULL(str) then
htmlencode2=""
exit function
end if
l=len(str)
result=""
dim i
for i = 1 to l
select case mid(str,i,1)
case "<"
result=result+"&lt;"
case ">"
result=result+"&gt;"
case chr(13)
result=result+"<br>"
case chr(34)
result=result+"&quot;"
case "&"
result=result+"&amp;"
case chr(32)	
'result=result+"&nbsp;"
if i+1<=l and i-1>0 then
if mid(str,i+1,1)=chr(32) or mid(str,i+1,1)=chr(9) or mid(str,i-1,1)=chr(32) or mid(str,i-1,1)=chr(9)  then	
result=result+"&nbsp;"
else
result=result+" "
end if
else
result=result+"&nbsp;"	
end if
case chr(9)
result=result+"    "
case else
result=result+mid(str,i,1)
end select
next
htmlencode2=result
end function

'===========================================
'过滤HTML代码
'===========================================
Function cutStr(str,strlen)
Dim re
Set re=new RegExp
re.IgnoreCase =True
re.Global=True
're.Pattern="<br[^>]*>"	'查找换行的字符
'str=re.Replace(str,"___br___")   '先替换换行为其他特殊的内容
re.Pattern="<(.[^>]*)>"
strs=re.Replace(str,"")
set re=Nothing
Dim l,t,c,i

strs=Replace(strs,chr(9),"")
strs=Replace(strs,chr(10),"")
strs=Replace(strs,chr(13),"")
strs=Replace(strs,"&nbsp;"," ")
strs=Replace(strs,"　","")
strs=Replace(strs, CHR(34), "")  '双引号
strs=replace(strs,"&#39;",Chr(39))
strs=Replace(strs, "'", "")  '单引号
strs=replace(strs,"&mdash;","—")
strs=replace(strs,"&ldquo;","“")
strs=replace(strs,"&rdquo;","”")
strs=Replace(strs, "{", "<")
strs=Replace(strs, "}", ">")
'str=replace(str,"___br___","<br />")  '反替换换行 
l=Len(strs)
t=0
For i=1 to l
c=Abs(Asc(Mid(strs,i,1)))
If c>255 Then
t=t+2
Else
t=t+1
End If
If t>=strlen Then
cutStr=left(strs,i) &"..."
Exit For
Else
cutStr=strs
End If
Next
End Function

Function cut111(str)
Set re=new RegExp
re.IgnoreCase =True
re.Global=True
re.Pattern="<table.+?>"	'查找字符
str=re.Replace(str,"<table>")

cut111=str
set re=Nothing
End Function

'===========================================
'判断图片是否为空
'===========================================
function ImgUrl(img)
if isnull(img) or img="" then
  ImgUrl="images/nopic.gif"  
else                      
  Set fs=Server.CreateObject("Scripting.FileSystemObject")
  If fs.FileExists(server.MapPath(img)) Then   '判断文件是否存在
	ImgUrl=img
  else
    ImgUrl="images/nopic.gif"  
  end if
  Set fs=Nothing
end if
End Function

'===========================================
'内容页关键词 替换并带链接
'===========================================
Function ReplaceKey(ByVal Str,ByVal Keys)
   If IsNull(Str) Then Exit Function
   Key=split(Keys,",")
   for i=0 to ubound(Key)
   	Str = P_Replace(Str,Key(i),"<a href='http://"&SiteUrl&"/' target='_blank' title='"&Key(i)&"'>"&Key(i)&"</a>")
   Next
   ReplaceKey = Str
End Function

'内容页关键词 正则
Function P_Replace(byval content,byval asp,byval htm)
	dim Matches,objRegExp,strs,i
	strs=content
	Set objRegExp = New Regexp
	objRegExp.Global = True
	objRegExp.IgnoreCase = True
	objRegExp.Pattern = "(\<a[^<>]+\>.+?\<\/a\>)|(\<img[^<>]+\>)"'
	Set Matches =objRegExp.Execute(strs)
	i=0
	Dim MyArray()
	For Each Match in Matches
	  ReDim Preserve MyArray(i)
	  MyArray(i)=Mid(Match.Value,1,len(Match.Value))
	  strs=replace(strs,Match.Value,"<"&i&">")
	  i=i+1
	Next
	if i=0 then
	  content=replace(content,asp,htm)
	  P_Replace=content
	  exit Function
	end if
	strs=replace(strs,asp,htm)
	for i=0 to ubound(MyArray)
	  strs=replace(strs,"<"&i&">",MyArray(i))
	next
	P_Replace=strs
end Function

'===========================================
'网站信息
'===========================================
set Rsst = conn.execute("Select top 1 * from Sep_Config")
if not Rsst.eof and not Rsst.bof then
  SiteName=rsst("Csitename")
  SiteDescription=rsst("CDescription")
  SiteKeywords=rsst("CKeywords")
  SiteKeys=rsst("CKeys")
  SiteUrl=rsst("CSiteUrl")
  CompanyName=rsst("Ccompany")
  CompanyAddress=rsst("Caddress")
  CompanyMobi=rsst("Cmobile")
  CompanyTel=rsst("Ctel")
  CompanyFax=rsst("Cfax")
  Company400=rsst("C400")
  CompanyEmail=rsst("Cemail")
  SiteICP=rsst("Cicp")
end if
Rsst.close
set Rsst=nothing

'===========================================
'网站时间显示
'===========================================
function Datetime(Datex,TypeID)
select case TypeID
  case 1
	 Datetime=year(Datex) &"."& right("0"&month(Datex),2) &"."& right("0"&day(Datex),2)
  case 2
	 Datetime=right("0"&month(Datex),2) &"/"& right("0"&day(Datex),2) 
  case 3
	 Datetime=right("0"&month(Datex),2) &"-"& right("0"&day(Datex),2)
end select
End Function

'===========================================
'网站Banner
'===========================================
function WebBanner(TypeID)
set rsPic= server.createobject("adodb.recordset")
if TypeID=0 then
sql="select PicUrl,Weburl,FTitle from Sep_Banner where ID<5 order by id"
else
sql="select PicUrl,Weburl,FTitle from Sep_Banner where ID>4 order by id"
end if
rsPic.open sql,conn,1,1
if not rsPic.eof and not rsPic.bof then
  do while not RsPic.eof
	if TypeID=0 then
	response.write "<div class='rbslider-slide' style='background-image:url("&ImgUrl(rsPic(0))&");'></div>"
	else
	response.write "<section class='section'><img class='img1' src='"&ImgUrl(rsPic(0))&"' alt='"&rsPic(2)&"' /></section>"
	end if
  RsPic.MoveNext
  Loop
end if
RsPic.close
set RsPic=nothing
end Function
%>