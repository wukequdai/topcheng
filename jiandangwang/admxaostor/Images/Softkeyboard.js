//****************************************************
// Software name:KQIQIECMS
// Email: 3955233@qq.com . QQ:3955233
//Web: http://www.kqiqi.com http://www.kqiqi.cn
//Copyright (C) Kqiqi Network All Rights Reserved.
//****************************************************
//定义当前是否大写的状态
var CapsLockValue=0;
var curEditName;
var check;
function setVariables() {
	tablewidth=630;  // logo width, in pixels
	tableheight=20;  // logo height, in pixels
	if (navigator.appName == "Netscape") {
	horz=".left";
	vert=".top";
	docStyle="document.";
	styleDoc="";
	innerW="window.innerWidth";
	innerH="window.innerHeight";
	offsetX="window.pageXOffset";
	offsetY="window.pageYOffset";
	}
	else {
	horz=".pixelLeft";
	vert=".pixelTop";
	docStyle="";
	styleDoc=".style";
	innerW="document.body.clientWidth";
	innerH="document.body.clientHeight";
	offsetX="document.body.scrollLeft";
	offsetY="document.body.scrollTop";
	}
}
function checkLocation() {
	if (check) {
	objectXY="softkeyboard";
	var availableX=eval(innerW);
	var availableY=eval(innerH);
	var currentX=eval(offsetX);
	var currentY=eval(offsetY);
	x=availableX-tablewidth+currentX;
	//y=availableY-tableheight+currentY;
	y=currentY;

	evalMove();
	}
	setTimeout("checkLocation()",0);
}
function evalMove() {
	eval(docStyle + objectXY + styleDoc + vert + "=" + y);
}

self.onError=null;
currentX = currentY = 0;  
whichIt = null;           
lastScrollX = 0; lastScrollY = 0;
NS = (document.layers) ? 1 : 0;
IE = (document.all) ? 1: 0;
function heartBeat() {
	if(IE) { diffY = document.body.scrollTop; diffX = document.body.scrollLeft; }
	if(NS) { diffY = self.pageYOffset; diffX = self.pageXOffset; }
	if(diffY != lastScrollY) {
		percent = .1 * (diffY - lastScrollY);
		if(percent > 0) percent = Math.ceil(percent);
		else percent = Math.floor(percent);
		if(IE) document.all.softkeyboard.style.pixelTop += percent;
		if(NS) document.softkeyboard.top += percent; 
		lastScrollY = lastScrollY + percent;}
	if(diffX != lastScrollX) {
		percent = .1 * (diffX - lastScrollX);
		if(percent > 0) percent = Math.ceil(percent);
		else percent = Math.floor(percent);
		if(IE) document.all.softkeyboard.style.pixelLeft += percent;
		if(NS) document.softkeyboard.left += percent;
		lastScrollX = lastScrollX + percent;
	}
}
function checkFocus(x,y) { 
	stalkerx = document.softkeyboard.pageX;
	stalkery = document.softkeyboard.pageY;
	stalkerwidth = document.softkeyboard.clip.width;
	stalkerheight = document.softkeyboard.clip.height;
	if( (x > stalkerx && x < (stalkerx+stalkerwidth)) && (y > stalkery && y < (stalkery+stalkerheight))) return true;
	else return false;}
function grabIt(e) {
	check = false;
	if(IE) {
		whichIt = event.srcElement;
		while (whichIt.id.indexOf("softkeyboard") == -1) {
			whichIt = whichIt.parentElement;
			if (whichIt == null) { return true; } }
		whichIt.style.pixelLeft = whichIt.offsetLeft;
		whichIt.style.pixelTop = whichIt.offsetTop;
		currentX = (event.clientX + document.body.scrollLeft);
		currentY = (event.clientY + document.body.scrollTop); 	
	} else { 
		window.captureEvents(Event.MOUSEMOVE);
		if(checkFocus (e.pageX,e.pageY)) { 
			whichIt = document.softkeyboard;
			StalkerTouchedX = e.pageX-document.softkeyboard.pageX;
			StalkerTouchedY = e.pageY-document.softkeyboard.pageY;
		} 
	}
	return true;
}
function moveIt(e) {
	if (whichIt == null) { return false; }
	if(IE) {
		newX = (event.clientX + document.body.scrollLeft);
		newY = (event.clientY + document.body.scrollTop);
		distanceX = (newX - currentX);    distanceY = (newY - currentY);
		currentX = newX;    currentY = newY;
		whichIt.style.pixelLeft += distanceX;
		whichIt.style.pixelTop += distanceY;
		if(whichIt.style.pixelTop < document.body.scrollTop) whichIt.style.pixelTop = document.body.scrollTop;
		if(whichIt.style.pixelLeft < document.body.scrollLeft) whichIt.style.pixelLeft = document.body.scrollLeft;
		if(whichIt.style.pixelLeft > document.body.offsetWidth - document.body.scrollLeft - whichIt.style.pixelWidth - 20) whichIt.style.pixelLeft = document.body.offsetWidth - whichIt.style.pixelWidth - 20;
		if(whichIt.style.pixelTop > document.body.offsetHeight + document.body.scrollTop - whichIt.style.pixelHeight - 5) whichIt.style.pixelTop = document.body.offsetHeight + document.body.scrollTop - whichIt.style.pixelHeight - 5;
		event.returnValue = false;
	} else { 
		whichIt.moveTo(e.pageX-StalkerTouchedX,e.pageY-StalkerTouchedY);
		if(whichIt.left < 0+self.pageXOffset) whichIt.left = 0+self.pageXOffset;
		if(whichIt.top < 0+self.pageYOffset) whichIt.top = 0+self.pageYOffset;
		if( (whichIt.left + whichIt.clip.width) >= (window.innerWidth+self.pageXOffset-17)) whichIt.left = ((window.innerWidth+self.pageXOffset)-whichIt.clip.width)-17;
		if( (whichIt.top + whichIt.clip.height) >= (window.innerHeight+self.pageYOffset-17)) whichIt.top = ((window.innerHeight+self.pageYOffset)-whichIt.clip.height)-17;
		return false;}
	return false;
}
function dropIt() {whichIt = null;
	if(NS) window.releaseEvents (Event.MOUSEMOVE);
	return true;	}
