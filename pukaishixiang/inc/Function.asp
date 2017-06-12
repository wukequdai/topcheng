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
end Function

'===========================================
'过滤HTML代码
'===========================================
Function cuthtml(str)
Dim re
Set re=new RegExp
re.IgnoreCase =True
re.Global=True
re.Pattern="<img.*?\ssrc=([^\""\'\s][^\""\'\s>]*).*?>" '查找字符
str = re.Replace(str, "<img src=""$1"" />") 
'//正则匹配图片SRC地址
re.Pattern = "<img.*?\ssrc=([\""\'])([^\""\']+?)\1.*?>" 
str = re.Replace(str, "<img src=""$2"" />")
cuthtml=str
set re=Nothing
End Function

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
  SiteZbx=rsst("Czbx")
  SiteZby=rsst("Czby")
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
	 Datetime=year(Datex) &"-"& right("0"&month(Datex),2) &"-"& right("0"&day(Datex),2)
  case 2
	 Datetime=right("0"&month(Datex),2) &"/"& right("0"&day(Datex),2) 
  case 3
	 Datetime=right("0"&month(Datex),2) &"-"& right("0"&day(Datex),2)
  case 4
	 Datetime=year(Datex)
end select
End Function

'===========================================
'格式化时间为英文日期 FormatEnTime
'===========================================
function FormatEnTime(theTime)
  dim myArray1,myArray2,years,months,days
  FormatEnTime=""
  myArray1=split(theTime," ")
  theTime=replace(myArray1(0),"/","-")
  myArray2=split(theTime,"-")
  years=myArray2(0)
  months=myArray2(1)
  days=myArray2(2)
  select case months
  case "1"
	months="January"
  case "2"
	months="February"
  case "3"
	months="March"
  case "4"
	months="April"
  case "5"
	months="May"
  case "6"
	months="June"
  case "7"
	months="July"
  case "8"
	months="August"
  case "9"
	months="September"
  case "10"
	months="October"
  case "11"
	months="November"
  case else
	months="December"
  end select
  theTime=months&"&nbsp; "&days&", "&years
  FormatEnTime=theTime '输出的结果
End Function

'===========================================
'网站二级导航显示 
'===========================================
'单页
function WebMenu(ClassID)
set rsnd = server.createobject("adodb.recordset")
rsnd.Open "Select AID,Title,ClassID from Sep_About where ClassID="&ClassID&" order by OrderID desc, AID",conn,1,1
if not rsnd.eof and not rsnd.bof then
do while not rsnd.eof
	response.write "<li><a href='information.asp?/"&rsnd(0)&"a"&ClassID&".html'>"&rsnd(1)&"</a></li>"
rsnd.MoveNext
Loop
end if
rsnd.close
set rsnd=nothing
end Function

'产品
function WebMenuP()
set rsnp = server.createobject("adodb.recordset")
rsnp.Open "Select ClassID,ClassName from ProductClass where Depth=0 order by RootID,OrderID",conn,1,1
if not rsnp.eof and not rsnp.bof then
do while not rsnp.eof
	response.write "<li><a href='products.asp?/"&rsnp(0)&".html'>"&rsnp(1)&"</a></li>"
rsnp.MoveNext
Loop
end if
rsnp.close
set rsnp=nothing
end Function

'文章
function WebMenuN()
set rsnn = server.createobject("adodb.recordset")
rsnn.Open "Select ClassID,ClassName from NewsClass order by RootID,OrderID",conn,1,1
if not rsnn.eof and not rsnn.bof then
do while not rsnn.eof
	response.write "<li><a href='news.asp?/"&rsnn(0)&".html'>"&rsnn(1)&"</a></li>"
rsnn.MoveNext
Loop
end if
rsnn.close
set rsnn=nothing
end Function

'案例
function WebMenuA()
set rsna = server.createobject("adodb.recordset")
rsna.Open "Select ClassID,ClassName from AppClass order by RootID,OrderID",conn,1,1
if not rsna.eof and not rsna.bof then
do while not rsna.eof
	response.write "<li><a href='projects.asp?/"&rsna(0)&".html'>"&rsna(1)&"</a></li>"
