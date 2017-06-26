<!--#include file="Conn.asp"-->
<%
if session(SiteSn & "AdminName") = "" then
    response.Redirect "Sep_Login.asp"
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-cn" xml:lang="zh-cn">
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>企业网站内容管理系统平台</title>
<link href="images/common.css" rel="stylesheet" type="text/css" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="images/jquery.js"></script>
<script type="text/javascript" src="images/jquery.easyui.min.js"></script>
<script language="javascript">
 function out(src){
 if(confirm('确定要安全退出吗？')){
 return true;
 }
return false;
 }
 </script>
</head>
<body class="easyui-layout">
<!-- Header -->
<div class="top_line">
    <div class="header">
        <h1 class="nsw_logo"></h1>
        <div class="f_fl f_mt35">网站内容管理系统平台 - 当前管理员：<%=session(SiteSn & "AdminName")%></div>
        <div class="nsw_tools hd_r f_fr f_tar">
            <div class="help_centre">	
              <a class="easyui-linkbutton" iconCls="icon-webhome" href="../" target=_blank plain="true">网站首页</a> 
              <a class="easyui-linkbutton" iconCls="icon-setup" href="Sep_Config.asp" target="frmEditor" plain="true">系统设置</a>
              <a class="easyui-linkbutton" iconCls="icon-reload" href="javascript:void(0)" onClick="location.reload();" plain="true">刷新后台</a>
              <a class="easyui-linkbutton" iconCls="icon-admin" href="Sep_PassEdit.asp?AdminName=<%=session(SiteSn & "AdminName")%>" target="frmEditor" plain="true">修改密码</a> 
              <a class="easyui-linkbutton" iconCls="icon-back" href="Sep_LoginOut.asp" target=_top plain="true" onClick="return out(this)">安全退出</a>
            </div>
        </div>
    </div>
</div>
<!-- wrap -->
	<div class="wrap">
		<div class="content f_cb">	
			<!-- leftbar -->
			<div class="col_side">
				<div class="menu_name">我的工具</div>
				<div class="menu_line">
					<div id="menuBar" class="menu_box">
                    
<div class="easyui-accordion" border="false" fit="false">

<div class="tablecss" title="图片管理">
<ul>
  <li><a href="Sep_Banner.asp" target="frmEditor">图片管理</a></li>
</ul>
</div>

</div>

                        
					</div>
				</div>	
			</div>
		    <!-- right box -->
			<div class="float_box">
            <script type="text/javascript"> 
			//根据浏览器大小调整左右布局的大小 
			$(window).ready(function(){ 
			var wheight=$(window).height(); 
			var wwidth=$(window).width(); 
			$(".col_side").css("height",(wheight-62)); 
			$(".float_box").css("height",(wheight-62)); 
			$(".float_box").css("width",(wwidth-220)+'px'); 
			}); 
			$(window).resize(function(){ 
			var wheight=$(window).height(); 
			var wwidth=$(window).width(); 
			$(".col_side").css("height",(wheight-62)); 
			$(".float_box").css("height",(wheight-62)); 
			$(".float_box").css("width",(wwidth-220)+'px'); 
			}); 
			</script> 
            <iframe src="Sep_Main.asp" marginheight="0" marginwidth="0" frameborder="0" scrolling="yes" id="frmEditor" name="frmEditor" width="100%" height="100%"></iframe>
			</div>
		</div>
	</div>
</body>
<script src="images/common.js" type="text/javascript"></script>
</html>