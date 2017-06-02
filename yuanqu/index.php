<?php
if(empty($_POST['dopost'])) $dopost = '';
else $dopost = $_POST['dopost'];
$rmurl = "http://updatenew.dedecms.com/base-v57/dedecms/newver2.txt";
//修改密码，并下载DedeCms进行安装
if($dopost=='mdpwd')
{
	$oldpwd = $_POST['oldpwd'];
	$newpwd = $_POST['dbpwd'];
	$conn = mysql_connect('localhost','root',stripslashes($oldpwd));
	if(!$conn) {
		ShowMsg("数据库初始密码错误，请输入正确的初始密码！","index.php?rand=".time());
		exit();
	}
	
	if($newpwd!='')
	{
		 if(!mysql_query(" update mysql.user set Password=password('$newpwd') where User='root' ",$conn))
		 {
			  ShowMsg("修改密码失败！" & mysql_error(),"index.php");
		    exit();
		 }
		 mysql_query("flush privileges ",$conn);
		 $conn = mysql_connect('localhost','root',stripslashes($newpwd));
		 if(!$conn) {
		    ShowMsg("重新连接数据库失败，请返回前页，用新密码作为初始密码尝试连接！","-1");
		    exit();
		 }
		 $oldpwd = $newpwd;
	}
	$oldpwd = stripslashes($oldpwd);
	echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />";
	echo "修改密码成功，现在获取最新版DedeCms信息...<br />";
	$infoString = file_get_contents($rmurl) or die("连接远程网址失败！");
	$infos = split(',',$infoString);
  $rmurl = trim($infos[0]);
  echo "修改密码成功，现在开始下载DEDE安装包...<br />";
  $zipbin = file_get_contents($rmurl);
	$fp = fopen(dirname(__FILE__).'/tmp.zip','w');
	fwrite($fp,$zipbin);
	unset($zipbin);
	fclose($fp);
	echo "成功下载DEDE安装包，现在进行解压及初处理...<br />";
	$z = new zip();
  $z->ExtractAll ( dirname(__FILE__).'/tmp.zip', dirname(__FILE__));
  echo "成功解压DEDE安装包，现在对解压后的文件进行初处理...<br />";
  $mdfile = trim($infos[1]);
  $mdvalue = trim($infos[2]);
  $fp = fopen('./'.$mdfile,'r');
  $str = fread($fp,filesize('./'.$mdfile));
  fclose($fp);
  $str = str_replace($mdvalue,$mdvalue." value=\"$oldpwd\" ",$str);
  $fp = fopen('./'.$mdfile,'w');
  $str = fwrite($fp,$str);
  fclose($fp);
  unlink("./tmp.zip");
  //unlink("./initDede.php");
  unlink("./phpinfo.php");
  unlink("./loading1.gif");
  ShowMsg("成功下载程序并处理，现转向安装页&gt;&gt;","install/index.php");
  exit();
}


function MoveDir()
{
	
}

