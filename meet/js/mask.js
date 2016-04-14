var modal=$('[data-remodal-id=modal]').remodal();
$(".popMask").click(function (e) {
	popMask(e, this);
});

function popMask(event,e){
	stopPropagation(event);
	var userid=$(e).attr("id");
	var type = $(e).data("t");
	if(!userid || type == 1) {
		return false;
	}
	var imgSrc="http://img02.fs.yiban.cn/"+userid+"/avatar/user/200";
	$(".remodal").attr("id",userid);
	$.ajax({
		url: "/meet/api/person?m=similarRate",
		type: "POST",
		data: {
			'user_ybid':userid
		},
		dataType: "json",
		beforeSend: loading,
		complete: loaded,
		success: function(data){
			$(".remodal p:last").text(data.errmsg['rate']);
			$(".remodal #avatar").find("img").attr({"src":imgSrc,"id":userid}).end().find("p.nickname").text(data.errmsg['info']['nickname']);
			if(data.errno==0)
				modal.open();
			else
				alert(data.errmsg.rate);
		}
	});
}

//个人主页跳转
$(".remodal .to-main").click(function(){
	var user_ybid=$(".remodal").attr("id");
	window.location.href="/meet/person?m=index&user_ybid="+user_ybid+"";
});

//pk页跳转
$(".remodal .to-pk").click(function(){
	var user_ybid=$(".remodal").attr("id");
	window.location.href="/meet/person?m=PK&user_ybid="+user_ybid+"";
});