rsna.MoveNext
Loop
end if
rsna.close
set rsna=nothing
end Function

'===========================================
'网站Banner
'===========================================
function WebBanner()
set rsPic= server.createobject("adodb.recordset")
sql="select PicUrl,Weburl,FTitle from Sep_Banner order by id"
rsPic.open sql,conn,1,1
if not rsPic.eof and not rsPic.bof then
  do while not RsPic.eof
	  response.write "<li style='background:url("&rsPic(0)&") center 0 no-repeat;'><a href='"&rsPic(1)&"' title='"&rsPic(2)&"' target='_blank'></a></li>"
  RsPic.MoveNext
  Loop
end if
RsPic.close
set RsPic=nothing
end Function

'===========================================
'首页基本介绍
'===========================================
function Home_About(Aid,TitleLen)
set rsab= conn.execute("select content from Sep_About where AID="&AID&"")
response.write cutStr(rsab(0),TitleLen)
end Function

'=================================================
'首页文章
'=================================================
function Home_News(Pnum)
Set Rsnew=Server.CreateObject("adodb.recordset")
sqlnew="select top "&Pnum&" ID,Title,Updatetime from News where Elite=1 order by OrderID desc, ID desc"	
rsnew.open sqlnew,conn,1,1
if not (rsnew.eof and rsnew.bof) then
	do while not Rsnew.eof
	   response.write "<li><a href='newsview.asp?/"&rsnew(0)&".html' title='"&rsnew(1)&"'>"&left(rsnew(1),28)&"</a>"&datetime(rsnew(2),3)&"</li>"
	Rsnew.MoveNext
	Loop 
end if
rsnew.close
set rsnew=nothing
end function

'===========================================
'首页产品展示
'===========================================
function Home_Product(Pnum)
set rsp = server.createobject("adodb.recordset")
sqlp="select top "&Pnum&" ID,Title,PicUrl,Content from Product where Elite=1 order by OrderID desc, ID desc"
rsp.open sqlp,conn,1,1
if not rsp.eof and not rsp.bof then
	do while not rsp.eof
		response.write "<li><a href='productview.asp?/"&rsp(0)&".html'>"
		response.write "<img src='"&ImgUrl(rsp(2))&"' onload='AutoResizeImage(this, 200, 180)' width='200' height='180' /></a>"
		response.write "<strong class='mt5'><a href='productview.asp?/"&rsp(0)&".html'>"&rsp(1)&"</a></strong><br />"
		response.write "<p class='mt5'>　　"&Cutstr(rsp(3),30)&"</p></li>"
	rsp.MoveNext
	Loop
end if
rsp.close
set rsp=nothing
end function

'===========================================
'首页友情链接
'===========================================
function Home_Links(ClassID)
set Rsl = server.createobject("adodb.recordset")
Rsl.Open "Select Title,PicUrl,WebUrl from Sep_links where ClassID="& ClassID &" order by id",conn,1,1
if not rsl.eof and not rsl.bof then
	do while not Rsl.eof
		if ClassID=1 then
			response.Write "<li><a href='"&rsl(2)&"' title='"&rsl(0)&"' target='_blank'><img src='"&ImgUrl(rsl(1))&"' /></a></li>"
		else
			response.Write "<a href='"&rsl(2)&"' title='"&rsl(0)&"' target='_blank'>"&rsl(0)&"</a>"
		end if
	Rsl.MoveNext
	Loop
end if
rsl.close
set rsl=nothing
end function

'=================================================
'内页关于我们列表标题
'=================================================
function Sub_About_Title(ClassID)
select case ClassID
	case 1
		response.write "关于我们"
	case 2
		response.write "应用领域"
end select
end function

