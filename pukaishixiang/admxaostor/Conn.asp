<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%> 
<%
MyDbPath = "../" 'ACC连接数据库路径，对SQL无效
Const WebVersion="V5.1 UTF-8"
Const EnableSiteManageCode = True        '是否启用后台管理认证码 是： True  否： False
Const SiteManageCode = "xaos"      '后台管理认证码，请修改，这样即使有人知道了您的后台用户名和密码也不能登录后台
Const SiteSn="xaos_1"	'如果一个空间放多个网站，则每个要错开，不能定义同一个名称
%>
<!--#include file="../inc/sep_c.asp"-->