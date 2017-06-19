//团购代码
$(function(){
	updateEndTime();
});
//倒计时函数
function updateEndTime(){
 var date = new Date();
 var time = date.getTime();  //当前时间距1970年1月1日之间的毫
 $(".settime").each(function(i){
  var endDate =this.getAttribute("endTime"); //结束时间字符串
 //转换为时间日期类型
 var endDate1 = eval('new Date(' + endDate.replace(/\d+(?=-[^-]+$)/, function (a){return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
 //结束时间毫秒数
 var endTime = endDate1.getTime(); 
 //当前时间和结束时间之间的秒数
 var lag = (endTime - time) / 1000; 
  if(lag > 0)
  {
   var second = Math.floor(lag % 60);     
   var minite = Math.floor((lag / 60) % 60);
   var hour = Math.floor((lag / 3600) % 24);
   var day = Math.floor((lag / 3600) / 24);
   $(this).html(day+"天"+hour+"小时"+minite+"分"+second+"秒");
  }
  else
   $(this).html("很抱歉！团购活动已经结束啦！");
 });
 setTimeout("updateEndTime()",1000);
}