var UL_W=$(".labels ul").innerWidth();
var labelLi=$(".labels ul li");

$(document).ready(function(){
	if(UL_W>500)
		LI_W=80;
	else
		LI_W=(UL_W-60)/3;
	labelLi.width(LI_W);
	labelLi.height(LI_W);
});

$(".labels ul li .love").click(function(){
	if($(this).hasClass("set")){
		$(this).removeClass("set");
		$(this).children().attr("src","/templates/meet/img/love.png");
	}
	else{
		$(this).addClass("set");
		$(this).children().attr("src","/templates/meet/img/pink.png");
	}
});

//保存并发布
$(".save").click(function(){
	var labelsId=[];
	$(".labels ul li").each(function(){
		if($(this).find(".love").hasClass("set"))
			labelsId.push($(this).attr("id"));
	});
	//alert(labelsId);
	$.post(
		"/meet/api/person?m=updateUserLabel",
		{
			'labelArr':JSON.stringify(labelsId),
			'type':$(".labels").attr("id")
		},
		function(data){
			data=jQuery.parseJSON(data);
			if(data.errno==0){
				alert("发布成功");
				window.location.href="/meet/person?m=card";
			}
			else
				alert(data.errmsg);
		});
});