function ShowMsg($msg,$gourl,$onlymsg=0,$limittime=0)
{
	if(empty($GLOBALS['cfg_phpurl'])) $GLOBALS['cfg_phpurl'] = '..';
	$htmlhead  = "<html>\r\n<head>\r\n<title>DEDECMS提示信息</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n";
	$htmlhead .= "<base target='_self'/>\r\n<style>div{line-height:160%;}</style></head>\r\n<body leftmargin='0' topmargin='0'>\r\n<center>\r\n<script>\r\n";
	$htmlfoot  = "</script>\r\n</center>\r\n</body>\r\n</html>\r\n";

	if($limittime==0) $litime = 1000;
	else $litime = $limittime;

	if($gourl=="-1"){
		if($limittime==0) $litime = 5000;
		$gourl = "javascript:history.go(-1);";
	}

	if($gourl==''||$onlymsg==1){
		$msg = "<script>alert(\"".str_replace("\"","“",$msg)."\");</script>";
	}else{
		$func = "      var pgo=0;
      function JumpUrl(){
        if(pgo==0){ location='$gourl'; pgo=1; }
      }\r\n";
		$rmsg = $func;
		$rmsg .= "document.write(\"<br /><div style='width:450px;padding:0px;border:1px solid #D1DDAA;'>";
		$rmsg .= "<div style='padding:6px;font-size:12px;border-bottom:1px solid #D1DDAA;background:#DBEEBD';'><b>DEDECMS 提示信息！</b></div>\");\r\n";
		$rmsg .= "document.write(\"<div style='height:130px;font-size:10pt;background:#ffffff'><br />\");\r\n";
		$rmsg .= "document.write(\"".str_replace("\"","“",$msg)."\");\r\n";
		$rmsg .= "document.write(\"";
		if($onlymsg==0){
			if($gourl!="javascript:;" && $gourl!=""){ $rmsg .= "<br /><a href='{$gourl}'>如果你的浏览器没反应，请点击这里...</a>"; }
			$rmsg .= "<br/></div>\");\r\n";
			if($gourl!="javascript:;" && $gourl!=''){ $rmsg .= "setTimeout('JumpUrl()',$litime);"; }
		}else{ $rmsg .= "<br/><br/></div>\");\r\n"; }
		$msg  = $htmlhead.$rmsg.$htmlfoot;
	}
	echo $msg;
}

/*
$z = new zip();
2、解压缩整个ZIP文件
$z->ExtractAll ( $zipfile, $todir);
*/
class zip
{

 var $datasec, $ctrl_dir = array();
 var $eof_ctrl_dir = "\x50\x4b\x05\x06\x00\x00\x00\x00";
 var $old_offset = 0; var $dirs = Array(".");

 function get_List($zip_name)
 {
   $ret = '';
   $zip = @fopen($zip_name, 'rb');
   if(!$zip) return(0);
   $centd = $this->ReadCentralDir($zip,$zip_name);

    @rewind($zip);
    @fseek($zip, $centd['offset']);

   for ($i=0; $i<$centd['entries']; $i++)
   {
    $header = $this->ReadCentralFileHeaders($zip);
    $header['index'] = $i;$info['filename'] = $header['filename'];
    $info['stored_filename'] = $header['stored_filename'];
    $info['size'] = $header['size'];$info['compressed_size']=$header['compressed_size'];
    $info['crc'] = strtoupper(dechex( $header['crc'] ));
    $info['mtime'] = $header['mtime']; $info['comment'] = $header['comment'];
    $info['folder'] = ($header['external']==0x41FF0010||$header['external']==16)?1:0;
    $info['index'] = $header['index'];$info['status'] = $header['status'];
    $ret[]=$info; unset($header);
   }
  return $ret;
 }

 function Add($files,$compact)
 {
  if(!is_array($files[0])) $files=Array($files);

  for($i=0;$files[$i];$i++){
    $fn = $files[$i];
    if(!in_Array(dirname($fn[0]),$this->dirs))
     $this->add_Dir(dirname($fn[0]));
    if(basename($fn[0]))
     $ret[basename($fn[0])]=$this->add_File($fn[1],$fn[0],$compact);
  }
  return $ret;
 }

 function get_file()
 {
   $data = implode('', $this -> datasec);
   $ctrldir = implode('', $this -> ctrl_dir);

   return $data . $ctrldir . $this -> eof_ctrl_dir .
    pack('v', sizeof($this -> ctrl_dir)).pack('v', sizeof($this -> ctrl_dir)).
    pack('V', strlen($ctrldir)) . pack('V', strlen($data)) . "\x00\x00";
 }

