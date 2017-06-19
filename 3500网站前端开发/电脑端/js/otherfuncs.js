$(function () {
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

    $('.lg_tl a').click(function () {
        var index = $(this).index();
        $(this).addClass('ahover').siblings().removeClass('ahover');
        $(".lg_con").eq(index).addClass('active').siblings().removeClass('active');
    });
    //返回顶部
    $(".topbtn").click(function () {
        $('body,html').animate({ scrollTop: 0 }, 1000);
    })

    //限时切换
    $('.index_qiang_tl a').click(function () {
        var index = $(this).index();
        $(this).addClass('ahover').siblings().removeClass('ahover');
        $(".index_qiang_con").eq(index).addClass('active').siblings().removeClass('active');
    });

    //搜索条件
    $('.search_tiaojian_xuanxiang a').click(function () {
        $('.search_tiaojian_xuanxiang a').removeClass("ahover");
        $(this).addClass('ahover');
    });
    $('.search_tiaojian_rt a').click(function () {
        $('.search_tiaojian_rt a').removeClass("ahover");
        $(this).addClass('ahover');
    });

    //订单切换
    $('.dingdan_qh a').click(function () {
        var index = $(this).index();
        $(this).addClass('ahover').siblings().removeClass('ahover');
        $(".dingdan_qh_con").eq(index).addClass('active').siblings().removeClass('active');
    });

    //产品详情
    $('.pro_con_b_rt_tl a').click(function () {
        var index = $(this).index();
        $(this).addClass('ahover').siblings().removeClass('ahover');
        $(".pro_con_b_rt_con").eq(index).addClass('active').siblings().removeClass('active');
    });

    //收件人管理
    $('.moren input').click(function () {
        $(".morendizhi").removeClass("active");
        $('.moren input').removeAttr("checked");
        $(this).attr("checked", 'true');
        if ($(this).is(':checked')) {

            $(this).parents("tr").find(".morendizhi").addClass("active");
        }
    });

    //结算页面快递选择
    $('.kuaidi_ul a').click(function () {
        $(this).addClass('ahover').siblings().removeClass('ahover');

    });

    //全选
    /*$('.all_check').toggle(function () {  
        $(this).parents().find("input[name='checkname']").attr("checked", 'true');  
    }, function () {  
        $(this).parents().find("input[name='checkname']").removeAttr("checked");  
    });*/
    //确认删除
    //弹窗特效

    $("#outBtn").click(function () {
        $(".alert_bg").show();
        $(".alert").show();
        $("body").css("overflow", "hidden");
    })
    $("#delCancel").click(function () {
        $(".alert_bg").hide();
        $(".alert").hide();
        $("body").css("overflow", "auto");
    })

})






//$("button.add").click(function () {
//    productId = $(this).attr("data-id");
//    textInput = $("input[data-id=" + productId + "]");

//    quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
//    textInput.val(quantity + 1);
//})
//$("button.min").click(function () {
//    productId = $(this).attr("data-id");
//    textInput = $("input[data-id=" + productId + "]");

//    quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
//    textInput.val(quantity - 1);
//    if (parseInt(textInput.val()) < 0) {
//        textInput.val(0);
//    }
//})

//判断微信浏览器
function isWeChatBrowser() { return /micromessenger/i.test(navigator.userAgent); }

//延迟显示图片
!function (a) { a.fn.unveil = function (b, c) { function j() { var b = h.filter(function () { var b = a(this); if (!b.is(":hidden")) { var c = d.scrollTop(), f = c + d.height(), g = b.offset().top, h = g + b.height(); return h >= c - e && g <= f + e } }); i = b.trigger("unveil"), h = h.not(i) } var i, d = a(window), e = b || 0, f = window.devicePixelRatio > 1, g = f ? "data-src-retina" : "data-src", h = this; return this.one("unveil", function () { var a = this.getAttribute(g); a = a || this.getAttribute("data-src"), a && (this.setAttribute("src", a), "function" == typeof c && c.call(this)) }), d.on("scroll.unveil resize.unveil lookup.unveil load.unveil", j), j(), this } }(window.jQuery || window.Zepto);

//PC加入购物车动画
function AddToCartAnimate(img) {
    var cart = $("#youceCartInfo");
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
                'z-index': '10000'
            })
            .appendTo($('body'))
            .animate({
                'top': cart.offset().top + cart.height() / 2,
                'left': cart.offset().left + cart.width() / 2,
                'width': 75,
                'height': 75
            }, 800);

        imgclone.animate({
            'width': 0,
            'height': 0
        }, function () {
            $(this).detach()
        });
    }
}

function RegexNumber(item) {
    if (!item.val().match('^\\d{1,3}$')) {
        item.val('1');
    }
}
//计时器
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
