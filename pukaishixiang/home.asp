<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%> 
<!--#include file="inc/sep_c.asp"-->
<!--#include file="inc/Function.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><%=SiteName%></title>
<meta name="description" content="<%=SiteDescription%>">
<meta name="keywords" content="<%=SiteKeywords%>">
<link href="css/base.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.mutilslidedoor.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.4.2.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.mutilslidedoor.js"></script>
<script>
$(function(){
$.jquerySlideDoor("#slide1",3,2,1,4800);
$.jquerySlideDoor("#slide2",1,.8,0,3000);
$.jquerySlideDoor("#slide3",2,1,1,3100);
$.jquerySlideDoor("#slide4",4,.8,1,3000);
});
</script>

</head>
<body>

<div id="wrap">
    <div class="jquerySlideDoor homeBanner" id="slide1">
        <div class="doorList">
        <div class="inner">
            <div class="item"><a href="#"><img src="picture/1.jpg" /></a><div class="info"></div></div>
            <div class="item"><a href="#"><img src="picture/2.jpg" /></a><div class="info"></div></div>
            <div class="item"><a href="#"><img src="picture/3.jpg" /></a><div class="info"></div></div>
            <div class="item"><a href="#"><img src="picture/4.jpg" /></a><div class="info"></div></div>
            <div class="item"><a href="#"><img src="picture/5.jpg" /></a><div class="info"></div></div>
         </div>
        </div>
    </div>
    <!--#include file="naver.asp"-->
</div>

</body>
</html>