if(NS) {window.captureEvents(Event.MOUSEUP|Event.MOUSEDOWN);
	window.onmousedown = grabIt;
	window.onmousemove = moveIt;
	window.onmouseup = dropIt;	}
if(IE) {
	document.onmousedown = grabIt;
	document.onmousemove = moveIt;
	document.onmouseup = dropIt;	}
if(NS || IE) action = window.setInterval("heartBeat()",1);
document.write ('<style type=\"text/css\">.keyboardm{width:30px;height:23px;background:#363b31;border-width:2px;vertical-align:middle;padding-left:0.15em;padding-right:0.15em;border: 2px solid; border-color: #191e21 #616568 #616568 #191e21;margin:0;color:#fff;cursor: pointer;}.keyboardb{width:80px;height:23px;background:#363b31;border-width:2px;vertical-align:middle;padding-left:0.15em;padding-right:0.15em;border: 2px solid; border-color: #191e21 #616568 #616568 #191e21;margin:0;color:#fff;cursor: pointer;}.kqiqkeybg{background: #53565b;font-family:tahoma;font-size:12px;cursor: pointer;}</style>');
document.write ('<div align=center id=\"softkeyboard\" name=\"softkeyboard\" style=\"position:absolute; left:50%; top:298px; width:410px; z-index:180;display:none;margin-left:-200px;\" title=\"上海派网软键盘插件：IE下可随意拖动位置\">');
document.write ('  <table style=\"width:410px;\" border=\"0\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"kqiqkeybg\">');
document.write ('    <form name=\"Calc\" id=\"Calc\" action=\"\" method=\"post\" autocomplete=\"off\">');
document.write ('      <input type=\"hidden\" value=\"ok\" name=\"action2\">');
document.write ('      <tr> ');
document.write ('        <td align=\"left\" align=\"center\"> <input type=\"password\" value=\"\" name=\"password\" style=\"background:#9a9da2;width:151px;\"> ');
document.write ('          <input type=\"button\" value=\"输入完毕\" name=\"submit13\" class=\"keyboardb\" onclick=\"OverInput(curEditName);\"> <input class=\"keyboardb\" type=reset value=重新输入 name=\"submit23\" > ');
document.write ('        <input class=\"keyboardb\" type=\"button\" value=\"关闭\" name=\"submit222\" onclick=\"closekeyboard(curEditName);\"></td>');
document.write ('      </tr>');
document.write ('      <tr> ');
document.write ('        <td align=\"center\" bgcolor=\"#ffffff\" align=\"center\"> <table align=\"center\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">');
document.write ('            <tr align=\"left\" valign=\"middle\"> ');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'1\');\" value=\" 1 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'2\');\" value=\" 2 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'3\');\" value=\" 3 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'4\');\" value=\" 4 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'5\');\" value=\" 5 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'6\');\" value=\" 6 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'7\');\" value=\" 7 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'8\');\" value=\" 8 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'9\');\" value=\" 9 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'0\');\" value=\" 0 \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'-\');\" value=\" - \" class=\"keyboardm\" /></td>');
document.write ('              <td><input name=\"button10\" type=\"button\" value=\" BackSpace\" onclick=\"setpassvalue();\" class=\"keyboardb\" > </td>');
document.write ('            </tr>');
document.write ('            <tr align=\"left\" valign=\"middle\"> ');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'q\');\" value=\" q \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'w\');\" value=\" w \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'e\');\" value=\" e \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'r\');\" value=\" r \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'t\');\" value=\" t \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'y\');\" value=\" y \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'u\');\" value=\" u \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'i\');\" value=\" i \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'o\');\" value=\" o \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'p\');\" value=\" p \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"button6\" type=\"button\" onclick=\"addValue(\':\');\" value=\" : \" class=\"keyboardm\" /></td>');
document.write ('              <td><input name=\"button12\" type=\"button\" onclick=\"OverInput(curEditName);\" value=\"   Enter  \" class=\"keyboardb\" /> ');
document.write ('              </td>');
document.write ('            </tr>');
document.write ('            <tr align=\"left\" valign=\"middle\"> ');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'a\');\" value=\" a \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'s\');\" value=\" s \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'d\');\" value=\" d \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'f\');\" value=\" f \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'g\');\" value=\" g \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'h\');\" value=\" h \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'j\');\" value=\" j \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'k\');\" value=\" k \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'l\');\" value=\" l \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"button8\" type=\"button\" onclick=\"addValue(\'[\');\" value=\" [ \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"button9\" type=\"button\" onclick=\"addValue(\']\');\" value=\" ] \" class=\"keyboardm\" /></td>');
document.write ('              <td><input name=\"button9\" type=\"button\" onclick=\"setCapsLock();\" value=\"切换大小写\" class=\"keyboardb\" /></td>');
document.write ('            </tr>');
document.write ('            <tr align=\"left\" valign=\"middle\"> ');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'z\');\" value=\" z \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'x\');\" value=\" x \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'c\');\" value=\" c \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'v\');\" value=\" v \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'b\');\" value=\" b \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'n\');\" value=\" n \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'m\');\" value=\" m \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"button3\" type=\"button\" onclick=\"addValue(\'<\');\" value=\" < \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"button4\" type=\"button\" onclick=\"addValue(\'>\');\" value=\" > \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"button5\" type=\"button\" onclick=\"addValue(\'(\');\" value=\" ( \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"button7\" type=\"button\" onclick=\"addValue(\')\');\" value=\" ) \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input name=\"showCapsLockValue\" type=\"button\"  value=\"当前是小写\" class=\"keyboardb\" /></td>');
document.write ('            </tr>');
document.write ('            <tr align=\"left\" valign=\"middle\"> ');
document.write ('              <td> ');
document.write ('                <input name=\"button2\" type=\"button\" onclick=\"addValue(\',\');\" value=\" , \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'~\');\" value=\" ~ \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'!\');\" value=\" ! \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'@\');\" value=\" @ \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'#\');\" value=\" # \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'$\');\" value=\" $ \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'%\');\" value=\" % \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'^\');\" value=\" ^ \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'*\');\" value=\" * \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'|\');\" value=\" | \" class=\"keyboardm\" /></td>');
document.write ('              <td> ');
document.write ('                <input type=\"button\" onclick=\"addValue(\'?\');\" value=\" ? \" class=\"keyboardm\" /></td>');
document.write ('              <td><input name=\"button\" type=\"button\" onclick=\"addValue(\'=\');\" value=\"    =     \" class=\"keyboardb\" /></td>');
document.write ('            </tr>');
document.write ('          </table></td>');
document.write ('      </tr>');
document.write ('    </form>');
document.write ('  </table>');
document.write ('</div>');

//给输入的密码框添加新值
function addValue(newValue)
{
	if (CapsLockValue==0)
	{
		$ChunHua("Calc").password.value += newValue;
	}
	else
	{
		$ChunHua("Calc").password.value += newValue.toUpperCase();
	}
}
//实现BackSpace键的功能
function setpassvalue()
{
	var longnum=$ChunHua("Calc").password.value.length;
	var num
	num=$ChunHua("Calc").password.value.substr(0,longnum-1);
	$ChunHua("Calc").password.value=num;
}
//输入完毕
function OverInput(theForm)
{
	$ChunHua(theForm).value=$ChunHua("Calc").password.value;
	$ChunHua("softkeyboard").style.display="none";
	$ChunHua("Calc").password.value="";
}
//关闭软键盘
function closekeyboard(theForm)
{
	$ChunHua("softkeyboard").style.display="none";
}
//显示软键盘
function showkeyboard(x)
{  
	curEditName=x;
                $ChunHua("softkeyboard").style.display="block";
}

//设置是否大写的值
function setCapsLock()
{
	if (CapsLockValue==0)
	{
		CapsLockValue=1
		$ChunHua("Calc").showCapsLockValue.value="当前是大写";
		for (var i=0;i<$ChunHua("Calc").elements.length;i++)
		{
		var e = $ChunHua("Calc").elements[i];
		if (e.name != "button10" && e.name != "button12")
			{e.value = e.value.toUpperCase();}
		}
	}
	else 
	{
		CapsLockValue=0
		$ChunHua("Calc").showCapsLockValue.value="当前是小写";
		for (var i=0;i<$ChunHua("Calc").elements.length;i++)
		{
		var e = $ChunHua("Calc").elements[i];
		if (e.name != "button10" && e.name != "button12")
			{e.value = e.value.toLowerCase();}
		}
	}

}

//公共
function $ChunHua(){return document.getElementById(arguments[0]);}