'=================================================
'内页关于我们列表
'=================================================
function Sub_About(AID,ClassID)
set rsab = server.createobject("adodb.recordset")
Rsab.Open "Select Aid,Title,PicUrl from Sep_About where ClassID="&ClassID&" order by OrderID desc, Aid",conn,1,1
response.Write "<img class='conImg' src='"&ImgUrl(rsab(2))&"' width='170' height='170' alt='contact' />"
response.Write "<ul class='subnav2'>"
do while not Rsab.eof
	response.Write "<li>"
	if rsab(0)=AID then
		response.Write "<a class='onlink' "
	else
		response.Write "<a"
	end if
	response.write " href='about.asp?/"&rsab(0)&"a"&ClassID&".html'>"&rsab(1)&"</a></li>"
Rsab.MoveNext
Loop
response.write "</ul>"
rsab.close
set rsab=nothing
end function

'=================================================
'内页News列表
'=================================================
function Sub_NewsClass(ClassID)
set rsspc = server.createobject("adodb.recordset")
rsspc.Open "Select ClassID,ClassName from NewsClass where Depth=0 order by RootID,OrderID",conn,1,1
if not rsspc.eof and not rsspc.bof then
do while not rsspc.eof
	if rsspc(0)=ClassID then
		response.write "<li class='cur'>"
	else
		response.write "<li>"
	end if
	response.write "<a href='news.asp?/"&rsspc(0)&".html'>"&rsspc(1)&"</a></li>"
rsspc.MoveNext
Loop
end if
rsspc.close
set rsspc=nothing
end function


'===========================================
'内页Product列表
'===========================================
function Sub_ProductClass(ClassID,ParentID)
'1级分类开始
set rspc= server.createobject("adodb.recordset")
sqlpc="select ClassID,ClassName from ProductClass where Depth=0 order by RootID,OrderID"
rspc.open sqlpc,conn,1,1		
if not rspc.eof and not rspc.bof then
	do while not rspc.eof
	  if rspc(0)=ClassID or rspc(0)=ParentID then
		response.Write "<div class='sub-menu-head selected'><a href='products.asp?/"&rspc(0)&".html'>"&rspc(1)&"</a></div><div class='sub-menu-body' style='display:block;'><ul>" 
	  else
		response.Write "<div class='sub-menu-head'><a href='products.asp?/"&rspc(0)&".html'>"&rspc(1)&"</a></div><div class='sub-menu-body'><ul>" 
	  end if
	  response.Write "" 				  
	  '2级分类开始
	  set rspc2= server.createobject("adodb.recordset")
	  sqlpc2="select ClassID,ClassName from ProductClass where Depth=1 and ParentID="&rspc(0)&" order by RootID,OrderID"
	  rspc2.open sqlpc2,conn,1,1
	  if not rspc2.eof and not rspc2.bof then
		  do while not rspc2.eof
			if rspc2(0)=ClassID then
			response.Write "<li class='selected'>"
			else
			response.Write "<li>"
			end if
			response.Write "<a href='products.asp?/"&rspc2(0)&".html'>"&rspc2(1)&"</a></li>"
		  rspc2.MoveNext
		  Loop
	  end if
	  rspc2.close
	  set rspc2=nothing
	  '2级分类结束
	  
	response.Write "</ul></div>"
	rspc.MoveNext
	Loop
end if
rspc.close
set rspc=nothing
'1级分类结束			
end Function

'=================================================
'内页App列表
'=================================================
function Sub_AppClass(ClassID,TypeID)
'2级分类开始
set rspc2= server.createobject("adodb.recordset")
sqlpc2="select ID,Title,PicUrl,UpdateTime,Keyword from App where ClassID="& ClassID &" order by OrderID desc, ID desc"
rspc2.open sqlpc2,conn,1,1
if not rspc2.eof and not rspc2.bof then
	do while not rspc2.eof
	  if TypeID=0 then
	  	response.Write "<img class='conImg' src='"&ImgUrl(rspc2(2))&"' width='170' height='170' alt='contact' />"
	  else
		response.Write "<li><a href='workview.asp?/"&rspc2(0)&".html'><span>"&rspc2(1)&"</span>"
		If ClassID=1 then
		response.Write "<span class='type'>"&rspc2(4)&"</span><span class='date'>"&Datetime(rspc2(3),4)&"</span>"
		Else
		response.Write "<span class='type'>&nbsp;</span><span class='type'>"&rspc2(4)&"</span>"
		End if
		response.Write "</a></li>"
	  end if
	rspc2.MoveNext
	Loop
