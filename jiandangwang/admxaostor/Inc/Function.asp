<%
'===================================== 
'检测内容是否为空 
'=====================================
Function CheckEmpty(str)
  If str&""="" Then
	CheckEmpty=""
  Else
	CheckEmpty=str
  End if
End Function

function htmlcode(str) 
str=replace(str,"",chr(13))
str=replace(str,"<br><br>",chr(10)&chr(10)) 
str=replace(str,"<br>",chr(10))
htmlcode=str 
end function 

function htmlcode2(str)
str=replace(str,chr(13),"") 
str=replace(str,chr(10)&chr(10), "<br><br>")
str=replace(str,chr(10),"<br>")
htmlcode2=str 
end function 

'*************************************************
'表单数据过滤，敏感字符被替换,过滤SQL非法字符并格式化html代码
'*************************************************
Function DelStr(Str)
If IsNull(Str) Or IsEmpty(Str) Then
Str= ""
End If
DelStr=Replace(Str,"'","")
'DelStr=Replace(DelStr,"&","")
DelStr=Replace(DelStr,"%20","")
DelStr=Replace(DelStr,"<","")
DelStr=Replace(DelStr,">","")
DelStr=Replace(DelStr,"%","")
DelStr=Replace(DelStr,"|",",")
DelStr=Replace(DelStr,"，",",")
DelStr=Replace(DelStr,chr(13),"")
DelStr=Replace(DelStr,chr(10),"")
End Function

'*************************************************
'关键字转化
'*************************************************
Function KwdDelStr(Str)
If IsNull(Str) Or IsEmpty(Str) Then
Str= ""
End If
KwdDelStr=Replace(Str,"'","")
KwdDelStr=Replace(KwdDelStr,"&","")
KwdDelStr=Replace(KwdDelStr,"%20","")
KwdDelStr=Replace(KwdDelStr,"<","")
KwdDelStr=Replace(KwdDelStr,">","")
KwdDelStr=Replace(KwdDelStr,"%","")
KwdDelStr=Replace(KwdDelStr,"|",",")
KwdDelStr=Replace(KwdDelStr,",,",",")
KwdDelStr=Replace(KwdDelStr,"  "," ")
KwdDelStr=Replace(KwdDelStr," ",",")
End Function

'****************************************************
'编辑器修改  Sep_Editor
'****************************************************
function Sep_Editor(ContentID,initialValue)
	response.write "<script type=""text/javascript"" src=""sep_ckeditor/ckeditor/ckeditor.js""></script>"
	response.write "<script type=""text/javascript"" src=""sep_ckeditor/ckfinder/ckfinder.js""></script>"
	session("CKFinder_UserRole")="admin"
	set editor = New CKEditor
	editor.returnOutput = true
	editor.basePath = "./sep_ckeditor/ckeditor/"
	editor.config("width") = "98%"
	editor.config("height") = "300px"
	set textareaAttributes = CreateObject("Scripting.Dictionary")
	'textareaAttributes.Add "rows", 10
	'textareaAttributes.Add "cols", 80
	Set editor.textareaAttributes = textareaAttributes
	'initialValue = "文章内容"
	code = editor.editor(ContentID, initialValue)
	response.write code
end Function

'****************************************************
'文件上传  Sep_Upload
'****************************************************
function Sep_Upload(Sep_Filename,TID,FID)
%>
<iframe style="top:2px" ID="UploadFiles" width="350" height="25" src="Sep_Upframe.asp?TID=<%=TID%>&FID=<%=FID%>"" frameborder="0" scrolling="no" /></iframe>
<script type="text/javascript">
function callback<%=FID%>(succeed,filename){
	if(!succeed){alert(filename);return;}
	document.getElementById("<%=Sep_Filename%>").value=filename;
}
</script>
<%
end Function

'****************************************************
'文件批量上传  Sep_Upload_Batch
'****************************************************
function Sep_Upload_Batch(ID,PicUrl)
if ID=0 then
%>
<tr>
  <td align="right" class="forumrow" valign="top">批量图片： </td>
  <td class="forumrow" valign="top">
  <div id="batch_content"><%Sep_ArrPicUrls=Split(PicUrl,"@@")%>
      <a href="#"><img src="images/button.gif" /></a> <font color="#FF0000">* 每次最多上传<%=UpFileLimit%>个图片 </font><br />
      <textarea id="PicUrls" name="PicUrls" style="width:800px; height:150px; margin-top:5px;"><%
	  '列出图片路径
	  For i=0 To UBound(Sep_ArrPicUrls)-1
		  if i>0 then
		  response.Write vbcrlf
		  end if
		  response.Write Sep_ArrPicUrls(i)&"@@"
	  next%></textarea><br>
      
      <%'列出所有图片
	  For i=0 To UBound(Sep_ArrPicUrls)-1%>
      	<img src="<%=Sep_ArrPicUrls(i)%>" width="90" height="50" style="margin:5px;" />
	  <%next%>
      <div id="trace"></div>
  </div></td>
