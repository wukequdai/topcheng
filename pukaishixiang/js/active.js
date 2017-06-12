//active
$(function(){
	var currentId;
	$(".activeImg img:eq(0)").show();
	$(".active li:has('a')").children().addClass("link");
	$(".active li a").mouseover(function(){
		currentId = $(this).parent().index();
		$(".active li a").removeClass("hover");
		$(this).addClass("hover");
		$(".activeImg img").hide();
		$(".activeImg img").eq(currentId).fadeIn(500);
	});	 
});