end if
rspc2.close
set rspc2=nothing
'2级分类结束
end function

'=================================================
'内页左侧公共列表
'=================================================
function Sub_Sider()
%>
<div class="mt20"><a href="information.asp?/7a2.html"><img src="Images/connect-sub.jpg" class="block" /></a></div>
<div class="mt20"><a href="information.asp?/5a2.html"><img src="Images/jjfa.jpg"></a></div>
<%
end function



'===========================================
'内页TAG标签
'===========================================
function Sub_Tags(Tname)
Tname=Replace(Tname," ",",")
aryReturn=split(Tname,",")
response.Write "<span>相关标签</span>"
For j=0 To UBound(aryReturn)
	response.Write "<a href='search.asp?kwd="&aryReturn(j) &"' title='"&aryReturn(j)&"'>"&aryReturn(j)&"</a>"
Next
end function

'===========================================
'内页上一条和下一条
'===========================================
function Sub_Pre_Next(Dname,ClassID,ID)
response.write "<span>上一篇："
sql="select top 1 id,title from "&Dname&" where ClassID="&ClassID&" and id>"&ID&" order by id"
set rsnews=conn.execute(sql)
if rsnews.eof then
response.write "没有了"
else
response.write "<a href='?/"&rsnews(0)&".html'>"&rsnews(1)&"</a>"
end If

response.write "</span><span>下一篇："
sql="select top 1 id,title from "&Dname&" where ClassID="&ClassID&" and id<"&ID&" order by id desc"
set rsnews=conn.execute(sql)
if rsnews.eof then
response.write "没有了"
else
response.write "<a href='?/"&rsnews(0)&".html'>"&rsnews(1)&"</a>"
end if
response.write "</span>"
end function


'===========================================
'分页代码
'===========================================
function Pagelist(PageNum,pagecount,strFileName)
'Response.Write ""&pagecount&"/"&Rs.pagecount&"&nbsp;"

'上一页开始
if Page="" then
	Lin_page=1
else
	Lin_page=cint(Page)
end if

if PageNum>1 then

response.write "<div class=""turnover"">"

if Lin_page<=1 then
	'Response.Write ("<span class=""disabled"">首页</span>")
	'Response.Write ("<span class=""disabled"">上一页</span>")
else
	Response.Write("<a href="""&thisUrl&"?"&strFileName&"1.html"">首页</a>")
	Response.Write("<a href="""&thisUrl&"?"&strFileName&"" & (Lin_page-1) & ".html"">上一页</a>")
end if

'数字分页开始
if pagecount>=10 then
	response.write"<a href="""&thisUrl&"?"&strFileName&""&(((cstr(pagecount)\10)-1)*10)+1&".html""><</a>"
end if
q=(cstr(pagecount)-1)\10
if q<0 then
q=1
end if
p=(q*10)+1
do while p<((q*10)+11)
If p=pagecount Then
	Response.Write "<span class=""current"">"&p&"</span>"
Elseif p<=PageNum then
	Response.Write "<a href="""&thisUrl&"?"&strFileName&""&p&".html"">"& p &"</a>"
End If
p=p+1
loop
A=PageNum
if (A mod 10)=0 then
	A=PageNum-1
end if
if pagecount<(A\10)*10 then
	response.write"<a href="""&thisUrl&"?"&strFileName&""&((((cstr(pagecount)-1)\10)+1)*10)+1&".html"">></a>"
end if

'下一页开始