 function add_dir($name) 
 { 
   $name = str_replace("\\", "/", $name); 
   $fr = "\x50\x4b\x03\x04\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00"; 

   $fr .= pack("V",0).pack("V",0).pack("V",0).pack("v", strlen($name) ); 
   $fr .= pack("v", 0 ).$name.pack("V", 0).pack("V", 0).pack("V", 0); 
   $this -> datasec[] = $fr;

   $new_offset = strlen(implode("", $this->datasec)); 

   $cdrec = "\x50\x4b\x01\x02\x00\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00"; 
   $cdrec .= pack("V",0).pack("V",0).pack("V",0).pack("v", strlen($name) ); 
   $cdrec .= pack("v", 0 ).pack("v", 0 ).pack("v", 0 ).pack("v", 0 ); 
   $ext = "\xff\xff\xff\xff"; 
   $cdrec .= pack("V", 16 ).pack("V", $this -> old_offset ).$name; 

   $this -> ctrl_dir[] = $cdrec; 
   $this -> old_offset = $new_offset; 
   $this -> dirs[] = $name;
 }
 
 //编译指定的文件为zip文件（filename可以为文件数组array、目录dir或单个文件file）
 //it柏拉图增加的方法
 function CompileZipFile($filename, $tozipfilename,$ftype='dir')
 {
    if (@function_exists('gzcompress'))
    {
      if($ftype=='dir') $filelist =  $this->ListDirFiles($filename);
      else if($ftype=='file') $filelist[] =  $filename;
      else $filelist =  $filename;
      $i = 0;
      if(count($filelist)>0)
      {
         foreach($filelist as $filename)
         {
           if (is_file($filename))
           {
              $i++;
              $fd = fopen ($filename, "r");
              if(filesize($filename)>0) $content = fread($fd, filesize($filename));
              else $content = ' ';
              fclose ($fd);
              //if (is_array($dir)) $filename = basename($filename);
              $this->add_File($content, $filename);
           }
         }
         $out = $this->get_file();
         $fp = fopen($tozipfilename, "w");
         fwrite($fp, $out, strlen($out));
         fclose($fp);
       }
       return $i;
     } 
     else return 0;
 }
 
 //读取某文件夹的所有文件
 function ListDirFiles($dirname)
 {   
   $files = array();   
   if(is_dir($dirname))
   {   
     $fh = opendir($dirname);   
     while (($file = readdir($fh)) !== false)
     {   
       if (strcmp($file, '.')==0 || strcmp($file, '..')==0) continue;   
       $filepath = $dirname . '/' . $file;   
       if ( is_dir($filepath) )   
         $files = array_merge($files, $this->ListDirFiles($filepath));   
       else   
         array_push($files, $filepath);   
     }   
     closedir($fh);   
   }else {   
    $files = false;   
   }   
   return $files;   
 }

 function add_File($data, $name, $compact = 1)
 {
   $name     = str_replace('\\', '/', $name);
   $dtime    = dechex($this->DosTime());

   $hexdtime = '\x' . $dtime[6] . $dtime[7].'\x'.$dtime[4] . $dtime[5]
     . '\x' . $dtime[2] . $dtime[3].'\x'.$dtime[0].$dtime[1];
   eval('$hexdtime = "' . $hexdtime . '";');

   if($compact)
   $fr = "\x50\x4b\x03\x04\x14\x00\x00\x00\x08\x00".$hexdtime;
   else $fr = "\x50\x4b\x03\x04\x0a\x00\x00\x00\x00\x00".$hexdtime;
   $unc_len = strlen($data); $crc = crc32($data);

   if($compact){
     $zdata = gzcompress($data); $c_len = strlen($zdata);
     $zdata = substr(substr($zdata, 0, strlen($zdata) - 4), 2);
   }else{
     $zdata = $data;
   }
   $c_len=strlen($zdata);
   $fr .= pack('V', $crc).pack('V', $c_len).pack('V', $unc_len);
   $fr .= pack('v', strlen($name)).pack('v', 0).$name.$zdata;

   $fr .= pack('V', $crc).pack('V', $c_len).pack('V', $unc_len);

   $this -> datasec[] = $fr;
   $new_offset        = strlen(implode('', $this->datasec));
   if($compact)
        $cdrec = "\x50\x4b\x01\x02\x00\x00\x14\x00\x00\x00\x08\x00";
   else $cdrec = "\x50\x4b\x01\x02\x14\x00\x0a\x00\x00\x00\x00\x00";
   $cdrec .= $hexdtime.pack('V', $crc).pack('V', $c_len).pack('V', $unc_len);
   $cdrec .= pack('v', strlen($name) ).pack('v', 0 ).pack('v', 0 );
   $cdrec .= pack('v', 0 ).pack('v', 0 ).pack('V', 32 );
   $cdrec .= pack('V', $this -> old_offset );

   $this -> old_offset = $new_offset;
   $cdrec .= $name;
   $this -> ctrl_dir[] = $cdrec;
   return true;
 }

