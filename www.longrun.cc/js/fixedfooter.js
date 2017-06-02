//固定Footer在页面底部
$(function(){
	
	lrFixFooter("#footer");	//调用方法：lrFixFooter("div.footerwarp"); 传入底部的类名或者ID名
	
	function lrFixFooter(obj){
		var footer = $(obj),doc = $(document);
		function fixFooter(){
			if(doc.height()-4 <= $(window).height()){
				footer.css({
					width:"100%",
					position:"absolute",
					left:0,
					bottom:0	
				});
			}else{
				footer.css({
					position:"static"
				});
			}
		}
		fixFooter();
		$(window).on('resize.footer', function(){
			fixFooter();
		});
		$(window).on('scroll.footer',function(){
			fixFooter();
		});	
			
	}
	
})
