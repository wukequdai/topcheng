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
  ClassID=Int(Split(XaosID,"_")(0)) 
  Page=Split(XaosID,"_")(1)
End If

call Show_App_Class(ClassID)

dim RootID,ParentID,ParentPath,ClassID,ClassName,PicUrl,Readme,Child,ClassType,Content
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><%=SiteName%></title>
<meta name="description" content="<%=SiteDescription%>">
<meta name="keywords" content="<%=SiteKeywords%>">
<link href="css/base.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/active.js"></script>
<script src="js/jscrollpane.js"></script>
</head>

<body>
	<div id="wrap">
    	<div id="main">
          <div class="activeImg">
			  <img class="conImg" src="picture/img_works01.jpg" width="170" height="170" alt="contact" />
			  <%call Sub_AppClass(ClassID,0)%>
          </div>
          <div class="con">
			<div class="Container">
          	<div id="Scroller-1" class="scrollbox active">
            <div class="Scroller-Container">
          	<ul class="worksList">
                <li style="display:none"></li>
            	<%call Sub_AppClass(ClassID,1)%>
            </ul>
            </div>
            </div>
            </div>
             <div id="Scrollbar-Container"><div class="Scrollbar-Track"><div class="Scrollbar-Handle"></div></div></div>
         </div>
        </div>
        <!--#include file="naver.asp"-->
    </div>

</body>
</html>