 function DosTime() {
   $timearray = getdate();
   if ($timearray['year'] < 1980) {
     $timearray['year'] = 1980; $timearray['mon'] = 1;
     $timearray['mday'] = 1; $timearray['hours'] = 0;
     $timearray['minutes'] = 0; $timearray['seconds'] = 0;
   }
   return (($timearray['year'] - 1980) << 25) | ($timearray['mon'] << 21) |     ($timearray['mday'] << 16) | ($timearray['hours'] << 11) | 
    ($timearray['minutes'] << 5) | ($timearray['seconds'] >> 1);
 }
 
 //解压整个压缩包
 //直接用 Extract 会有路径问题，本函数先从列表中获得文件信息并创建好所有目录然后才运行 Extract
 function ExtractAll ( $zn, $to)
 {
 	  if(substr($to,-1)!="/") $to .= "/";
 	  $files = $this->get_List($zn);
 	  $cn = count($files);
 	  if(is_array($files))
 	  {
		  for($i=0;$i<$cn;$i++)
		  {
		  	if($files[$i]['folder']==1){
		  		@mkdir($to.$files[$i]['filename'],$GLOBALS['cfg_dir_purview']);
		  		@chmod($to.$files[$i]['filename'],$GLOBALS['cfg_dir_purview']);
		  	}
		  }
	  }
 	  $this->Extract ($zn,$to);
 }

 function Extract ( $zn, $to, $index = Array(-1) )
 {
   $ok = 0; $zip = @fopen($zn,'rb');
   if(!$zip) return(-1);
   $cdir = $this->ReadCentralDir($zip,$zn);
   $pos_entry = $cdir['offset'];

   if(!is_array($index)){ $index = array($index);  }
   for($i=0; isset($index[$i]);$i++){
     if(intval($index[$i])!=$index[$i]||$index[$i]>$cdir['entries'])
      return(-1);
   }

   for ($i=0; $i<$cdir['entries']; $i++)
   {
     @fseek($zip, $pos_entry);
     $header = $this->ReadCentralFileHeaders($zip);
     $header['index'] = $i; $pos_entry = ftell($zip);
     @rewind($zip); fseek($zip, $header['offset']);
     if(in_array("-1",$index)||in_array($i,$index))
      $stat[$header['filename']]=$this->ExtractFile($header, $to, $zip);
      
   }
   fclose($zip);
   return $stat;
 }

  function ReadFileHeader($zip)
  {
    $binary_data = fread($zip, 30);
    $data = unpack('vchk/vid/vversion/vflag/vcompression/vmtime/vmdate/Vcrc/Vcompressed_size/Vsize/vfilename_len/vextra_len', $binary_data);

    $header['filename'] = fread($zip, $data['filename_len']);
    if ($data['extra_len'] != 0) {
      $header['extra'] = fread($zip, $data['extra_len']);
    } else { $header['extra'] = ''; }

    $header['compression'] = $data['compression'];$header['size'] = $data['size'];
    $header['compressed_size'] = $data['compressed_size'];
    $header['crc'] = $data['crc']; $header['flag'] = $data['flag'];
    $header['mdate'] = $data['mdate'];$header['mtime'] = $data['mtime'];

    if ($header['mdate'] && $header['mtime']){
     $hour=($header['mtime']&0xF800)>>11;$minute=($header['mtime']&0x07E0)>>5;
     $seconde=($header['mtime']&0x001F)*2;$year=(($header['mdate']&0xFE00)>>9)+1980;
     $month=($header['mdate']&0x01E0)>>5;$day=$header['mdate']&0x001F;
     $header['mtime'] = mktime($hour, $minute, $seconde, $month, $day, $year);
    }else{$header['mtime'] = time();}

    $header['stored_filename'] = $header['filename'];
    $header['status'] = "ok";
    return $header;
  }

