<%
Url=replace(replace(replace(Request.ServerVariables("URL"),".",""),"asp",""),"/","")
if Url="index" or Url="" then
	curcss0="onlink"
elseif Url="about" then
	curcss1="onlink"
elseif (Url="works" and ClassID=1) or (Url="workview" and ClassID=1) or (Url="workshow" and ClassID=1) then
	curcss2="onlink"
elseif (Url="works" and ClassID=2) or (Url="workview" and ClassID=2) or (Url="workshow" and ClassID=2) then
	curcss3="onlink"
elseif Url="notes" then
	curcss4="onlink"
elseif Url="contact" then
	curcss5="onlink"
elseif Url="brand" then
	curcss6="onlink"
end if
%>
<ul class="navigation">
    <li><a href="about.asp" class="<%=curcss1%>">概述</a></li>
    <li><a href="works.asp?/1.html" class="<%=curcss2%>">设计作品</a></li>
    <li><a href="works.asp?/2.html" class="<%=curcss3%>">空间摄影</a></li>
    <li><a href="#" class="<%=curcss4%>">记事</a></li>
    <li><a href="contact.asp" class="<%=curcss5%>">联系</a></li>
    <li class="no_bg"><a href="brand.asp" class="<%=curcss6%>">合作品牌</a></li>
</ul>