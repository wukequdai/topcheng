<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%> 
<!--#include file="inc/sep_c.asp"-->
<!--#include file="inc/Function.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1, width=device-width, maximum-scale=1, minimum-scale=1, user-scalable=no" />
<title><%=SiteName%></title>
<meta name="description" content="<%=SiteDescription%>">
<meta name="keywords" content="<%=SiteKeywords%>">
<link rel="stylesheet" href="css/home.css" />
<link rel="stylesheet" href="css/main.css" /> 
<link rel="stylesheet" href="css/animation.css" />
<style type="text/css">
#intro{padding:0;margin:0;height:0 !important;width:0;overflow:hidden !important;}#intro .logo{float:left;margin:0 10px 10px 0;}
h1, h2 , h3, h4, p, li{font-family:microsoft yahei;}
.img1{width: 100%;height: 100%;}
@media screen and (min-width:600px){
.slide1{background-image:url(images/1441951809.jpg);}
.slide2{background-image:url(images/1441949934.jpg);}
.slide3{background-image:url(images/1441956136.jpg);}
.slide4{background-image:url(images/1441947138.jpg);}
}
/*@media screen and (max-width:600px){*/
/*.slide1{background-image:url(images/1443615946.jpg);}*/
/*.slide2{background-image:url(images/1443618672.jpg);}*/
/*.slide3{background-image:url(images/1443618099.jpg);}*/
/*.slide4{background-image:url(images/1443619355.jpg);}*/
/*}*/
/**/
/*@media screen and (min-width:600px){*/
/*.page2{background-image:url(images/1441949348.jpg);}*/
/*.page3{background-image:url(images/1441956805.jpg);}*/
/*.page4{background-image:url(images/1443609696.jpg);}*/
/*.page5{background-image:url(images/1443614947.jpg);}*/
/*.page6{background-image:url(images/1443608806.jpg);}*/
/*.page7{background-image:url(images/1443610575.jpg);}*/
/*.page8{background-image:url(images/1443608078.jpg);}*/
/*}*/
/*@media screen and (max-width:600px){*/
/*.page2{background-image:url(images/1443621700.jpg);}*/
/*.page3{background-image:url(images/1443621784.jpg);}*/
/*.page4{background-image:url(images/1443620091.jpg);}*/
/*.page5{background-image:url(images/1443623011.jpg);}*/
/*.page6{background-image:url(images/1443620778.jpg);}*/
/*.page7{background-image:url(images/1443619787.jpg);}*/
/*.page8{background-image:url(images/1443617380.jpg);}*/
/*}*/
@media screen and (min-width:1050px){
#index_x{ display:none}
}
</style>
</head> 
<script src="js/jquery-1.11.1.min.js"></script>
<script>
$(document).ready(function(){
  $("#index_x").click(function(){
    $("#menu").hide();
  });
  $("#index_xs").click(function(){
    $("#menu").show();
  });
});
</script>
<body> 

<header id="header">
    <div class="container clearfix">
        <h1 id="logo"> <a href="#"><img alt="logo图片" src="images/logo.png" /></a></h1>
        <nav>
            <a class="icon_menu" id="index_xs"><img src="picture/caidan.png"></a>
            <ul id="menu">
                <li data-menuanchor="page1" class="active"><a data-name="home" href="#page1"><span>Home</span></a></li>
                <li data-menuanchor="page2"><a href="#page2"><span>About Us</span></a></li>
                <li data-menuanchor="page3"><a href="#page3"><span>Magazine</span></a></li>
                <li data-menuanchor="page4"><a href="#page4"><span>Map</span></a></li>
                <li data-menuanchor="page5"><a href="#page5"><span>WeChat</span></a></li>
                <li data-menuanchor="page6"><a href="#page6"><span>Event</span></a></li>
                <li data-menuanchor="page7"><a href="#page7"><span>Website</span></a></li>
                <li data-menuanchor="page8"><a href="#page8"><span>CSR</span></a></li>
                <li data-menuanchor="page9"><a href="#page9"><span>Contact Us</span></a></li>
            </ul> 
        </nav>
        <a href="tel:<%=CompanyTel%>" class="nav-tel"><b></b><%=CompanyTel%></a>
    </div>
</header>

<div class="page-container">
    <section class="section page1">
        <div class="rbslider-container">
            <div class="rbslider-wrapper">
                <%call WebBanner(0)%>
            </div> 
            <a class="move-down"></a> 
            <div class="rbslider-pagination"></div>
        </div>   
        <ul class="home-about"></ul>
        <ul class="home-about-navi">
            <li></li>
            <li></li>
            <li></li>
            <li class="bg"></li>
        </ul>
    </section>
    <%call WebBanner(1)%>
</div>

<div id="panel">
    <ul class="icons">
        <li class="up" title="上一页"></li>
        <li class="qq"></li>
        <li class="tel"></li>
        <li class="wx"></li>
        <li class="down" title="下一页"></li>
    </ul> 
    <ul class="info"> 
        <li class="qq"><p>在线沟通，请点我<a href="http://wpa.qq.com/msgrd?v=3&uin=<%=Company400%>&site=qq&menu=yes" target="_blank">在线咨询</a></p></li>
        <li class="tel"><p>KH & EN: <br> <%=CompanyFax%><br>CH & EN: <br><%=CompanyMobi%></p></li>
        <li class="wx"> <div class="img"><img src="images/weixin.jpg" /></div> </li>
    </ul>
</div>
<div class="index_cy"></div>

<script type="text/javascript" src="js/jquery-1.9.1.js"></script> 
<script type="text/javascript"> 
	$("header nav .icon_menu").click(function(){
		$(this).siblings("ul").toggleClass("show");
	});
	$("#panel .icons li").not(".up,.down").mouseenter(function(){
		$("#panel .info").addClass('hover');
		$("#panel .info li").hide();
		$("#panel .info li."+$(this).attr('class')).show();
	});
	$("#panel").mouseleave(function(){
		$("#panel .info").removeClass('hover');
	})
	$(".icons .up").click(function(){
		$.fn.ronbongpage.moveSectionUp(); 
	});
	$(".icons .down").click(function(){
		$.fn.ronbongpage.moveSectionDown(); 
	});
	 $(".index_cy").click(function(){
	    $("#panel").toggle();
		$(".index_cy").addClass('index_cy2');
		$(".index_cy2").removeClass('index_cy');
	});
</script>
<script type="text/javascript" src="js/home.js"></script>

</body>
</html> 