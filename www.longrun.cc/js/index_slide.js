$(".i-banner").slide({titCell:".bndot ul", mainCell:".picshow ul",effect:"fade",vis:1,autoPlay:true,autoPage:true,interTime:7000,prevCell:".bn_pre",nextCell:".bn_next" });

$(".banner").hover(function(){
	$(this).find(".bn_pre,.bn_next").fadeTo("show",1.0);
},function(){
	$(this).find(".bn_pre,.bn_next").hide();
})

$(".bn_pre,.bn_next").hover(function(){
	$(this).fadeTo("show",1.0);
}

)
/*焦点图*/

$(".news-slider").slide({ titCell:".newspage ul",mainCell:".news-mc",effect:"leftLoop",autoPlay:false,autoPage:true,vis:4,prevCell:"#news-btn-l",nextCell:"#news-btn-r"});

$(".news-slider").hover(function(){
	$(this).find("#news-btn-l,#news-btn-r").fadeTo("show",1.0);
    },function(){
	$(this).find("#news-btn-l,#news-btn-r").hide();
})
$("#news-btn-l,#news-btn-r").hover(function(){
	$(this).fadeTo("show",1.0);
});


/*新闻焦点图*/

$(".brandwrap .brandList li").each(function(i){
	 $(".brandwrap .brandList li").slice(i*6,i*6+6).wrapAll("<ul></ul>");
	 })
/*6个为一组*/

$(".bd-in").slide({titCell:".bdpage ul",mainCell:".brandwrap .brandList",effect:"leftLoop",autoPlay:false,autoPage:true,prevCell:".bd-btn-left",nextCell:".bd-btn-right"});
/*旗下品牌*/

$(".hn-ibox").slide({mainCell:".hnslide ul",effect:"leftLoop",autoPlay:true,autoPage:true,interTime:4000,vis:3,scroll:3});
/*企业荣誉*/

$(".mem-ibox").slide({ titCell:".mem-page ul",trigger:"click",mainCell:".mem-slide ul",effect:"topLoop",autoPlay:true,autoPage:true,vis:2,interTime:7000,prevCell:".mem-btn-upward",nextCell:".mem-btn-down" });
/*大事记*/



