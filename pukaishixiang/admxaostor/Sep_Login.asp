<!--#include file="Conn.asp"-->
<%
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
%>
<!DOCTYPE>
<html>
<head>
<title>企业网站内容管理系统平台-管理员登录</title>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" CONTENT="no-cache, must-revalidate">
<link rel="stylesheet" type="text/css" href="images/Login.css">
</head>
<body oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>

<div class="loginCt">
    <div class="loginLogo"></div>
    <div class="welcome">
        欢迎登录 JinHuiCMS 内容管理系统
    </div>
    <form action="Sep_Chk.asp" method="post" name="loginform" id="loginform" class="loginform">
    <div class="loginBar" id="loginBar">
    	<div class="fieldWrap">
            <div class="lable"><span class="userName"></span></div>
            <div class="inputWrap">
                <input name="LoginName" type="text" class="inputText" id="LoginName" datatype="*" nullmsg="请输入用户名！" />
            </div>
        </div>
        <div class="fieldWrap">
            <div class="lable"><span class="passWord"></span></div>
            <div class="inputWrap">
                <input name="LoginPass" type="password" class="inputText" id="LoginPass" datatype="*" nullmsg="请输入密码！" />
            </div>
        </div>
        <%if EnableSiteManageCode = True Then%>
        <div class="fieldWrap">
            <div class="lable"><span class="loginCode"></span></div>
            <div class="inputWrap">
        		<input name="AdminLoginCode" type="text" class="inputText" id="AdminLoginCode" datatype="*" nullmsg="请输入认证码！" />
            </div>
        </div>
        <%end If%>
        <div id="loginBtnWrap">
            <button type="submit" class="inline-block" id="loginBtn">登 录</button>
            <span id="msgdemo2"></span>
        </div>
    </div>
    </form>
    <div class="copyright">&copy; JinHuiCMS Inc. All rights reserved.</div>
</div>


        

<link rel="stylesheet" href="images/style.css" type="text/css" media="all" />
<script type="text/javascript" src="images/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="images/Validform_v5.3.2.js"></script>
<script type="text/javascript">
$(function(){		
	$(".loginform").Validform({
		tiptype:function(msg,o,cssctl){
			var objtip=$("#msgdemo2");
			cssctl(objtip,o.type);
			objtip.text(msg);
		}
	});
})
</script>
</body>
</html>