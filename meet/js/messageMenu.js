//进入话题|pk消息页面
$(".toDetails").click(function(){
	var type=$(this).attr("id");
	var setRead=parseInt($(this).find("span.count").text())==0?-1:1;
	window.location.href="/meet/Message?m=readMessage&type="+type+"&setRead="+setRead+" ";
});

//进入朋友消息页面
$(".toMessage").click(function(){
	var user_ybid=$(this).find(".face").attr("id");
	var setRead=parseInt($(this).find("span.count").text())==0?-1:1;
	window.location.href="/meet/message?m=readMessage&type=1&user_ybid="+user_ybid+"&setRead="+setRead;
});