 function ReadCentralFileHeaders($zip){
    $binary_data = fread($zip, 46);
    $header = unpack('vchkid/vid/vversion/vversion_extracted/vflag/vcompression/vmtime/vmdate/Vcrc/Vcompressed_size/Vsize/vfilename_len/vextra_len/vcomment_len/vdisk/vinternal/Vexternal/Voffset', $binary_data);

    if ($header['filename_len'] != 0)
      $header['filename'] = fread($zip,$header['filename_len']);
    else $header['filename'] = '';

    if ($header['extra_len'] != 0)
      $header['extra'] = fread($zip, $header['extra_len']);
    else $header['extra'] = '';

    if ($header['comment_len'] != 0)
      $header['comment'] = fread($zip, $header['comment_len']);
    else $header['comment'] = '';

    if ($header['mdate'] && $header['mtime'])
    {
      $hour = ($header['mtime'] & 0xF800) >> 11;
      $minute = ($header['mtime'] & 0x07E0) >> 5;
      $seconde = ($header['mtime'] & 0x001F)*2;
      $year = (($header['mdate'] & 0xFE00) >> 9) + 1980;
      $month = ($header['mdate'] & 0x01E0) >> 5;
      $day = $header['mdate'] & 0x001F;
      $header['mtime'] = mktime($hour, $minute, $seconde, $month, $day, $year);
    } else {
      $header['mtime'] = time();
    }
    $header['stored_filename'] = $header['filename'];
    $header['status'] = 'ok';
    if (substr($header['filename'], -1) == '/')
      $header['external'] = 0x41FF0010;
    return $header;
 }

 function ReadCentralDir($zip,$zip_name)
 {
  $size = filesize($zip_name);
  if ($size < 277) $maximum_size = $size;
  else $maximum_size=277;

  @fseek($zip, $size-$maximum_size);
  $pos = ftell($zip); $bytes = 0x00000000;

  while ($pos < $size)
  {
    $byte = @fread($zip, 1); $bytes=($bytes << 8) | Ord($byte);
    if ($bytes == 0x504b0506){ $pos++; break; } $pos++;
  }

 $data = @unpack('vdisk/vdisk_start/vdisk_entries/ventries/Vsize/Voffset/vcomment_size',fread($zip, 18));

  if ($data['comment_size'] != 0) $centd['comment'] = fread($zip, $data['comment_size']);
  else $centd['comment'] = ''; $centd['entries'] = $data['entries'];
  $centd['disk_entries'] = $data['disk_entries'];
  $centd['offset'] = $data['offset'];$centd['disk_start'] = $data['disk_start'];
  $centd['size'] = $data['size'];  $centd['disk'] = $data['disk'];
  return $centd;
 }

