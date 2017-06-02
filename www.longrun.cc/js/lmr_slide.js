$(".lmsidecon").slide({mainCell:".lmBdList",effect:"topLoop",autoPlay:true,autoPage:true,vis:2,scroll:2,interTime:5000});
/*栏目右侧品牌*/

$(".lmsidecon").slide({mainCell:".hnslide2 ul",effect:"topLoop",autoPlay:true,autoPage:true,vis:2,scroll:2,interTime:5000});
/*栏目右侧荣誉*/

$(document).ready(function(){
	$(".lmBdList li").hover(function(){
			
			$(this).children("h3").css("display","block");
		},function(){
			
			$(this).children("h3").css("display","none");
		}
	); 
	
})