if Lin_page>=PageNum then
	Response.Write ("<span class=""disabled"">下一页</span>")
	Response.Write ("<span class=""disabled"">尾页</span>")
else
	Response.Write("<a href="""&thisUrl&"?"&strFileName&"" & (Lin_page+1) & ".html"">下一页</a>")
	Response.Write("<a href="""&thisUrl&"?"&strFileName&"" & PageNum & ".html"">尾页</a>")
end if

'Response.Write "<span class=""disabled"">共 "&Rs.pagecount&" 页&nbsp;共 "&Rs.recordcount&" 条</span>"
'Response.Write "<span class=""disabled"">Page:"&pagecount&"/"&Rs.pagecount&"&nbsp;Total:"&Rs.recordcount&"</span>"
'Response.Write "第<font color=#ff0000>"&pagecount&"</font>页 共"&Rs.pagecount&"页&nbsp;&nbsp;共<font color=#ff0000>"&Rs.recordcount&"</font>条&nbsp;"

response.write "</div><!--end turnover-->"
End If
end function

'===========================================
'搜索页-分页代码
'===========================================
function Search_Pagelist()
'上一页开始
if page="" then
Lin_page=1
else
Lin_page=cint(page)
end if

if Rs.pagecount>1 then

response.write "<div class='turnover'>"

if Lin_page<=1 then
'Response.Write ("<span class=""disabled"">首页</span>" & vbCrLf)
'Response.Write ("<span class=""disabled"">上一页</span>" & vbCrLf)
else
Response.Write("<A href="&thisUrl&"?"&strFileName&"page=1 title='首页'>首页</a>")
Response.Write("<A href="&thisUrl&"?"&strFileName&"page="&(Lin_page-1)&" title='上一页'>上一页</a>")
end if

'数字分页开始

if pagecount>=10 then
'response.write"<a href="&thisUrl&"?"&strFileName&"Page="&(((cstr(pagecount)\10)-1)*10)+1&"><<</a>"
end if
q=(cstr(pagecount)-1)\10
if q<0 then
q=1
end if
p=(q*10)+1
do while p<((q*10)+11)
If p=pagecount Then
Response.Write "<span class=""current"">"&p&"</span>"
Elseif p<=Rs.pagecount then
Response.Write "<a href='"&thisUrl&"?"&strFileName&"page="&p&"'>"&p&"</a>"
End If
p=p+1
loop
A=Rs.pagecount
if (A mod 10)=0 then
A=Rs.pagecount-1
end if
if pagecount<(A\10)*10 then
'response.write"<a href="&thisUrl&"?"&strFileName&""&((((cstr(pagecount)-1)\10)+1)*10)+1&".html>>></a>"
end if

'下一页开始

if Lin_page>=Rs.pagecount then
	'Response.Write ("<span class=""disabled"">下一页</span>")
	'Response.Write ("<span class=""disabled"">尾页</span>")
else
	Response.Write("<A href="&thisUrl&"?"&strFileName&"page="&(Lin_page+1)&" title='下一页'>下一页</a>")
	Response.Write("<A href="&thisUrl&"?"&strFileName&"page="&Rs.pagecount&" title='尾页'>尾页</a>")
end if



'Response.Write "<span class=""disabled"">共"&Rs.recordcount&"条 第"&pagecount&"/"&Rs.pagecount&"页 "
'Response.Write "转到 <select style='font-size:10px;' onChange=""self.location.href='"&thisUrl&"?"&kwd&"-'+this.options[this.selectedIndex].value+'.html'"">"
'for i=1 to Rs.pagecount
'if i=pagecount then
'Response.Write "<option  value="&i&" selected>"&i&"</option>"
'else
'Response.Write "<option  value="&i&">"&i&"</option>"
'end if
'next
'Response.Write "</select> 页</span>"

'Response.Write "<span class=""disabled"">第"&pagecount&"页 共"&Rs.pagecount&"页&nbsp;&nbsp;共"&Rs.recordcount&"条</span>"

response.write "</div><!--end turnover-->"

End If
end function
%>