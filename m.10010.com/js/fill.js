webpackJsonp([55],{0:function(e,t,r){(function(e){"use strict";function t(e){if(e&&e.__esModule)return e;var t={};if(null!=e)for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t.default=e,t}function o(e){return e&&e.__esModule?e:{default:e}}var s=r(2),n=o(s),a=r(74),c=o(a);r(137);var i=r(82),l=o(i),d=r(83),u=r(76),m=r(84),p=t(m),h="",v=!0,f=!0,C="",y="",b="",g=!1,k="",I=!1;e(function(){function t(t){e("#certName").val(t.certName),e("#certNo").val(t.certNo),e("#mobilePhone").val(t.mobilePhone),p.checkMobiles(i.mobile)&&void 0===t.mobilePhone&&e("#mobilePhone").val(i.mobile)}function r(t,r){e("#province li, #city li").removeClass("selected"),e("#province").find("li[data-code="+t+"]").addClass("selected");var o=[];x[t].forEach(function(e){o.push("<li data-code="+e.CITY_CODE+">"+e.CITY_NAME+"</li>")}),e("#city").html(o),p.isEmpty(r)||e("#city").find("li[data-code="+r+"]").addClass("selected")}function o(t){x=t.cityData;var o=[];t.provinceData.forEach(function(e){o.push("<li data-code="+e.PROVINCE_CODE+">"+e.PROVINCE_NAME+"</li>")}),e("#province").html(o).find("li[data-code="+m.numRes.essProvince+"]").addClass("selected"),r(m.numRes.essProvince,m.numRes.essCity),C=e("#province li.selected").text()}function s(t){e(".number-loading").hide();var r=e("#search").data("val");if(0===t.numArray.length)return void(p.isEmpty(r)?(e(".no-number").text("当前选号人数过多，请稍后再试").show(),e("#refresh").text("再试一次")):(e(".no-number").text("抱歉没有匹配的号码").show(),e("#refresh").text("换一批")));e(".number-list").show(),P.list=[],P.current=1;for(var o=t.numArray,s=0;s<o.length;s+=12){var n={};p.isEmpty(r)?n.number=o[s]:n.number=o[s].toString().replace(new RegExp(r+"$"),"<span>"+r+"</span>"),n.niceRule=o[s+5],n.monthLimit=o[s+6],P.list.push(n)}P.max=Math.ceil(P.list.length/P.size),(0,d.shuffle)(P.list),A()}function a(e){R(e),D(),t(e),o(e),S(),z(e),K()}c.default.attach(document.body),e(".privacy").css("width",e(window).width()/.75+"px"),(0,u.resize)();var i=(0,u.getUrlParam)();"undefined"!==i.channel&&""!==i.channel||(i.channel="9999");var m={},x=[],P={},E=!1,w=function(){e("html, body").addClass("no-scroll")},T=function(){e("html, body").removeClass("no-scroll")},R=function(t){var r=e.cookie("mallcity")||"11|110",o=r.split("|")[0],s=r.split("|")[1],n=t.provinceData.filter(function(e){return e.PROVINCE_CODE===o});0===n.length&&(o=t.provinceData[0].PROVINCE_CODE,s=t.cityData[o][0].CITY_CODE,e.cookie("mallcity",o+"|"+s,{expires:7,path:"/",domain:".10010.com"})),e("#delivery-desc").show(),m.numRes={},m.numRes.essProvince=o,m.numRes.essCity=s,m.goodsId=""+o+t.goodsId,m.product=i.product,m.channel=i.channel},N="根据国家实名制要求, 请准确提供身份证信息",_=void 0;"0"===i.product?_="“大王卡”":"1"===i.product?_="“音乐小王卡”":"2"===i.product?_="“视频小王卡”":"3"===i.product&&(_="“天王卡”"),e("#fill-desc").find("span").text(_);var D=function(){e("#top-desc").show().text(N)},O=function(t,r){e("#post-city li, #post-district li").removeClass("selected"),e("#post-city").find("li[data-code="+t+"]").addClass("selected");var o=[];l.default.CITY_MAP[t].forEach(function(e){o.push("<li data-code="+e.DISTRICT_CODE+">"+e.DISTRICT_NAME+"</li>")}),e("#post-district").html(o),p.isEmpty(r)||e("#post-district").find("li[data-code="+r+"]").addClass("selected")},S=function(){var t=l.default.PROVINCE_LIST.filter(function(e){return e.ESS_PROVINCE_CODE===m.numRes.essProvince})[0],r=[];l.default.PROVINCE_MAP[t.PROVINCE_CODE].forEach(function(e){r.push("<li data-province-name="+t.PROVINCE_NAME+" data-code="+e.CITY_CODE+" data-ess-code="+e.ESS_CITY_CODE+">"+e.CITY_NAME+"</li>")}),e("#post-city").html(r),e("#post-city li[data-ess-code="+m.numRes.essCity+"]").addClass("selected");var o=l.default.PROVINCE_MAP[t.PROVINCE_CODE].filter(function(e){return e.ESS_CITY_CODE===m.numRes.essCity})[0];void 0===o&&(o=l.default.PROVINCE_MAP[t.PROVINCE_CODE][0]);var s=[];l.default.CITY_MAP[o.CITY_CODE].forEach(function(e){s.push("<li data-code="+e.DISTRICT_CODE+">"+e.DISTRICT_NAME+"</li>")}),e("#post-district").html(s);var n=e("#post-district li:first");n.addClass("selected"),m.post={},m.post.webProvince=t.PROVINCE_CODE,m.post.webCity=o.CITY_CODE,m.post.webCounty=n.data("code")+""},A=function(){if(0===P.list.length)return void e(".number-list").html("无号码");var t=(P.current-1)*P.size,r=t+P.size;P.current===P.max&&(r=P.list.length);for(var o=[],s=t;s<r;s+=1){var n=P.list[s];0===n.niceRule?o.push("<li><a data-niceRule='"+n.niceRule+"'\n      data-monthLimit='"+n.monthLimit+"' >"+n.number+"</a></li>"):o.push("<li><a data-niceRule='"+n.niceRule+"'\n      data-monthLimit='"+n.monthLimit+"' >"+n.number+"<i>靓</i></a></li>")}P.current+=1,e(".number-list").html(o)},z=function(e){P.list=[],P.current=1,P.size=10,P.max=1,P.proGroupNum=e.proGroupNum},M=function(){e(".number-list, .no-number").hide(),e(".number-loading").show();var t={provinceCode:m.numRes.essProvince,cityCode:m.numRes.essCity,monthFeeLimit:0,groupKey:P.proGroupNum[m.numRes.essProvince],searchCategory:3,net:"01",amounts:200,codeTypeCode:"",searchValue:e("#search").data("val"),qryType:"02",goodsNet:4};p.isEmpty(t.groupKey)?(e(".no-number").text("抱歉没有匹配的号码").show(),e("#refresh").text("换一批"),e(".number-list, .number-loading").hide()):e.ajax({type:"get",url:"/NumApp/NumberCenter/qryNum",data:t,dataType:"jsonp",jsonp:"callback",jsonpCallback:"jsonp_queryMoreNums",success:function(e){s(e)}})},F=function(t,r,o){var s={provinceCode:m.numRes.essProvince,cityCode:m.numRes.essCity,numID:t,goodsId:m.goodsId};E=!0,e(".occupyTips").show(),e.ajax({type:"POST",url:"/king/kingNumBuy/buy",timeout:6e3,data:s,success:function(s){"SUCCESS"===s?(e(".mask, #number-popup, .occupyTips").hide(),T(),e("#number .p-content").text(t),m.numRes.number=t,"1"===r&&"0"!==o?e(".numberTips").show().find("i").text(o):e(".numberTips").hide(),"请选择号码"===e("#top-desc").text()&&e("#top-desc").removeClass("error").text(N)):(e(".occupyTips").hide(),e("#error").show(),e("#reserved-number").find("span").text(t),e("#number-popup").hide()),e("#number").removeClass("error"),E=!1},error:function(){e(".occupyTips").hide(),e("#error").show(),e("#reserved-number").find("span").text(t),e("#number-popup").hide(),E=!1}})};e(".p-content").find("input").click(function(t){var r=e(t.currentTarget),o=r.parents("li"),s=o.hasClass("error");s&&(o.removeClass("error"),e("#top-desc").removeClass("error").text(N))}),e(".p-text-area").click(function(){e("#delivery-desc").hasClass("error")&&(e("#delivery-desc").removeClass("error"),e("#top-desc").removeClass("error").text(N))}),e("#delivery").click(function(t){e(t.currentTarget).hasClass("error")&&(e("#delivery").removeClass("error"),e("#top-desc").removeClass("error").text(N))});var V=function(){return e("li.error").removeClass("error"),!!p.CustCheck.checkReceiverName(e("#certName").val())&&(!!p.CustCheck.checkIdCard(e("#certNo").val())&&(!!p.CustCheck.checkPhone(e("#mobilePhone").val())&&(!(I&&!p.CustCheck.checkYzm(e(".yzmInput").val()))&&(!(I&&!p.CustCheck.checkYzmPhone(h))&&(!!p.CustCheck.checkNumAddress(e("#location .p-content").text())&&(!!p.CustCheck.checkNumber(e("#number .p-content").text())&&(!!p.CustCheck.checkAddress(e("#delivery .p-content").text())&&(!!p.CustCheck.checkAddressInfo(e("#address").val())&&(!!g||(e("#top-desc").addClass("error").text(k),e(window).scrollTop(0),!1))))))))))},j=function(t){t&&(m.delivery={},m.delivery.selfFetchCode=e(".since-content").find("input:checked").val()),m.certInfo={},m.certInfo.certName=e("#certName").val().trim(),m.certInfo.certId=e("#certNo").val().trim(),m.certInfo.contractPhone=e("#mobilePhone").val().trim(),m.post.address=e("#address").val().trim(),m.goodsId=""+m.numRes.essProvince+m.goodsId.substring(2),m.product=i.product,m.channel=i.channel,m.innerFlag=i.innerFlag||"",m.captcha=e(".yzmInput").val().trim();var r={};r.certInfo=m.certInfo,r.post=m.post,sessionStorage.setItem("ANT_CARD",(0,n.default)(r))},Y=function(t){f=!1;var r={},o=void 0;r.tencentData=(0,n.default)(m),e.ajax({type:"post",url:"/king/kingBuy/tencent",data:r,success:function(r){"0000"===r.code?(e("#success, .mask").show(),b=r.tendencyId,w(),t?(o='<p class="point">我们将尽快为您配送，请在收到卡后的10天内激活使用，过期将被回收哦！',e("#success .point-list").empty().append(o)):(o='<p class="point">您的卡已在营业厅等待领取，营业员将会与您电话联系，请保持手机畅通！',e("#success .point-list").empty().append(o))):"0005"===r.code?(e("#error, .mask").show(),w(),e("#reserved-number").find("span").text(e("#number .p-content").text())):(e("#errorAll, .mask").show(),w(),e("#errorAll .popup-desc").text(r.msg)),e("#since").hide(),f=!0,E=!1},error:function(){e("#overtime, .mask").show(),w(),e("#since").hide(),f=!0,E=!1}})},L=function(t){p.checkMobiles(t)?e(".yzm").removeClass("grey"):e(".yzm").addClass("grey")},G=function(){I=!1,I?(e("#captcha, #apply-yzm").show(),L(e("#mobilePhone").val())):e("#captcha, #apply-yzm").hide()},q="",B="",J=function(){var t=e("#certNo").val(),r=e("#mobilePhone").val(),o={};o.contractPhone=r,o.certId=t,o.product=i.product,o.sourceFlag="2";var s={};s.contractPhoneCheck=(0,n.default)(o),""!==t&&""!==r&&(q!==t||B!==r)&&p.CustCheck.checkIdCard(t)&&p.CustCheck.checkPhone(r)&&e.ajax({url:"/king/kingNumCard/contractPhoneCheck",type:"POST",data:s,success:function(o){if("0000"===o.code){g=!0;var s=e(".fill-list").find("li.error").length;0===s&&e("#top-desc").text(N).removeClass("error"),k=N,G(o)}else e("#errorAll, .mask").show(),w(),e("#errorAll .popup-desc").text(o.msg),g=!1,k=o.msg;q=t,B=r}})},K=function(){var t=sessionStorage.getItem("ANT_CARD");if(!p.isEmpty(t)){var r=JSON.parse(t);if(p.isEmpty(e("#certName").val())){var o=r.certInfo;e("#certName").val(o.certName),e("#certNo").val(o.certId),e("#mobilePhone").val(o.contractPhone)}var s=r.post,n=e("#post-city li[data-code="+s.webCity+"]");1===n.length&&(O(s.webCity,s.webCounty),e("#delivery .p-content").text("请选择区/县").addClass("grey"),e("#address").val(s.address),m.post=s)}};e("#location").on("click",function(t){e(t.currentTarget).hasClass("error")&&(e("#location").removeClass("error"),e("#top-desc").removeClass("error").text(N)),r(m.numRes.essProvince,m.numRes.essCity);var o=e(".mask");o.show(),w(),e("#area").addClass("slip"),o.one("click",function(){e("#area").removeClass("slip"),setTimeout(function(){o.hide(),T()},300)})}),e("#province").on("click","li",function(t){var o=e(t.currentTarget),s=o.data("code");o.addClass("selected").siblings("li").removeClass("selected"),r(s)}),e("#city").on("click","li",function(t){var r=e("#province li.selected"),o=e(t.currentTarget);o.addClass("selected").siblings("li").removeClass("selected"),e("#location .p-content").text(r.text()+" "+o.text()).removeClass("grey"),e.cookie("mallcity",r.data("code")+"|"+o.data("code"),{expires:7,path:"/",domain:".10010.com"}),m.numRes.essProvince=r.data("code")+"",m.numRes.essCity=o.data("code")+"",m.goodsId=""+m.numRes.essProvince+m.goodsId.substring(2),e("#area").removeClass("slip"),e("#number .p-content").text(""),C=r.text(),e("#delivery-desc").show(),y!==o.text()&&(e("#delivery .p-content").text("请选择区/县").addClass("grey"),y=o.text()),S(),setTimeout(function(){e(".mask").unbind("click").hide(),T()},300),e(".numberTips").hide(),e(t.currentTarget).hasClass("error")&&(e("#location").removeClass("error"),e("#top-desc").removeClass("error").text(N))}),e("#go-protocol").on("click",function(){var t={city:m.numRes.essCity,province:m.numRes.essProvince,custName:e("#certName").val().trim(),goodsId:m.goodsId,number:m.numRes.number,psptType:"02",psptTypeCode:e("#certNo").val().trim(),activityType:"11"};(0,u.showProtocal)(t,"/mall-mobile/OrderInputAjax/kingProtocol",V)}),e(".popup-close").on("click",function(t){var r=e(t.currentTarget),o=r.attr("data-type");e(".popup, .mask").hide(),e("#refresh").text("换一批"),T(),"3"===o&&window.history.back(-1)}),e("#number").on("click",function(){p.CustCheck.checkNumAddress(e("#location .p-content").text())&&(e("#search").data("val","").val(""),e("#search-btn").show(),e("#search-close-btn").hide(),M(),e("#number-popup, .mask").show(),w())}),e("#refresh").on("click",function(){return P.current>P.max?void M():void A()}),e("#search-btn").on("click",function(){var t=e("#search").val().trim();p.isEmpty(t)||(e("#search").data("val",t),e("#search-btn").hide(),e("#search-close-btn").show(),M())}),e("#search-close-btn").on("click",function(){e("#search").data("val","").val(""),e("#search-btn").show(),e("#search-close-btn").hide(),M()}),e("#search").on("keyup",function(t){var r=e(t.currentTarget),o=r.data("val");""+o!==r.val().trim()&&(e("#search-btn").show(),e("#search-close-btn").hide()),""===r.val().trim()&&(r.data("val",""),M())}),e(".number-list").on("click","a",function(t){var r=e(t.currentTarget).text().replace("靓",""),o=e(t.currentTarget).attr("data-niceRule"),s=e(t.currentTarget).attr("data-monthLimit");E||F(r,o,s)}),e("#reselect-number").on("click",function(){e("#search-btn").show(),e("#search-close-btn").hide(),M(),e("#error").hide(),e("#number-popup").show()}),e("#delivery").on("click",function(){p.CustCheck.checkNumAddress(e("#location .p-content").text())&&!function(){O(m.post.webCity,m.post.webCounty);var t=e(".mask");t.show(),w(),e("#post").addClass("slip"),t.one("click",function(){e("#post").removeClass("slip"),setTimeout(function(){t.hide(),T()},300)})}()}),e("#post-city").on("click","li",function(t){var r=e(t.currentTarget),o=r.data("code");r.addClass("selected").siblings("li").removeClass("selected"),O(o)}),e("#post-district").on("click","li",function(t){var r=e("#post-city li.selected"),o=e(t.currentTarget);o.addClass("selected").siblings("li").removeClass("selected"),e("#delivery .p-content").text(r.data("province-name")+" "+r.text()+" "+o.text()).removeClass("grey"),m.post.webCity=r.data("code")+"",m.post.webCounty=o.data("code")+"",e("#post").removeClass("slip"),setTimeout(function(){e(".mask").unbind("click").hide(),T()},300)}),e("#protocol").on("click",function(t){var r=e(t.currentTarget);r.hasClass("agree")?(e("#submit").addClass("disable"),r.removeClass("agree")):(e("#submit").removeClass("disable"),r.addClass("agree"))});var U={},$=function(){U.webProvince=m.post.webProvince,U.webCity=m.post.webCity,U.webCounty=m.post.webCounty,U.goodsId=m.goodsId,U.essProvince=m.numRes.essProvince};e("#submit").on("click",function(){E||e("#protocol").hasClass("agree")&&V()&&($(),E=!0,e("#top-desc").text(N).removeClass("error"),e("#city li.selected").data("code")!==e("#post-city li.selected").data("ess-code")?(j(!1),Y(!0)):e.ajax({type:"post",url:"/king/kingNumCard/selfFetch",data:U,success:function(t){if("1"===t.selfFetchFlag){e("#since").show(),"安徽"===C?(e(".since-content").find(".title").remove(),e(".since-content").prepend('<h3 class="title">您填写的配送区域可到现场办理，<i>现场充值还有礼品赠送</i></h3>')):"陕西"===C?(e(".since-content").find(".title").remove(),e(".since-content").prepend('<h3 class="title">您填写的配送区域可到现场办理，<i>现场激活可免费获得价值1200元购物优惠券</i></h3>')):(e(".since-content").find(".title").remove(),e(".since-content").prepend('<h3 class="title">您填写的配送区域可到现场办理：</h3>')),e(".mask").show(),w();var r=e(".since-content").find("ul");r.find("li").remove();for(var o="",s=0;s<t.selfFetchInfo.length;s+=1)o=0===s?"<li><input type='radio' name='mall' id='radio"+s+"'  checked='checked'\n                value='"+t.selfFetchInfo[s].ADDRESS_ID+"' ><label for='radio"+s+"'\n                class='em'>"+t.selfFetchInfo[s].SELFGET_NAME+"：</label>\n                <label for='radio"+s+"' class='margin'>"+t.selfFetchInfo[s].SELFGET_ADDRESS+"</label></li>":"<li><input type='radio' name='mall' id='radio"+s+"'\n                value='"+t.selfFetchInfo[s].ADDRESS_ID+"' ><label for='radio"+s+"'\n                class='em'>"+t.selfFetchInfo[s].SELFGET_NAME+"：</label>\n                <label for='radio"+s+"' class='margin'>"+t.selfFetchInfo[s].SELFGET_ADDRESS+"</label></li>",r.append(o)}"0"===t.selfFetchFlag&&(j(!1),Y(!0))},error:function(){j(!1),Y(!0)}}))}),e(".sinceBtn").on("click",function(){f&&(j(!0),Y(!1))}),e(".noSince").on("click",function(){f&&(j(!1),Y(!0))}),e(window).resize(function(){(0,u.resize)()}),e("#address").on({keydown:function(e){13===e.keyCode&&e.preventDefault()},input:function(t){var r=e(t.currentTarget),o=r.val(),s=e("#address-temp").text(o).height();r.css("height",s)}}),e.ajax({type:"get",url:"/king/kingNumCard/init",data:i,success:function(t){"0000"===t.resultCode?a(t):(e("#fail, .mask").show(),w())},error:function(){e("#overtime, .mask").show(),w()}}),e("#mobilePhone").on("keyup",function(){var t=e("#mobilePhone").val();11===t.length?(e(".yzm").removeClass("grey"),e("#apply-phone").removeClass("error")):e(".yzm").addClass("grey")});var H=60,Q=void 0;e(".yzm").on("click",function(){var t=e("#mobilePhone").val(),r=e(".yzm");p.CustCheck.checkPhone(e("#mobilePhone").val())&&v&&(v=!1,t!==h?e(".rightI").hide():e(".rightI").show(),e("#apply-phone").removeClass("error"),e("#top-desc").text(N).removeClass("error"),e.ajax({type:"get",url:"/mall-mobile/CheckMessage/captcha",data:{phoneVal:t,type:"8"}}),Q=setInterval(function(){r.addClass("grey"),0===H?(clearInterval(Q),r.text("重新获取").removeClass("grey"),H=60,v=!0):(r.text(H+"s"),H-=1,v=!1)},1e3))});var W="",X=!0;e("#captchaText").on("keyup",function(){if(4===e("#captchaText").val().trim().length&&e("#captchaText").val().trim()!==W){var t=e("#mobilePhone").val().trim();if(p.isEmpty(t))return void p.error("mobilePhone","请输入联系电话");if(!p.checkMobiles(t))return void p.error("mobilePhone","您的手机号码格式有误，请重新输入");e(".rightI").hide(),X&&(X=!1,e.ajax({url:"/king/kingNumCard/captchaCheck",type:"POST",data:{phoneVal:e("#mobilePhone").val().trim(),captcha:e("#captchaText").val().trim(),type:8},success:function(t){W=e("#captchaText").val().trim(),"0000"===t.RespCode?(h=e("#mobilePhone").val().trim(),e(".rightI").show(),e("#apply-yzm").removeClass("error"),e("#top-desc").removeClass("error"),D()):"10001"===t.RespCode||"10002"===t.RespCode?(h="",p.error("apply-yzm",t.RespMsg)):"10003"===t.RespCode&&(h="",""===W?p.error("apply-yzm","请输入验证码！"):p.error("apply-yzm",t.RespMsg)),X=!0},error:function(){h="",p.error("apply-yzm","验证码错误"),X=!0}}))}else 4!==e("#captchaText").val().trim().length&&(W="",e(".rightI").hide())});var Z=!0;e(".to-referee").click(function(){e(".to-referee").hide(),e(".referee-message").show(),e(".submit-referee").show()});var ee=function(e){return!(e.length>25)&&0!==e.length};e(".referee-message").keyup(function(){""===e(".referee-message").val().trim()?e(".submit-referee").addClass("grey"):e(".submit-referee").removeClass("grey")}),e(".submit-referee").click(function(){var t=e(".referee-message").val().trim();ee(t)&&Z&&(Z=!1,e.ajax({url:"/king/kingCard/referrerInfo",type:"POST",data:{kingOrderId:b,referrerInfo:t,type:"1"},success:function(t){"0000"===t.resultCode?(e(".referee-message").hide(),e(".submit-referee").hide(),e(".referee-error").hide(),e(".referee-success").show(),Z=!0):(e(".referee-error").show(),Z=!0)},error:function(){e(".referee-error").show(),Z=!0}}))}),e("#certNo").blur(function(){J()}),e("#mobilePhone").blur(function(){J()})})}).call(t,r(1))},137:function(e,t){}});
//# sourceMappingURL=fill.js.map