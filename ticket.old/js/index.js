/*抢票页面js*/

//获取smarty传来的变量
var result =  $("#result").text();
var openid = $("#openid").text();
var actID = $("#actID").text();
var actName = $("#actName").text();
var leftT = $("#leftT").text();
var leftChance = $("#leftChance").text();
var startTime = $("#startTime").text();
var endTime = $("#endTime").text();
var demand = $("#demand").text();
var actContent = $("#actContent").html();
var token = $("#token").text();
var indexPicUrl = $("#indexPic").text();
var base = $("#base").text();
var pics = new Array();

//获取活动图片url,放入pics[]数组中
$("#picArr li").each(function(){
    pics.push($(this).text());
});
//地图相关数据合成对象
//var lat =
//var lon =
var mapData = new Object();
mapData.latitude = parseFloat($("#location li").eq(0).text()).toFixed(3);
mapData.longitude = parseFloat($("#location li").eq(1).text()).toFixed(3);

// 更新时间的组件
// 把时间字符串转化为事件对象传给checkTime, 用setInterval方法循环更新checkTime
var getEndTime = new Date(Date.parse(endTime.replace(/-/g, "/")));
var getStartTime = new Date(Date.parse(startTime.replace(/-/g, "/"))); //测试专用：new Date("Mon Dec 01 2014 15:57:29 GMT+0800 (中国标准时间)");//

var updateTime = setInterval(function(){
        checkTime(getEndTime,getStartTime);
}, 10);//调小执行间隔，防止展现出余票数字

//颜色
var r = 255;
var g = 0;
var b = 0;
var round = 1;
function setTokenColor() {
    $("div.fetched span.token").css({
        "color": function(){
            return "rgb(" + r + "," + g + "," + b +")";
        },
        "text-shadow": function(){
            return "2px 2px 6px " + "rgb(" + r + "," + g + "," + b +")";
        }
    });
}

/*
 * ------页面局部替换需要用到的HTML字符串------
 * homeHtml: “首页”的HTML
 * fetchTrigger: 取票触发器的HTML
 * fetchedHtml: 成功取到票后的“取票”页面HTML
 * unfetchedHtml: 还没去到票时的“取票"页面HTML
 * fetchResult: 判断取票结果后的"取票"页面HTML
 * actDetailHtml: "活动详情"页面HTML
 * picsHtml: 活动照片页面HTML
 * mapHtml：活动地点页面HTML
 *---------------------------------------------
 */
var homeHtml = '<div class="toChange" id="home"><div class="actName red-emph"></div>' + (indexPicUrl?('<div class="actPic"><img src=' + indexPicUrl + '></div></div>'):'');
var fetchTrigger = ((demand == "click") ? '<button>点我抢票</button>' : "");
var fetchedHtml = '<div class="toChange" id="ticket"><div class="info fetched"><h3 class="actName red-emph">' + actName +'</h3><p class="p1">恭喜您抢到此次活动的票</p><p class="p2">领票凭据为：<br/> <span class="emph token">' + token + '</span></p><p class="p3">具体领票细节请查看活动详情<br/>活动解释权归举办方所有</p><button class="return">我要退票</button></div></div>';
var unfetchedHtml = '<div class="toChange" id="ticket"><div class="info unfetched" title="' + actID + '"><h3 class="actName red-emph">' + actName +'</h3><div class="user-data"><p>还剩 <span class="emph leftT">' + leftT +'</span> 张票</p><p>你还有 <span class="emph leftChance">' + leftChance +'</span> 次机会</p></div><div class="actTime"><p>开始时间：<span class="starttime">' + startTime + '</span></p><p>结束时间：<span class="endtime">' + endTime + '</span></p></div>' + fetchTrigger +'</div></div>';
var fetchResult = ((result == 1) ? fetchedHtml : unfetchedHtml);
var actDetailHtml = '<div class="toChange" id="detail"><div class="actName red-emph">' + actName +'</div>' + actContent + '</div>';

var ppp = function() {
    var s = '';
    for (var i=0; i<pics.length; i++) {
        var a = '<img class="picstyle" src="' + pics[i] + '">';
        s = s + a;
    }
    return s;
}
var picsHtml = '<div class="toChange" id="pics"><div>' + ppp() + '</div></div>';
var mapHtml = '<div class="toChange" id="map">活动地点</div>';

$(document).ready(function(){

    //首页
    addReplaceEvent("home",homeHtml);
    //抢票
    addReplaceEvent("ticket",fetchResult);
    //活动详情
    addReplaceEvent("detail", actDetailHtml);
    //活动图片
    addReplaceEvent("pics", picsHtml);
    //活动地点
    addReplaceEvent("map", mapHtml);
    //隐藏的停止setInverval循环的按钮
    $(".stopLoopingButton").click(function(){
        clearInterval(updateTime);
    });
    //页面加载完毕后自动显示首页
    $(".nav .home").trigger('click');
});

