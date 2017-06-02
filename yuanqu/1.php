<?php
	$conn=mysqli_connect('127.0.0.1','root','','test');
	$sql = "set names utf8";
	mysqli_query($conn,$sql);
	$name=$_REQUEST['name'];
	$phone=$_REQUEST['phone'];
	$id=$_REQUEST['gcuser_id'];
	$order=$_REQUEST['orderTime'];
	$ser=$_REQUEST['serviceIntroduction'];
	$sql="insert into t_order values(null,'$name','$phone','$id','$order','now()','$ser')";
	$result = mysqli_query($conn,$sql);
	if($result){
		echo "提交成功";
	}else{
		echo "提交失败 >";
	}
?>