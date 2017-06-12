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
              <a class="easyui-linkbutton" iconCls="icon-plus" href="Sep_SpaceStat.asp"target="frmEditor" plain="true">空间统计</a>
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
<%
for AClassID=1 to 1
select case AClassID
  case 1
   Atitle="概述"
end select
%>
<div class="tablecss" title="<%=Atitle%>">
<ul>
  <%If session(SiteSn & "AdminPurview")=1 Then%>
  <li><a href="Sep_About.asp?Action=Add&ClassID=<%=AClassID%>" target="frmEditor" style="color:#f00;">添加栏目</a></li>
  <%end if%>
  <%
  set rsa=conn.execute("select Aid,Title from Sep_About where ClassID="& AClassID &" order by OrderID desc, Aid")
  if Not rsa.eof and Not rsa.bof then
  do while not rsa.eof
  %>
  <li><a href="Sep_About.asp?Action=Modify&AID=<%=rsa(0)%>&ClassID=<%=AClassID%>" target="frmEditor"><%=rsa(1)%></a></li><%
  rsa.MoveNext
  Loop
  End if
  rsa.close
  set rsa=nothing
  %>
</ul>
</div>
<%next%>

<div class="tablecss" title="图片中心">
<ul>
  <li><a href="Sep_AppAdd.asp" target="frmEditor" style="color:#f00;">添加案例</A></li>
  <%If session(SiteSn & "AdminPurview")=1 Then%>
  <li><a href="Admin_Class_App.asp" target="frmEditor" style="color:#f00;">案例分类</A></li>
  <%end if%>
  <%
  Set RsRoot=Server.CreateObject("adodb.recordset")
  RsRoot.open "select ClassID,ClassName,Depth from AppClass order by RootID,OrderID",conn,1,1 '数据库查询
  if Not RsRoot.eof and Not RsRoot.bof then
  do while not RsRoot.eof
  if rsRoot(2)=0 then
  %>
  <li><a href="Sep_App.asp?ClassID=<%=RsRoot(0)%>" target="frmEditor"><%=RsRoot(1)%></a></li>
  <%elseif rsRoot(2)=1 then%>
  <li class='la'><a href="Sep_App.asp?ClassID=<%=RsRoot(0)%>" target="frmEditor"><%=RsRoot(1)%></a></li>
  <%
  end if
  RsRoot.MoveNext
  Loop
  End if
  rsRoot.close
  set rsRoot=nothing
  %>
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