 function ExtractFile($header,$to,$zip)
 {
   $header = $this->readfileheader($zip);
   $header['external'] = (!isset($header['external']) ? 0 : $header['external']);
   if(substr($to,-1)!="/") $to.="/";
   if(!@is_dir($to)) @mkdir($to,$GLOBALS['cfg_dir_purview']);  
  if (!($header['external']==0x41FF0010)&&!($header['external']==16))
  {
   if ($header['compression']==0)
   {
    $fp = @fopen($to.$header['filename'], 'wb');
    
    if(!$fp) return(-1);
    $size = $header['compressed_size'];

    while ($size != 0)
    {
      $read_size = ($size < 2048 ? $size : 2048);
      $buffer = fread($zip, $read_size);
      $binary_data = pack('a'.$read_size, $buffer);
      @fwrite($fp, $binary_data, $read_size);
      $size -= $read_size;
    }
    fclose($fp);
    touch($to.$header['filename'], $header['mtime']);

  }else{
   $fp = @fopen($to.$header['filename'].'.gz','wb');
   if(!$fp) return(-1);
   $binary_data = pack('va1a1Va1a1', 0x8b1f, Chr($header['compression']),
     Chr(0x00), time(), Chr(0x00), Chr(3));

   fwrite($fp, $binary_data, 10);
   $size = $header['compressed_size'];

   while ($size != 0)
   {
     $read_size = ($size < 1024 ? $size : 1024);
     $buffer = fread($zip, $read_size);
     $binary_data = pack('a'.$read_size, $buffer);
     @fwrite($fp, $binary_data, $read_size);
     $size -= $read_size;
   }

   $binary_data = pack('VV', $header['crc'], $header['size']);
   fwrite($fp, $binary_data,8); fclose($fp);

   $gzp = @gzopen($to.$header['filename'].'.gz','rb') or die("Cette archive est compress");
    if(!$gzp) return(-2);
   $fp = @fopen($to.$header['filename'],'wb');
   if(!$fp) return(-1);
   $size = $header['size'];

   while ($size != 0)
   {
     $read_size = ($size < 2048 ? $size : 2048);
     $buffer = gzread($gzp, $read_size);
     $binary_data = pack('a'.$read_size, $buffer);
     @fwrite($fp, $binary_data, $read_size);
     $size -= $read_size;
   }
   fclose($fp); gzclose($gzp);

   touch($to.$header['filename'], $header['mtime']);
   @unlink($to.$header['filename'].'.gz');

  }}
  return true;
 }
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DedeCMS整合安装环境安装——修改DedeCMS密码</title>
<style type="text/css">
<!--
* {
 font-size:12px;
 line-height:160%
}
body {
	background-color: #ACD376;
}
.waitpage {
  top:0;
  left:0;
  filter:Alpha(opacity=70);
  -moz-opacity:0.7;
  position:absolute;
  z-index:10000;
  background:url(loading1.gif) #ababab no-repeat center 200px;
  width:100%;
  height:2500px;
  display:none;
}
-->
</style>
</head>
<body>
<div id='postloader' class='waitpage'></div>
<form id="form1" name="form1" method="post" action="index.php?rand=<?php echo time(); ?>" >
<input type="hidden" name="dopost" value="mdpwd" />
<table width="600" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#666666">
  <tr>
    <td height="32" colspan="2" align="center" bgcolor="#EEFBD2"><strong>你好，欢迎使用DEDECMS整合安装环境</strong></td>
  </tr>
  <tr>
    <td width="173" height="32" align="right" bgcolor="#FFFFFF">DedeAMPZ默认MySQL密码：</td>
    <td width="412" height="28" bgcolor="#FFFFFF">
    	<input type="text" name="oldpwd" id="oldpwd" value="" />
    </td>
  </tr>
  <tr>
    <td height="32" align="right" bgcolor="#FFFFFF">输入新的MySQL密码：</td>
    <td height="28" bgcolor="#FFFFFF">
    	<input type="text" name="dbpwd" id="dbpwd" /> &nbsp; 不修改或你已经修改密码请留空。
    </td>
  </tr>
  <tr>
    <td height="60" colspan="2" align="center" bgcolor="#EEFBD2">
      <input type="submit" name="button" id="button" value="修改密码并下载最新版DedeCMS进行安装" onclick="document.getElementById('postloader').style.display = 'block';" style="height:24px;border:1px solid #6C7447" />
      <br />
      由于需要从远程网址下载最新的DedeCMS，这根据你的网络情况可能需要较长的时间，请耐心等候...
    </td>
  </tr>
</table>
</form>
</body>
</html>