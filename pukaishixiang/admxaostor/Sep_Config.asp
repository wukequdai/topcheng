<!--#include file="conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="Inc/Function.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-cn" xml:lang="zh-cn">
<head>
<title>右侧主页管理导航菜单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="images/common.css" rel="stylesheet" type="text/css" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
<SCRIPT type=text/javascript src="images/jquery.js"></SCRIPT>
<SCRIPT type=text/javascript src="images/jquery.easyui.min.js"></SCRIPT>
</head>
<body>

<%
FoundErr=false
if Request.QueryString("Action")="Edit" then

	Cid=DelStr(trim(request.Form("Cid")))
	Csitename=DelStr(trim(request.Form("Csitename")))
	CDescription=DelStr(trim(request.Form("CDescription")))
	CKeywords=DelStr(trim(request.Form("CKeywords")))
	CKeys=KwdDelStr(trim(request.Form("CKeys")))
	CsiteUrl=DelStr(trim(request.Form("CsiteUrl")))
	Ccompany=DelStr(trim(request.Form("Ccompany")))
	Caddress=DelStr(trim(request.Form("Caddress")))
	Ctel=DelStr(trim(request.Form("Ctel")))
	Cfax=DelStr(trim(request.Form("Cfax")))
	C400=DelStr(trim(request.Form("C400")))
	Cmobile=DelStr(trim(request.Form("Cmobile")))
	Cemail=DelStr(trim(request.Form("Cemail")))
	Cicp=DelStr(trim(request.Form("Cicp")))
	Czbx=DelStr(trim(request.Form("Czbx")))
	Czby=DelStr(trim(request.Form("Czby")))

	if founderr=false then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql="select * from Sep_Config where Cid="&Cid&""
		rs.open sql,conn,1,3

		rs("Csitename")=Csitename
		rs("CDescription")=CDescription
		rs("CKeywords")=CKeywords
		rs("CKeys")=CKeys
		rs("CsiteUrl")=CsiteUrl
		rs("Ccompany")=Ccompany
		rs("Caddress")=Caddress
		rs("Ctel")=Ctel
		rs("Cfax")=Cfax
		rs("C400")=C400
		rs("Cmobile")=Cmobile
		rs("Cemail")=Cemail
		rs("Cicp")=Cicp
		rs("Czbx")=Czbx
		rs("Czby")=Czby

		rs.update
		rs.close
		call WriteSuccessMsg("更新","Sep_Config.asp")
	end if
end if

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "Select top 1 * From Sep_Config", conn,1,1
%>

<div class="nsw_bread_tit">
    <span class="nsw_add">当前位置：网站设置</span>
    <a class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-reload" onClick="location.reload();" plain="true">刷新本页</a>
</div>
<div class="wel_table">
<table class="nsw_pro_list">
      <form method="post" name="myform" action="Sep_Config.asp?Action=Edit">
	  <tr id="tabHeader">
          <th colspan="3">网站设置</th>
      </tr>
       <tr>
        <td width="120" align="right">网站标题：</td>
        <td><input name="Csitename" type="text" id="Csitename" value="<%=rs("Csitename")%>" size="80" /></td>
       </tr>
       <tr>
        <td align="right" valign="top">网站描述：</td>
        <td><textarea name="CDescription" cols="80" rows="5" id="CDescription"><%=rs("CDescription")%></textarea></td>
       </tr>
       <tr>
        <td align="right" valign="top">网站关键词：</td>
        <td><textarea name="CKeywords" cols="80" rows="5" id="CKeywords"><%=rs("CKeywords")%></textarea></td>
       </tr>
       <tr>
        <td align="right" valign="top">内容关键词：</td>
        <td><input name="CKeys" type="text" id="CKeys" value="<%=rs("CKeys")%>" size="80" />
        多个请用 <font color="#FF0000">空格</font> 或 <font color="#FF0000">|</font> 或 <font color="#FF0000">,</font> 隔开
        </td>
       </tr>
       <tr>
        <td align="right">网站地址：</td>
        <td><input name="CsiteUrl" type="text" id="CsiteUrl" value="<%=rs("CsiteUrl")%>" size="50" />
        格式 如：www.baidu.com</td>
       </tr>
       <tr>
        <td align="right">公司名称：</td>
        <td><input name="Ccompany" type="text" id="Ccompany" value="<%=rs("Ccompany")%>" size="50" /></td>
       </tr>
       <tr>
         <td align="right">公司地址：</td>
         <td><input name="Caddress" type="text" id="Caddress" value="<%=rs("Caddress")%>" size="90" /> </td>
       </tr>
	   <tr>
         <td align="right">电　　话：</td>
         <td><input name="Ctel" type="text" id="Ctel" value="<%=rs("Ctel")%>" size="50" /> 可写多个电话</td>
       </tr>
	   <tr>
         <td align="right">传　　真：</td>
         <td><input name="Cfax" type="text" id="Cfax" value="<%=rs("Cfax")%>" size="50" /></td>
       </tr>
	   <tr>
         <td align="right">手机号码：</td>
         <td><input name="Cmobile" type="text" id="Cmobile" value="<%=rs("Cmobile")%>" size="50" /></td>
       </tr>
	   <tr>
         <td align="right">400 电话：</td>
         <td><input name="C400" type="text" id="C400" value="<%=rs("C400")%>" size="50" /></td>
       </tr>
	   <tr>
         <td align="right">邮　　箱：</td>
         <td><input name="Cemail" type="text" id="Cemail" value="<%=rs("Cemail")%>" size="50" /></td>
       </tr>
	   <tr>
         <td align="right">地图坐标X：</td>
         <td><input name="Czbx" type="text" id="Czbx" value="<%=rs("Czbx")%>" size="50" /></td>
       </tr>
	   <tr>
         <td align="right">地图坐标Y：</td>
         <td><input name="Czby" type="text" id="Czby" value="<%=rs("Czby")%>" size="50" /></td>
       </tr>
	   <tr>
         <td align="right">ICP备案号：</td>
         <td><input name="Cicp" type="text" id="Cicp" value="<%=rs("Cicp")%>" size="80" /></td>
       </tr>
       <tr>
            <td></td>
            <td>
            <input type="hidden" name="Cid" value="<%=rs("Cid")%>">
             <input name="submit" type="submit" value="更新" class="button"></td>
		</tr>
  </form>
</table>
</div>
<%
rs.Close
set rs=Nothing
%>

</body>
</html>