</tr>
<%else%>
<!--批量上传脚本文件-->
<link href="images/mo.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="scripts/swfupload.js"></script>
<script type="text/javascript" src="scripts/swfupload.handler.js"></script>
<script type="text/javascript">
var swfu,Files=[];
function UploadSucceedCallBack(file,File){
	//文件上传成功后调用的函数
	//$_("trace").innerHTML+=file.name + " => " + file.newname + "," + File.name2 + "<br />";
	//在表单里显示记录			
	document.getElementById("PicUrls").value += "<%=SaveUpFilesPath%>/<%= Year(date()) & right("0" & month(Date()),2) %>/" + file.newname + "@@";
}
function BeforeUploadCallBack(file){
   this.SetPostParam("name","anlige");
}
window.onload=function(s){
	return function(){swfu=HandlerInit(s);};
}({
	upload_url: "Sep_Upload_Batch.asp",
	file_post_name : "filedata",
	button_append : "divAddFiles",
	bind_id:"moswf",
	file_types : "<%=UpFileTypeBatch%>",
	file_types_description : "选择文件",
	file_size_limit : "<%=MaxFileSize%>",
	file_upload_limit : <%=UpFileLimit%>,
	
	button_width: 24,
	button_height: 24,
	button_image_url:"images/btn16.png",
	auto:false
});
</script>
<!--批量上传脚本文件 end-->
<div id="batch_alert">
	<h4><span id="close">关闭</span></h4>
    <div id="upload">
		<div id="btns">
		<input onClick="swfu.stopUpload();" type="image" src="images/stop.png" style="float:right;" id="dostop" />
		<input onClick="swfu.startUploadFiles();" type="image" src="images/up.png" style="float:right;" id="doupload" />
		<span id="divAddFiles"></span><span id="message"> *选择文件后点击<img src="images/up.png" width="16" />上传</span></div>
		<div id="moswf">
			<div class="filelist h24"><div class="process_bar h24"></div><div class="info_bar h24"><ul><li class="w_name"><span class="s_name">文件名</span></li><li class="w_process">进度</li><li class="w_size">速度</li><li class="w_act">操作</li></ul></div></div>
		</div>
		<div id="trace"></div>
	</div>
</div>
<script type="text/javascript" src="images/batch.js"></script>
<%
end if
end Function

'*************************************************
'生成静态文件删除(文件)
'*************************************************
function FileDel(FileName)
on error resume next
dim fso
Set fso = server.CreateObject("scripting.filesystemobject")
on error resume next
if fso.FileExists(Server.MapPath(FileName)) then
   fso.DeleteFile server.MapPath(FileName),true
end if
set fso=nothing
end function


'*************************************************
'函数名：gotTopic
'作  用：截字符串，汉字一个算两个字符，英文算一个字符
'参  数：str   ----原字符串
'       strlen ----截取长度
'返回值：截取后的字符串
'*************************************************
function gotTopic(str,strlen)
	if str="" then
		gotTopic=""
		exit function
	end if
	dim l,t,c, i
	str=replace(replace(replace(replace(str,"&nbsp;"," "),"&quot;",chr(34)),"&gt;",">"),"&lt;","<")
	l=len(str)
	t=0
	for i=1 to l
		c=Abs(Asc(Mid(str,i,1)))
		if c>255 then
			t=t+2
		else
			t=t+1
		end if
		if t>=strlen then
			gotTopic=left(str,i) & "…"
			exit for
		else
			gotTopic=str
		end if
	next
	gotTopic=replace(replace(replace(replace(gotTopic," ","&nbsp;"),chr(34),"&quot;"),">","&gt;"),"<","&lt;")
end function

'***********************************************
'函数名：JoinChar
'作  用：向地址中加入 ? 或 &
'参  数：strUrl  ----网址
'返回值：加了 ? 或 & 的网址
'***********************************************
function JoinChar(strUrl)
	if strUrl="" then
		JoinChar=""
		exit function
	end if
	if InStr(strUrl,"?")<len(strUrl) then
		if InStr(strUrl,"?")>1 then
			if InStr(strUrl,"&")<len(strUrl) then
				JoinChar=strUrl & "&"
			else
				JoinChar=strUrl
			end if
		else
			JoinChar=strUrl & "?"
		end if
	else
		JoinChar=strUrl
	end if
