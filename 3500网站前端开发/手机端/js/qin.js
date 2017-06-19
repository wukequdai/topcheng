//首页分类左右高度相同样式
window.onload = function () {
    var a = $(".big_fenlei_rt").height();
    var b = $(".big_fenlei_dingwei").height();
    var c = $(".big_fenlei_lf").height();
    if (c < a) {
        $(".big_fenlei_lf .big_fenlei_con").height(a);
    }
    else {
        $(".big_fenlei_rt .big_fenlei_con").height(c / 2);
    }
    $(".big_fenlei_dingwei").css("margin-top", -b / 2);
    var d = $(".tejia_rt").height();
    var e = $(".tejia_lf").height();
    var f = $(".tejia_dingwei").height();
    if (e < d) {
        $(".tejia_lf .tejia_main").height(d);
    }
    else {
        $(".tejia_rt .tejia_main").height(e / 2 - 47);
    }
    $(".tejia_dingwei").css("margin-top", -f / 2);
}
//加减
var productId = 0;
var quantity = 1;// = isNaN(textInput.val()) ? 1 :parseInt(t.val());
var textInput;
    
    
$("button.add").click(function () {
    productId = $(this).attr("data-id");
    textInput = $("input[data-id=" + productId + "]");

    quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
    textInput.val(quantity + 1);
})
$("button.min").click(function () {
    productId = $(this).attr("data-id");
    textInput = $("input[data-id=" + productId + "]");

    quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
    textInput.val(quantity - 1);
    if (parseInt(textInput.val()) < 0) {
        textInput.val(0);
    }
})


//返回顶部
$(".topbtn").click(function () {
    $('body,html').animate({ scrollTop: 0 }, 1000);
})

//导航的显示隐藏
$(".daohang").click(function () {
    $(".daohang_yin").toggle();
})

//弹窗特效
$(".out").click(function () {
    $(".alert_bg").show();
    $(".alert").show();
    $("body").css("overflow", "hidden");
})
$(".alert_btn a").click(function () {
    $(".alert_bg").hide();
    $(".alert").hide();
    $("body").css("overflow", "auto");
})
////购物车加一
//$('.buy').click(function () {
//    $(".gouwuche").append("<span class='tips_box' style=''>+1</span>");
//    var box = $(".gouwuche").find(".tips_box");
//    var self = $(this);
//    //  var top = self.offset().top;
//    //  var left = self.offset().left + self.width() / 2 - box.width() / 2;
//    //   
//    box.css({
//        "position": "absolute",
//        "top": -70,
//        "left": -50,
//        "font-size": '12px', //开始时候的字体大小
//        "font-family": 'Microsoft Yahei',
//        "color": 'red',
//    });

//    box.animate({
//        "top": -20,
//        "left": 0,
//        "opacity": 0.8, //透明度
//        "font-size": '18px' //动画结束时候的效果
//    }, 800, function () {
//        box.remove();
//    });

//});
//支付方式切换
$('.payment').click(function () {
    var data_id = $(this).attr("data-id");
    $("a").each(function () {
        $(this).removeClass("active");
    });
    $(".zhifu_qiehuan_con").each(function () {
        $(this).removeClass("active");
    });

    $("a[data-id=" + data_id + "]").addClass('active');
    $(".zhifu_qiehuan_con[data-id=" + data_id + "]").addClass('active');
});
/*$('.zhifu_qiehuan_tl li').click(function () {
    $('a').each(function () {
        $(this).removeClass("ahover");
    });
    var index = $(this).index();
    $(this).addClass('ahover').siblings().removeClass('ahover');
    $(".zhifu_qiehuan_con").eq(index).addClass('active').siblings().removeClass('active');
});*/