//每次局部页面改变后需要做的调整
function afterChange() {

    //根据窗口宽度调整顶部brand的高度，使其背景图自适应完全显示
    var windowWidth = window.innerWidth;
    var brandHeight = windowWidth * 0.5;
    $(".nav").css("height",brandHeight);

    if($(".toChange").attr("id") == "home") {              //首页
        //首页的标题前加上"活动："字样
        $("#home .actName").text("活动：" + actName);

        //点击首页图片转跳到抢票页面
        $(".actPic").click(function(){
            $(".nav .ticket").trigger('click');
        });
    }

    if($(".toChange").attr("id") == "ticket") {              //抢票页
        //拆分token并显示
        var token = $("#token").text();
        var str1 = token.substr(0,4);
        var str2 = token.substr(4,4);
        var str3 = token.substr(8,4);
        $("div.fetched span.token").text(str1 + " " + str2 + " " + str3);

        //动画变换token颜色
        var animateToken = setInterval(function(){
            switch(round) {
                case 1:
                    if(g < 255 && r > 0) {
                        g++;
                    }
                    else{
                        round = 2;
                    }
                    break;
                case 2:
                    if (r > 0) {
                        r--;
                    }
                    else{
                        round = 3;
                    }
                    break;
                case 3:
                    if(b < 255) {
                        b++;
                    }
                    else{
                        round = 4;
                    }
                    break;
                case 4:
                    if(g > 0) {
                        g--;
                    }
                    else{
                        round = 5;
                    }
                    break;
                case 5:
                    if(r < 255) {
                        r++;
                    }
                    else{
                        round = 6;
                    }
                    break;
                case 6:
                    if(b > 0) {
                        b--;
                    }
                    else{
                        round = 1;
                    }
                    break;
                default:
                    break;
            }
            setTokenColor();
        }, 8);

        //给按钮添加click事件
        $(".unfetched button").bind('click', fetchTicket);
        $("button.return").bind("click", returnTicket);

        var currentChance = parseInt($(".leftChance").text());
        if (currentChance <= 0) {
            $("button").attr("disabled","disabled").css("background-color","rgb(132, 176, 132)").text("机会已用完");
        }
    }

    if($(".toChange").attr("id") == "pics") {                //照片页
        //给照片应用微信图片播放组件
        $(".picstyle").click(function(){
            var thisUrl = $(this).attr("src");
            WeixinApi.imagePreview(thisUrl,pics);
        });
    }

    if($(".toChange").attr("id") == "map") {                 //地图页
        //显示地图
        $("#map").height(window.innerHeight*0.5);
        var map = new BMap.Map("map");
        var point = new BMap.Point(mapData.latitude, mapData.longitude);
        map.centerAndZoom(point, 14);
        map.addControl(new BMap.NavigationControl());
        map.addControl(new BMap.ScaleControl());
        map.addControl(new BMap.OverviewMapControl());
        map.addControl(new BMap.MapTypeControl());
        map.setCurrentCity("厦门");
        var marker = new BMap.Marker(point);        // 创建标注
        map.addOverlay(marker);
        webview.addEventListener('touchstart',function(e)
        {
            e.preventDefault();
        });
    }

    //检查openid
    checkOpenid();
}

//给导航栏项目添加click事件，点击后替换相应内容
function addReplaceEvent(whichPage, itsHtml) {
    $(".nav ." + whichPage).click(function(){
        $(".toChange").replaceWith(function (index, html){  //替换
            return itsHtml;
        });
        $(".active-item").removeClass('active-item');
        $(".nav ul").children('.'+ whichPage).addClass('active-item'); //导航栏中高亮当前位置
        afterChange();
    });
}

//取票
function fetchTicket() {
    $(this).attr("disabled","disabled").css("background-color","rgb(132, 176, 132)").text("抢票中");
    $.get(
        "/ticket/api/fetch",
        {
            openid: openid,
            actID: actID
        },
        function (data,status){
            $(".unfetched button").attr("disabled",false).css("background-color","green").text("点我抢票");
            var data = eval("(" + data + ")");
            if (status == "success") {
                if (data.errno == 0) {
                    if (data.data.result == 1) {
                        $("#token").text(data.data.token);
                        var manualFetchedHtml = '<div class="toChange" id="ticket"><div class="info fetched"><h3 class="actName red-emph">' + actName +'</h3><p class="p1">恭喜您抢到此次活动的票</p><p class="p2">领票凭据为：<br/> <span class="emph token">' + data.data.token + '</span></p><p class="p3">具体领票细节请查看活动详情<br/>活动解释权归举办方所有</p><button class="return">我要退票</button></div></div>';
                        addReplaceEvent("ticket",manualFetchedHtml);
                        $(".nav .ticket").trigger('click');
                    }
                    else{
                        alert("很抱歉，您这次没抢到票");
                        var currentChance = parseInt($(".leftChance").text());
                        $(".leftChance").text(currentChance-1);
                        if (currentChance <= 0) {
                            $("button").attr("disabled","disabled").css("background-color","rgb(132, 176, 132)").text("下次再来");
                        }
                    }
                }
                else {
                    alert(data.errmsg);
                }

            }
            //失败
            else {
                alert("请求失败");
            }
        }
    );
}

