// 签到页
// 
var colors=new Array(['yellow'],['red'], ['blue'], ['green'], ['pink'], ['purple'], ['grey'] ,['#5C3317'], ['#B5A642'] ,['#00FFFF']);
$(document).ready(function() {
	switchResult();
	$("div.button").bind("click", checkIn);
	// true or false
    /*var flag = WeixinApi.openInWeixin();
    if(!flag) {
    	$(".main").show();
		$(".checked-in.auto").hide();
		alert("没有在微信内置浏览器中打开\n请从厦大易班微信公众平台进入\n(WP版微信内置浏览器目前暂时无法识别，造成不便，请您谅解）");
		$("div.button").unbind("click", checkIn).bind("click", toFollow).css("color","rgb(255, 213, 0)").text("关注厦大易班");
	}
	else if ( $("#stdNum").text() == "") {
		$(".main").show();
		$(".checked-in.auto").hide();
		alert("请从厦大易班微信公众平台进入(记得先绑定账号哦)");
		$("div.button").unbind("click", checkIn).bind("click", toFollow).css("color","rgb(255, 213, 0)").text("关注厦大易班");
	}*/
});

function switchResult() {
	var result = $("#isChecked").text();
	if (result == 1) {
		$(".checked-in.auto").show();
		$(".main").hide();
	}
	else {
		$(".main").show();
		$(".checked-in.auto").hide();
	}
}
function viewMoney(){
	$.post(
		"/checkin/api/pay",
		{
			num:$("#stdNum").text()
		},
		function (data){
			data=jQuery.parseJSON(data);
			alert(data.errmsg);
		});
}
function checkIn() {

	if($(".question input:checked").length == 0) {
		alert("请选择一个答案");
	}
	else{
		var myanswer=$(".question .option input:checked").eq(0).attr('value');
		var i;

        for(i=1;i<$(".question .option input:checked").size();i++)
        {
        	myanswer+='|'+$(".question .option input:checked").eq(i).attr('value');
        }
		$.get(
			"/checkin/api/answer",
			{
				num: $("#stdNum").text(),
				id: $(".question").attr("title"),
				answer: myanswer,
				source: "wechatyiban"
			},
			function (data,status) {
				var data = eval ("(" + data + ")");
				if (status == "success") {
					if (data.errno == 0) 
					{
						$("span.pay").text(data.data.pay);
						$("div.main").hide();
						$(".order").text(data.data.order);
						$(".monthCount").text(data.data.monthCount);
						$(".checked-in").show();
						$(".checked-in.auto").hide();
						if(data.data['questionType']==0)
						{
							if(data.data['isRight'])
						    {
							   $("div#replyRight").show();
							   $("div#replyWrong").hide();
						    }
						    else
						    {
							   var rightAnswer=data.data['rightAnswer'].join(',');
							   $("span.right").text(rightAnswer);
							   $("div#replyWrong").show();
							   $("div#replyRight").hide();
						    }
						    $("div#question").show();
						    $("div#questionnaire").hide();
						}
						else
						{
							$("div#questionnaire").show();
							$("div#question").hide();
							var len=data.data['optionRate'].length;
						
							var Bardata={
								labels:[],
								datasets:[{
									fillColor:"rgba(220,220,220,0.5)",
									strokeColor:"rgba(220,220,220,1)",
									data:[]
								}]
							};
							for(i=0;i<len;i++)
							{
								Bardata['labels'].push(data.data['optionRate'][i]['key']);
								Bardata['datasets'][0]['data'].push(data.data['optionRate'][i]['value']);
							}
							var ctx=$("canvas#analysePie").get(0).getContext("2d");

							var BarChart=new Chart(ctx).Bar(Bardata,{scaleOverlay:true,scaleLineColor:"white",
								scaleLineWidth:3,	scaleShowLabels:true,	scaleFontColor :"white"});

						}
					}
					else {
						$("div.button").unbind("click").addClass('button-disabled').css("color","#666");
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
        "link" : '/checkin',
        "desc" : '每月根据排名有精美礼品送出',
        "title" : "厦大易班签到平台"
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
});
