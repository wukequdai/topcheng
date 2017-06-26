function killErrors() {return true;}
window.onerror = killErrors;

//右下角提示
function showrightcorner(tit,content,W,H){
 $.messager.show({width:W,height:H,title:tit,msg:content,timeout:5000,showType:'fade'});
}
//操作提示
function KqiqiErrMsg(str,sid){
$.messager.alert('错误提示', str, 'error',function(){$(sid).focus();});
}

//新增tab
function addTab(title,url){
	if(!$('#frmtab').tabs('exists',title)){
	   $('#frmtab').tabs('add',{
		   title:title,
		   content:'<iframe scrolling="yes" frameborder="0"  id="xaosfrm" name="xaosfrm" src="'+url+'" style="width:100%;height:100%;"></iframe>',
		   closable:true
		});
		//----------解决IE6下src中请求的url完全没有读取成功
		var ieset = navigator.userAgent;  
		if(ieset.indexOf("MSIE 6.0") > -1){//浏览器判断 如果是IE6
		setTimeout('window.parent[\'xaosfrm\'].location.reload();',0);//执行这一方法
		}
	//--------------
	}else{
		$('#frmtab').tabs('select',title) ; 
	}
}

//复制
function CopyData(objname) {
	var obj = $("#"+objname);
	obj.select();
	window.clipboardData.setData('Text',obj.val());
}

//全选
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }

//操作loading
function oploading(){
parent.document.getElementById('light').style.display='block';
parent.document.getElementById('fade').style.display='block'
}

//删除图片地址
function DelUrl(objname){
	var obj=$KQIQI(objname);
	if(obj.length==0) return false;
	var thisurl=obj.value; 
	if (thisurl=='') {alert('请先选择一个图片地址，再点删除按钮！');return false;}
	if(obj.selectedIndex==0){alert('不能删除第一个图片地址！');return false;}
	obj.options[obj.selectedIndex]=null;
}
//图片预览
function doPreview(objname,Upath){
	var obj=$KQIQI(objname);
	if(obj.length==0) return false;
	var url=obj.value; 
	if (url){
		url = url.replace("/UploadFiles/",Upath);
		var sExt=url.substr(url.lastIndexOf(".")+1);
		sExt=sExt.toUpperCase();
		var sHTML;
		switch(sExt){
		case "GIF":
		case "JPG":
		case "BMP":
		case "PNG":
			$KQIQI("tdPreview").innerHTML = "<img border='0' src='" + url + "' width='170' height='140'>";
			break;
		default:
			$KQIQI("tdPreview").innerHTML = "";
			break;
		}
	}else{
		$KQIQI("tdPreview").innerHTML = "";
	}
}

//查看已上传
function chkShowUploadFiles(){
 if($("#IsShowUploadFiles").attr("checked")==true){$("#ShowUploadFiles").show();}else{$("#ShowUploadFiles").hide();}
}

//设为缩图
function SetPicUrl(objname,Insobjname){
	var obj=$KQIQI(objname);
	if(obj.length==0) return false;
	$KQIQI(Insobjname).value=obj.value;
}

//公共
function $KQIQI(){return document.getElementById(arguments[0]);}