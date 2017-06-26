<!--#include file="Conn.asp"-->
<%
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
%>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>企业网站内容管理系统平台-管理员登录</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<!-- load css -->
	<link rel="stylesheet" type="text/css" href="css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="css/login.css" media="all">
	<link rel="stylesheet" type="text/css" href="css/code.css" media="all">
	<link rel="stylesheet" type="text/css" href="css/laydate.css" media="all">
	<link rel="stylesheet" type="text/css" href="css/layer.css" media="all">
</head>
<body oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>

<div class="layui-canvs"></div>
<div class="layui-layout layui-layout-login">
	<h1>
		 <strong>晋辉CMS内容管理系统</strong>
		 <em>Management System</em>
	</h1>
    <form action="Sep_Chk.asp" method="post" name="loginform" id="loginform">
	<div class="layui-user-icon larry-login">
		 <input type="text" name="LoginName" id="username" placeholder="账号" class="login_txtbx"/>
	</div>
	<div class="layui-pwd-icon larry-login">
		 <input type="password" name="LoginPass" id="password" placeholder="密码" class="login_txtbx"/>
	</div>
    <%if EnableSiteManageCode = True Then%>
    <div class="layui-val-icon larry-login">
    	<input type="text" name="AdminLoginCode" id="logincode" placeholder="认证码" class="login_txtbx">
    </div>
    <%end If%>
    <div class="layui-submit larry-login">
    	<input type="submit" value="立即登陆"  onClick="dosubmit()" class="submit_btn"/>
    </div>
    </form>
    <div class="layui-login-text">
    	<p style="text-align: center;"><a href="#">&copy; JinHuiCMS Inc. All rights reserved.</a></p>
    </div>
</div>

<script type="text/javascript" src="js/layui.all.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<script type="text/javascript" src="js/jparticle.jquery.js"></script>
<script src="js/layer.js"></script>
<script type="text/javascript">
$(function(){
	$(".layui-canvs").jParticle({
		background: "#141414",
		color: "#E6E6E6"
	});
	//登录链接测试，使用时可删除
	
});
</script>
<script>
function dosubmit(){
  
  var logincode=$('#logincode').val();
  var username=$('#username').val();
  var password=$('#password').val();
  
  if(username==""){	
	layer.msg('用户名不能为空', {icon: 5});return;
  }	
  if(password==""){	
	layer.msg('密码不能为空', {icon: 5});return;	
  }	
  if(logincode==""){	
	 layer.msg('认证码不能为空', {icon: 5});return;	
  }
}
</script>


</body>
</html>