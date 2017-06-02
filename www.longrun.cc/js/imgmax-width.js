jQuery(function ($) {
	// .imgWrap这个是图片外部容器，使用了本插件后超大的图片宽度将会限制在容器宽度
	// 如果要控制图片与容器的边距，如20像素： $('.imgWrap').imgAutoSize(20);
	$('.wz-body').imgAutoSize(10);
});