end function

'***********************************************
'过程名：showpage
'作  用：显示“上一页 下一页”等信息
'参  数：sfilename  ----链接地址
'       totalnumber ----总数量
'       maxperpage  ----每页数量
'       ShowTotal   ----是否显示总数量
'       ShowAllPages ---是否用下拉列表显示所有页面以供跳转。有某些页面不能使用，否则会出现JS错误。
'       strUnit     ----计数单位
'***********************************************
sub showpage(sfilename,totalnumber,maxperpage,ShowTotal,ShowAllPages,strUnit)
	dim n, i,strTemp,strUrl
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<div class=turnover>"
	strTemp=strTemp & "<span class=disabled>共<font color=blue><b>" & totalnumber & "</b></font>" & strUnit & "</span>"
	strUrl=JoinChar(sfilename)
  	if CurrentPage<2 then
    		strTemp=strTemp & "<span class=disabled>首页 上页</span>"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=1'>首页</a>"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage-1) & "'>上页</a>"
  	end if

  	if n-currentpage<1 then
    		strTemp=strTemp & "<span class=disabled>下页 尾页</span>"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage+1) & "'>下页</a>"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & n & "'>尾页</a>"
  	end if
   	strTemp=strTemp & "<span class=disabled>页次：<strong><font color=red>" & CurrentPage & "</font>/" & n & "</strong>页 "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "/页</span>"
	'if ShowAllPages=True then
		'strTemp=strTemp & "&nbsp;转到：<select name='page' size='1' onchange=""javascript:window.location='" & strUrl & "page=" & "'+this.options[this.selectedIndex].value;"">"
    	'for i = 1 to n
    		'strTemp=strTemp & "<option value='" & i & "'"
			'if cint(CurrentPage)=cint(i) then strTemp=strTemp & " selected "
			'strTemp=strTemp & ">第" & i & "页</option>"
	    'next
		'strTemp=strTemp & "</select>"
	'end if
	strTemp=strTemp & "</div>"
	response.write strTemp
end sub

'********************************************
'函数名：IsValidEmail
'作  用：检查Email地址合法性
'参  数：email ----要检查的Email地址
'返回值：True  ----Email地址合法
'       False ----Email地址不合法
'********************************************
function IsValidEmail(email)
	dim names, name, i, c
	IsValidEmail = true
	names = Split(email, "@")
	if UBound(names) <> 1 then
	   IsValidEmail = false
	   exit function
	end if
	for each name in names
		if Len(name) <= 0 then
			IsValidEmail = false
    		exit function
		end if
		for i = 1 to Len(name)
		    c = Lcase(Mid(name, i, 1))
			if InStr("abcdefghijklmnopqrstuvwxyz_-.", c) <= 0 and not IsNumeric(c) then
		       IsValidEmail = false
		       exit function
		     end if
	   next
	   if Left(name, 1) = "." or Right(name, 1) = "." then
    	  IsValidEmail = false
	      exit function
	   end if
	next
	if InStr(names(1), ".") <= 0 then
		IsValidEmail = false
	   exit function
	end if
	i = Len(names(1)) - InStrRev(names(1), ".")
	if i <> 2 and i <> 3 then
	   IsValidEmail = false
	   exit function
	end if
	if InStr(email, "..") > 0 then
	   IsValidEmail = false
	end if
end function

'***************************************************
'函数名：IsObjInstalled
'作  用：检查组件是否已经安装
'参  数：strClassString ----组件名
'返回值：True  ----已经安装
'       False ----没有安装
'***************************************************
Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

'**************************************************
'函数名：strLength
'作  用：求字符串长度。汉字算两个字符，英文算一个字符。
'参  数：str  ----要求长度的字符串
'返回值：字符串长度
'**************************************************
function strLength(str)
	ON ERROR RESUME NEXT
	dim WINNT_CHINESE
	WINNT_CHINESE    = (len("中国")=2)
	if WINNT_CHINESE then
        dim l,t,c
        dim i
        l=len(str)
        t=l
        for i=1 to l
        	c=asc(mid(str,i,1))
            if c<0 then c=c+65536
            if c>255 then
                t=t+1
            end if
        next
        strLength=t
    else
        strLength=len(str)
    end if
    if err.number<>0 then err.clear
end function


