function killErrors() {return true;}
window.onerror = killErrors;

//���½���ʾ
function showrightcorner(tit,content,W,H){
 $.messager.show({width:W,height:H,title:tit,msg:content,timeout:5000,showType:'fade'});
}
//������ʾ
function KqiqiErrMsg(str,sid){
$.messager.alert('������ʾ', str, 'error',function(){$(sid).focus();});
}

//����tab
function addTab(title,url){
	if(!$('#frmtab').tabs('exists',title)){
	   $('#frmtab').tabs('add',{
		   title:title,
		   content:'<iframe scrolling="yes" frameborder="0"  id="xaosfrm" name="xaosfrm" src="'+url+'" style="width:100%;height:100%;"></iframe>',
		   closable:true
		});
		//----------���IE6��src�������url��ȫû�ж�ȡ�ɹ�
		var ieset = navigator.userAgent;  
		if(ieset.indexOf("MSIE 6.0") > -1){//������ж� �����IE6
		setTimeout('window.parent[\'xaosfrm\'].location.reload();',0);//ִ����һ����
		}
	//--------------
	}else{
		$('#frmtab').tabs('select',title) ; 
	}
}

//����
function CopyData(objname) {
	var obj = $("#"+objname);
	obj.select();
	window.clipboardData.setData('Text',obj.val());
}

//ȫѡ
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }

//����loading
function oploading(){
parent.document.getElementById('light').style.display='block';
parent.document.getElementById('fade').style.display='block'
}

//ɾ��ͼƬ��ַ
function DelUrl(objname){
	var obj=$KQIQI(objname);
	if(obj.length==0) return false;
	var thisurl=obj.value; 
	if (thisurl=='') {alert('����ѡ��һ��ͼƬ��ַ���ٵ�ɾ����ť��');return false;}
	if(obj.selectedIndex==0){alert('����ɾ����һ��ͼƬ��ַ��');return false;}
	obj.options[obj.selectedIndex]=null;
}
//ͼƬԤ��
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

//�鿴���ϴ�
function chkShowUploadFiles(){
 if($("#IsShowUploadFiles").attr("checked")==true){$("#ShowUploadFiles").show();}else{$("#ShowUploadFiles").hide();}
}

//��Ϊ��ͼ
function SetPicUrl(objname,Insobjname){
	var obj=$KQIQI(objname);
	if(obj.length==0) return false;
	$KQIQI(Insobjname).value=obj.value;
}

//����
function $KQIQI(){return document.getElementById(arguments[0]);}