//退票
function returnTicket() {
    if (confirm("确定要退票吗？")) {
        $.post(
            "/ticket/api/unsign",
            {
                openid: openid,
                actID: actID,
                token: $("#token").text()
            },
            function (data,status) {
                var data = eval("(" + data + ")");
                if (status == "success") {
                    if (data.errno == 0) {
                        alert("退票成功");
                        WeixinApi.closeWindow({
                            success : function(resp){

                            },
                            fail : function(resp){

                            }
                        });
                    }
                }
                else {
                    alert("请求失败");
                }
            }
        );
    }
}

//检查时间，倒计时的时候将会被循环调用。参数要求为Date对象
function checkTime(endTime,startTime) {
    var current = new Date(); //当前时间
    if (current.getTime() >= startTime.getTime() && current.getTime() < endTime.getTime()) { //活动期间
        $(".stopLoopingButton").trigger('click'); //停止循环
        if ( $(".toChange").attr("id") == "ticket" ) {
            $(".nav .ticket").trigger('click');  //倒计时结束那一瞬间的转跳，只会在当前处于抢票页的情况下执行
        }
    }
    if (current.getTime() > endTime.getTime()) {  //活动过期
        $(".user-data").replaceWith(function() {
            return '<p class="warning">活动已结束！</p>';
        });
        $("button").attr("disabled","disabled").css("background-color","rgb(132, 176, 132)").text("下次再来");
    }
    if(current.getTime() < startTime.getTime()) {  //活动未开始
        $(".user-data").replaceWith(function() {
            return '<p id="countdownWrap">活动还没开始哦，倒计时ing：<br/><span id="countdown" class="emph"></span></p>';
        });
        var millsecLeft = startTime.getTime() - current.getTime(); //剩余微秒数
        var timeLeft = new Date(millsecLeft);  //把微秒数转化为对象，以便msToTime对其进行格式化
        $("#countdown").text( msToTime(timeLeft) );
        $(".unfetched button").attr("disabled","disabled").css("background-color","rgb(132, 176, 132)").text("耐心等待");
    }
}

//格式化时间，把微秒转换为时分秒形式
function msToTime(s) {

  function addZ(n) {
    return (n<10? '0':'') + n;
  }

  function addS(n) {
    return n + (n>1? ' Days ':' Day ');
  }

  var ms = s % 1000;
  s = (s - ms) / 1000;
  var secs = s % 60;
  s = (s - secs) / 60;
  var mins = s % 60;
  s = (s - mins) / 60;
  var hrs = s % 24;
  var days = parseInt((s - hrs) / 24);

  return  addS(days) + addZ(hrs) + ':' + addZ(mins) + ':' + addZ(secs);
}

function checkOpenid() {
    if ( openid == "") {
        alert("请从厦大易班的微信进入");
        $("button").unbind("click").bind("click", toFollow).text("关注厦大易班");
    }
}

function toFollow() {
    window.open("http://mp.weixin.qq.com/s?__biz=MjM5OTQ3MzgzMw==&mid=201696068&idx=1&sn=11a16a07706e8c0c3acd74b0c712c996#rd");
}

// 初始化WeixinApi，等待分享
WeixinApi.ready(function(Api) {

    // 微信分享的数据
    var wxData = {
        "appId": "", // 服务号可以填写appId
        "imgUrl" : '',
        "link" : '/ticket?actID=' + document.getElementById("actID").innerHTML,
        "desc" : '不定期会有精彩活动发起抢票',
        "title" : "厦大易班抢票平台"
    };

    // 分享的回调
    var wxCallbacks = {
        // 分享操作开始之前
        ready : function() {
        },
        // 分享被用户自动取消
        cancel : function(resp) {
        },
        // 分享失败了
        fail : function(resp) {
        },
        // 分享成功
        confirm : function(resp) {
        },
        // 整个分享过程结束
        all : function(resp,shareTo) {
        }
    };

    // 用户点开右上角popup菜单后，点击分享给好友，会执行下面这个代码
    Api.shareToFriend(wxData, wxCallbacks);

    // 点击分享到朋友圈，会执行下面这个代码
    Api.shareToTimeline(wxData, wxCallbacks);

    // 点击分享到腾讯微博，会执行下面这个代码
    Api.shareToWeibo(wxData, wxCallbacks);

    // iOS上，可以直接调用这个API进行分享，一句话搞定
    Api.generalShare(wxData,wxCallbacks);

    // 隐藏右上角菜单
    Api.hideOptionMenu();
});

