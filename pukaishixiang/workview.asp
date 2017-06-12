<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="inc/sep_c.asp"-->
<!--#include file="inc/Function.asp"-->
<!--#include file="inc/Function.Content.asp"-->
<%
XaosID=Trim(request.QueryString("XaosID"))
If XaosID="" Then
  dim Xaos_v2
  Xaos_v2=Request.ServerVariables("query_string")  
  XaosID=replace(replace(Xaos_v2,"/",""),".html","")
End If 

call Show_App_Content(XaosID)

dim Sep_ID,Sep_ClassID,Sep_Title,Sep_Keyword,Sep_PicUrl,Sep_Canshu,Sep_Content,Sep_Time,Sep_Hits,Sep_PicUrls
dim ParentID,ParentPath,ClassName
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><%=SiteName%></title>
<meta name="description" content="<%=SiteDescription%>">
<meta name="keywords" content="<%=SiteKeywords%>">
<link href="css/base.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.slidedoor.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.4.2.min.js"></script>
<script src="js/jquery.timers.js"></script>
<script src="js/jquery.slidedoor.js"></script>
<script>
$(function(){
	$.jquerySlideDoor("#slideDoor1");
});
</script>

</head>
<body>
	<div class="pageHome">
   	  <div class="works clearFix">
  		<ul class="resume">
            <%if Sep_ClassID=1 then%>
            <li><%=Sep_Title%></li>
            <li><%=Sep_Canshu%></li>
            <%end if%>
        </ul>  
		<div class="jqueryShowDoor" id="slideDoor1">
    	<div class="doorList">
        	<div class="inner">
            	<%Sep_ArrPicUrls=Split(Sep_PicUrls,"@@")%>
				<%For i=0 To UBound(Sep_ArrPicUrls)-1%>
                <div class="item"><img src="<%=ImgUrl(Sep_ArrPicUrls(i))%>" /></div>
                <%next%>
            </div>
      </div>
     <div class="subnav03 clearFix">
          <a class="a1" href="workshow.asp?/<%=Sep_ID%>.html">简述</a>
          <a class="a3" href="works.asp?/<%=Sep_ClassID%>.html" >返回</a>
    </div>

    </div>
    </div>                
</div>
</body>
</html>