//滚动到最低端
$(".pro_weibu").click(function () {
    $('body,html').animate({ scrollTop: 40000 }, 1000);
})
//全选
/*$('.all_check').toggle(function () {
    $(this).parents().find("input[name='checkname']").attr("checked", 'true');
}, function () {
    $(this).parents().find("input[name='checkname']").removeAttr("checked");
});*/
//商品详情切换
$('.pro_menu_main a').click(function () {
    var index = $(this).index();
    $(this).addClass('ahover').siblings().removeClass('ahover');
    $(".pro_qiehuan").eq(index).addClass('active').siblings().removeClass('active');
    $('#home_slider').flexslider({
        animation: 'slide',
        slideshow: false,
        controlNav: false,
        directionNav: true,
        animationLoop: true,
        useCSS: false
    });
});
//限时特卖切换
$('.temai_tl a').click(function () {
    var index = $(this).index();
    $(this).addClass('ahover').siblings().removeClass('ahover');
    $(".temai_con").eq(index).addClass('active').siblings().removeClass('active');
});
//订单列表切换
$('.zhuangtai_tl a').click(function () {
    var index = $(this).index();
    $(this).addClass('ahover').siblings().removeClass('ahover');
    $(".dingdan_con").eq(index).addClass('active').siblings().removeClass('active');
});
//滚动到最低端
$(".pro_weibu").click(function () {
    $('body,html').animate({ scrollTop: 40000 }, 1000);
})
//全选
$('.all_check').toggle(function () {
    $(this).parents().find("input[name='checkname']").attr("checked", 'true');
}, function () {
    $(this).parents().find("input[name='checkname']").removeAttr("checked");
});
//搜索页面特效
$(".tiaojian_lf a").click(function () {
    $(this).addClass('ahover').siblings().removeClass('ahover');
});
$(".jiage").click(function () {
    $(this).find("em").toggleClass('jiage_tubiao_xia');
});
$(".sousuoqian").click(function () {
    $(this).toggleClass("sousuohou");
    $(".search_main_ul").toggleClass("search_main_ul_hou");
});
$(".kuaidi_ul li").click(function () {
    $(this).addClass('ahover').siblings().removeClass('ahover');
});
/*
// 关键词
$('.head_search_main').click(function () {
    $(".guanjianci").show();
    $(".search_top_main_lf").focus();
    $("body").css("overflow", "hidden");
});
$('.cha').click(function () {
    $(".guanjianci").hide();
    $("body").css("overflow", "auto");
});
$('.search_top_main_btn').click(function () {
    $(this).select();
});
$('.search_top_main_lf').click(function () {
    $(this).select();
});
//关键词切换
$('.guanjianci_tl a').click(function(){
	var index = $(this).index();
	$(this).addClass('ahover').siblings().removeClass('ahover');
	$(".guanjianci_input_con").eq(index).addClass('active').siblings().removeClass('active');
	$(".search_top_main_lf").each(function () {
	    $(this).val("");
	});
});
*/
//购物车加一
//$('.buy').click(function () {

//    $(".gouwuche").append("<span class='tips_box' style=''>+1</span>");
//    var box = $(".gouwuche").find(".tips_box");
//    var self = $(this);
//    //  var top = self.offset().top;
//    //  var left = self.offset().left + self.width() / 2 - box.width() / 2;
//    //   
//    box.css({
//        "position": "absolute",
//        "top": -70,
//        "left": -50,
//        "font-size": '12px', //开始时候的字体大小
//        "font-family": 'Microsoft Yahei',
//        "color": 'red',
//    });

//    box.animate({
//        "top": -20,
//        "left": 0,
//        "opacity": 0.8, //透明度
//        "font-size": '18px' //动画结束时候的效果
//    }, 800, function () {
//        box.remove();
//    });

//});

$(".search_top_main_btn").keyup(function () {
    $("#keyword").val($(this).val());
})

$(".search_top_main_lf").keyup(function () {
    $("#keyword").val($(this).val());
})

//判断微信浏览器
function isWeChatBrowser() { return /micromessenger/i.test(navigator.userAgent); }

//延迟显示图片
!function (a) { a.fn.unveil = function (b, c) { function j() { var b = h.filter(function () { var b = a(this); if (!b.is(":hidden")) { var c = d.scrollTop(), f = c + d.height(), g = b.offset().top, h = g + b.height(); return h >= c - e && g <= f + e } }); i = b.trigger("unveil"), h = h.not(i) } var i, d = a(window), e = b || 0, f = window.devicePixelRatio > 1, g = f ? "data-src-retina" : "data-src", h = this; return this.one("unveil", function () { var a = this.getAttribute(g); a = a || this.getAttribute("data-src"), a && (this.setAttribute("src", a), "function" == typeof c && c.call(this)) }), d.on("scroll.unveil resize.unveil lookup.unveil load.unveil", j), j(), this } }(window.jQuery || window.Zepto);

function AddToCartAnimate(img,cartBotm) {
    var cart = cartBotm;
    var imgtodrag = img;
    if (imgtodrag) {
        var imgclone = imgtodrag.clone()
            .offset({
                top: imgtodrag.offset().top,
                left: imgtodrag.offset().left
            })
            .css({
                'opacity': '0.9',
                'position': 'absolute',
                'width': '80%',
                'z-index': '10000'
            })
            .appendTo($('body'))
            .animate({
                'top': cart.offset().top + cart.height() / 2,
                'left': cart.offset().left + cart.width() / 2,
                'width': 50,
                'height': 50
            }, 500);

        imgclone.animate({
            'width': 0,
            'height': 0
        }, function () {
            $(this).detach()
        });
    }
}