'**************************************************
'函数名：SendMail
'作  用：用Jmail组件发送邮件
'参  数：MailtoAddress  ----收信人地址
'        MailtoName    -----收信人姓名
'        Subject       -----主题
'        MailBody      -----信件内容
'        FromName      -----发信人姓名
'        MailFrom      -----发信人地址
'        Priority      -----信件优先级
'**************************************************
function SendMail(MailtoAddress,MailtoName,Subject,MailBody,FromName,MailFrom,Priority)
	on error resume next
	Dim JMail
	Set JMail=Server.CreateObject("JMAIL.Message")
	if err then
		SendMail= "<br><li>没有安装JMail组件</li>"
		err.clear
		exit function
	end if
	JMail.Charset="gb2312"          '邮件编码
	JMail.silent=true
	JMail.ContentType = "text/html"     '邮件正文格式
	JMail.ServerAddress=MailServer     '用来发送邮件的SMTP服务器
   	'如果服务器需要SMTP身份验证则还需指定以下参数
	JMail.MailServerUserName = MailServerUserName    '登录用户名
   	JMail.MailServerPassWord = MailServerPassword        '登录密码
    JMail.MailDomain = MailDomain       '域名（如果用“name@domain.com”这样的用户名登录时，请指明domain.com

	JMail.AddRecipient MailtoAddress,MailtoName     '收信人
	JMail.Subject=Subject         '主题
	JMail.HMTLBody=MailBody       '邮件正文（HTML格式）
	JMail.Body=MailBody          '邮件正文（纯文本格式）
	JMail.FromName=FromName         '发信人姓名
	JMail.From = MailFrom         '发信人Email
	JMail.Priority=Priority              '邮件等级，1为加急，3为普通，5为低级
	JMail.Send(MailServer)
	SendMail =JMail.ErrorMessage
	JMail.Close
	Set JMail=nothing
end function

'****************************************************
'过程名：LoginErrMsg
'作  用：显示登陆错误提示信息
'参  数：无
'****************************************************
function LoginErrMsg(errmsg)
	dim strErr
	strErr=strErr & "<link href='Images/hi.xaos.css' rel='stylesheet' /><div class='center_div loading_block'>" & vbcrlf
	strErr=strErr & "<div class='loading_logo'><img src='Images/load_logo.gif' width='210' height='29' /></div>" & vbcrlf
	strErr=strErr & "<div class='loading_bar'><img src='Images/hixaos.gif' width='220' height='19' />" & vbcrlf
	strErr=strErr & "<p style='padding-top:5px;'><img src='Images/no.gif' width='16' height='16' align='absmiddle' /> &nbsp;<b>对不起！登录失败！</b></p>"
	strErr=strErr & "<p style='padding-top:10px;'> " & errmsg &"</p></div>" & vbcrlf
	strErr=strErr & "<div class='loading_onclick'><img src='images/back.gif' align='absmiddle'>&nbsp;"
	strErr=strErr & "<a href=javascript:history.go(-1) style='cursor:pointer'>返回重新登录</a></div>" & vbcrlf
	strErr=strErr & "</div><div class='hiddenDiv'></div>" & vbcrlf
	response.write strErr
	response.end
end function


'****************************************************
'过程名：WriteErrMsg
'作  用：显示错误提示信息
'参  数：无
'****************************************************
function WriteErrMsg(errmsg)
	dim strErr
	strErr=strErr & "<link href='Images/hi.xaos.css' rel='stylesheet' /><div class='center_div loading_block'>" & vbcrlf
	strErr=strErr & "<div class='loading_logo'><img src='Images/load_logo.gif' width='210' height='29' /></div>" & vbcrlf
	strErr=strErr & "<div class='loading_bar'><img src='Images/hixaos.gif' width='220' height='19' />" & vbcrlf
	strErr=strErr & "<p style='padding-top:5px;'><img src='Images/no.gif' width='16' height='16' align='absmiddle' /> &nbsp;<b>对不起！操作失败！</b></p>"
	strErr=strErr & "<p style='padding-top:10px;'> " & errmsg &"</p></div>" & vbcrlf
	strErr=strErr & "<div class='loading_onclick'><img src='images/back.gif' align='absmiddle'>&nbsp;"
	strErr=strErr & "<a href=javascript:history.go(-1) style='cursor:pointer'>返回上一页</a></div>" & vbcrlf
	strErr=strErr & "</div><div class='hiddenDiv'></div>" & vbcrlf
	response.write strErr
	response.end
end function

