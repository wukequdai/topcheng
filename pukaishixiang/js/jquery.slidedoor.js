;(function($){
jQuery.jquerySlideDoor = function(id) {


	var imgSrcArr = [];
	var $img = $(id+" .doorList .item img");
	var $item = $(id+" .doorList .item");
	var $inner = $(id+" .doorList .inner");
	var $itemWidth = $(id+" .doorList .item").width();
	var $itemNumber = $(id+" .doorList .item").length;
	var currentId = 0;
	var playTime = 50000;
	//ready
	$img.each(function(){
		imgSrcArr.push($(this).attr("src"));
		$(this).attr({src:'images/loading.gif'});
	});
	
	var dotHtml = "<div class='control dotList'><ul>";
	for (var i=1;i<$itemNumber+1;i++){
		dotHtml += "<li><a href='javascript://'>"+i+"</a></li>";
	}
	dotHtml += "</ul></div>";
	$(".subnav03 a.a1").after(dotHtml);
	var $controlBar = $(id+" .control");
	var $controlItem = $(id+" .control li");
	fnShowImg(0);
	function fnShowImg(id){
		$img.eq(id).attr({src:imgSrcArr[id]});
		$controlItem.removeClass("current");
		$($controlItem).eq(id).addClass("current");
	}
	$controlItem.bind("click",function(){
		if($(this).index() != currentId){
			fadeImg($(this).index());
//			clearInterval(t);
//			t = setInterval(changeImg,playTime);
		};
	});
	function fadeImg(id){
		currentId = id;
		fnShowImg(currentId);
		$img.hide();
		$img.eq(currentId).fadeIn(500);
	}
	var t = setInterval(changeImg,playTime);
	function changeImg(){
		if(currentId < $itemNumber - 1){
			currentId++;
			
		}else{
			currentId = 0;
		}
		fadeImg(currentId);
	}
};

})(jQuery);
