<?php
	$conn=mysqli_connect('127.0.0.1','root','','test');
	$sql = "set names utf8";
	mysqli_query($conn,$sql);
	//$uname=$_REQUEST['uname'];
	$sql="select gcuser_id from t_gcuser";
	$result = mysqli_query($conn,$sql);
	$rows=mysqli_fetch_all($result,MYSQLI_ASSOC);
	if($rows!==null){
		echo json_encode($rows);
	}else{
		echo "";
	}
?>