'****************************************************
'过程名：WriteSuccessMsg
'作  用：显示成功提示信息
'参  数：无
'****************************************************
function WriteSuccessMsg(SuccessMsg,SuccessUrl)
	dim strSuccess
	strSuccess=strSuccess & "<link href='Images/hi.xaos.css' rel='stylesheet' />"
	strSuccess=strSuccess & "<script>"
	strSuccess=strSuccess & "var cnt = 1;"
	strSuccess=strSuccess & "function lod(){"
	strSuccess=strSuccess & "if(cnt < 1){"
	strSuccess=strSuccess & "window.location.href = '" & SuccessUrl &"';"
	strSuccess=strSuccess & "}else{"
	strSuccess=strSuccess & "document.getElementById('showTime').innerHTML = '页面 <font color=red>' + cnt + '</font> 秒后自动跳转';"
	strSuccess=strSuccess & "cnt--;"
	strSuccess=strSuccess & "}"
	strSuccess=strSuccess & "setTimeout('lod()',1000);"
	strSuccess=strSuccess & "}"
	strSuccess=strSuccess & "</script>"
	strSuccess=strSuccess & "<body onload='lod()'>"
	strSuccess=strSuccess & "<div class='center_div loading_block'>" & vbcrlf
	strSuccess=strSuccess & "<div class='loading_logo'><img src='Images/load_logo.gif' width='210' height='29' /></div>" & vbcrlf
	strSuccess=strSuccess & "<div class='loading_bar'><img src='Images/hixaos.gif' width='220' height='19' />" & vbcrlf
	strSuccess=strSuccess & "<p style='padding-top:10px;'><img src='images/ok.gif' align='absmiddle' />&nbsp; " & vbcrlf
	strSuccess=strSuccess & "<strong>恭喜你！" & SuccessMsg &"成功！</strong>" & vbcrlf
	strSuccess=strSuccess & "</p></div>" & vbcrlf
	strSuccess=strSuccess & "<p style='padding-top:10px;'><div id='showTime'></div></p>"
	strSuccess=strSuccess & "<p style='padding-top:10px;'>如果没有自动跳转，请点击下面的按钮！</p>"
	strSuccess=strSuccess & "<div class='loading_onclick'><img src='images/back.gif' align='absmiddle'>" & vbcrlf
	strSuccess=strSuccess & "<a href='" & SuccessUrl &"'>【返回列表】</a></div>" & vbcrlf
	strSuccess=strSuccess & "</div><div class='hiddenDiv'></div>" & vbcrlf
	strSuccess=strSuccess & "</body>"
	response.write strSuccess
	response.end
end function

'===========================================
'分页代码
'===========================================
function Pagelist()


'上一页开始
if request("page")="" then
Lin_page=1
else
Lin_page=cint(request("page"))
end if

if Rs.pagecount>1 then
Response.Write "<div class=turnover>"

if Lin_page<=1 then
'Response.Write ("<span class=""disabled"">首页</span>")
'Response.Write ("<span class=""disabled"">上页</span>")
else
Response.Write("<a href="&thisUrl&"?"&strFileName&"Page=1>首页</a>")
Response.Write("<a href="&thisUrl&"?"&strFileName&"Page=" & (Lin_page-1) & ">上页</a>")
end if

'数字分页开始

if pagecount>=10 then
response.write"<a href="&thisUrl&"?"&strFileName&"Page="&(((cstr(pagecount)\10)-1)*10)+1&"><<</a>"
end if
q=(cstr(pagecount)-1)\10
if q<0 then
q=1
end if
p=(q*10)+1
do while p<((q*10)+11)
If p=pagecount Then
Response.Write "<span class=""current"">"&p&"</span>"
Elseif p<=Rs.pagecount then
Response.Write "<a href='"&thisUrl&"?"&strFileName&"Page="&p&"'>"& p &"</a>"
End If
p=p+1
loop
A=Rs.pagecount
if (A mod 10)=0 then
A=Rs.pagecount-1
end if
if pagecount<(A\10)*10 then
response.write"<a href="&thisUrl&"?"&strFileName&"Page="&((((cstr(pagecount)-1)\10)+1)*10)+1&">>></a>"
end if

'下一页开始

if Lin_page>=Rs.pagecount then
Response.Write ("<span class=""disabled"">下页</span>")
Response.Write ("<span class=""disabled"">尾页</span>")
else
Response.Write("<a href="&thisUrl&"?"&strFileName&"Page=" & (Lin_page+1) & ">下页</a>")
Response.Write("<a href="&thisUrl&"?"&strFileName&"Page=" & Rs.pagecount & ">尾页</a>")
end if

Response.Write "<span class=""disabled"">共"&Rs.pagecount&"页&nbsp;共"&Rs.recordcount&"条</span>"
'Response.Write "第<font color=#ff0000>"&pagecount&"</font>页 共"&Rs.pagecount&"页&nbsp;&nbsp;共<font color=#ff0000>"&Rs.recordcount&"</font>条&nbsp;"
Response.Write "</div>"

End If

end function
%>
