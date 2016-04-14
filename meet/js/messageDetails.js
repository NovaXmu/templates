//查看话题
function viewTopic(e){
	var topic_id=$(e).find(".name").children().attr("id");
	window.location.href="/meet/topic?m=topic&topic_id="+topic_id+" ";
}
//查看更多消息
var index;//记录更多消息的点击次数
$(document).ready(function(){
	index=0;//初始化
});
$(".moreRecords").click(function(){
	index++;
	var type=$(this).attr("id");
	$.post(
		"/meet/api/message?m=getMoreMessage&type="+type+" ",
		{
			'index':index
		},
		function(data){
			data=jQuery.parseJSON(data);
			if ( !data || data.length == 0 ) {
				alert("没有更多消息");
				return;
			}
			for(var i=0;i<data.length;i++)
			{
				var href="http://img02.fs.yiban.cn/"+""+data[i].from_user_ybid+""+"/avatar/user/200";
			$("#content button.moreRecords").before('\
				<div class="recordMenu col-xs-12">\
				<div class="record col-xs-12">\
				<div class="recordName col-xs-12">\
				<div class="col-xs-9 col-xs-offset-3 name">\
				<span id="'+data[i].topic_id+'">'+data[i].title+'</span>\
				</div>\
				<div class="col-xs-9 col-xs-offset-3 time">\
				<span>'+data[i].time+'</span>\
				</div>\
				</div>\
				<div class="face popMask" id="'+data[i].from_user_ybid+'" onclick="popMask(event,this)">\
				</div>\
				<div class="col-xs-12 recordContent">\
				<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">\
				<p>'+data[i].content+'</p>\
				</div>\
				</div>\
				</div>\
				</div>');
			$("#content button.moreRecords").prev().find(".face").css("background-image","url("+href+")");
			if(type==5){
				$("button.moreRecords").prev().find(".recordName").attr("onclick","viewTopic(this)");
				$("button.moreRecords").prev().find(".record").after('\
					<div class="col-xs-12 recordReply">\
					<textarea id="COMMENT" class="commentInput" onfocus="focusTextarea(this)" onblur="blurTextarea(this)" placeholder="回复"></textarea>\
					<button type="button" class="btn-comment" onmousedown="comment(this,'+data[i].topic_id+','+data[i].from_user_ybid+','+data[i].comment_id+')" style="display:none">发送</button>\
					</div>');
			}
						
}
		});
});