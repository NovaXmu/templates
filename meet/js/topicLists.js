//发话题|话题榜切换
$(".tab-left").click(function(){
	activateTab($(this));
	$(".topicLaunch").hide();
	$(".topic").show();
});
$(".tab-right").click(function(){
	activateTab($(this));
	$(".topic").hide();
	$(".topicLaunch").show();
});

//查看更多话题
var index;//记录更多话题的点击次数
$(document).ready(function(){
	index=0;//初始化
});
$("#moreTopic").click(function(){
	index++;
	$.post(
		"/meet/api/topic?m=getMoreTopic",
		{
			'index':index
		},
		function(data){
			data=jQuery.parseJSON(data);
			for(var i=0;i<data.length;i++)
			{
				var href="http://img02.fs.yiban.cn/"+""+data[i].user_ybid+""+"/avatar/user/200";
                $("#moreTopic").before('\
                	<div class="topic col-xs-12" id="'+data[i].id+'">\
                	<div class="enterTopic col-xs-12">\
                	<div class="topicName col-xs-12" onclick="topicClick(event,this)">\
						<div class="col-xs-9 col-xs-offset-3 name">\
							<span>'+data[i].title+'</span>\
						</div>\
						<div class="col-xs-9 col-xs-offset-3 time">\
							<span>'+data[i].time+'</span>\
						</div>\
					</div>\
					<div class="face popMask" id="'+data[i].user_ybid+'" onclick="popMask(event,this)">\
					</div>\
					<div class="col-xs-12 topicContent">\
                	<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">\
                	<p>'+data[i].content+'</p>\
                	<div style="float:right;" class="praise">\
						<span style="font-size:15px;">'+data[i].praiseCount+'</span>\
						<img src="http://www.novaxmu.cn:8080/templates/meet/img/pinglun.png" style="margin-left:15px;" onclick="pinglunClick(this)">\
						<span style="font-size:15px;">'+data[i].commentCount+'</span>\
					</div>\
                	</div>\
                	</div>\
					</div>\
					<div class="forbidEnter col-xs-12">\
					<textarea id="COMMENT" class="commentInput" placeholder="我也说一句" onfocus="focusTextarea(this)" onblur="blurTextarea(this)"></textarea>\
                	<button type="button" class="btn-comment" onmousedown="comment(this,'+data[i].id+','+data[i].user_ybid+')" style="display:none">发送</button>\
                	</div>\
				    </div>');
                $("#moreTopic").prev().find('.face').css("background-image","url("+href+")");
                if(data[i].isPraised)
                	$("#moreTopic").prev().find('.praise').prepend('<img src="http://www.novaxmu.cn:8080/templates/meet/img/quxiaozan.png" class="dianzan great" onclick="praise(this,1,'+data[i].id+')"/>');
                else
                	$("#moreTopic").prev().find('.praise').prepend('<img src="http://www.novaxmu.cn:8080/templates/meet/img/dianzan.png" class="dianzan" onclick="praise(this,1,'+data[i].id+')"/>');
            }
		});
});

//发起话题
$(".topicLaunch .launch").click(function(){
	$.post(
		"/meet/api/topic?m=addTopic",
		{
			'title':$(".topicLaunch input[name='topicName']").val(),
			'content':$(".topicLaunch #topicContent").val()
		},
		function(data){
			data=jQuery.parseJSON(data);
			if(data.errno==0)
			{
				//alert("发布成功！");
				location.reload();
			}
			else
				alert(data.errmsg);
		});
});


//点击进入话题详情
function topicClick(event,e){
	//alert(event.target.nodeName);
	if(event.target.nodeName!="IMG"){
		var topicId=$(e).parent().parent().attr("id");
		window.location.href="/meet/topic?m=topic&topic_id="+topicId+"";
	}
	else
		return false;
}