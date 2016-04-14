//点击回复按钮 type=2(二级评论)|3(三级评论)
function huifuClick(e,name,type){
	var label="回复"+name;
	if(type==2){
		var textarea=$(e).parents("li").find(".textarea");
		var comment_id=$(e).parents("li").attr("id");
		var to_id=$(e).parents("li").find(".img").attr("id");
	}
	if(type==3){
		var textarea=$(e).parents(".reply").nextAll(".textarea");
		var comment_id=$(e).parents("li").attr("id");
		var to_id=$(e).find(".from").attr("id");
	}
	textarea.attr("id",comment_id);
	textarea.find("button").attr("id",to_id);
	textarea.show();
	textarea.find("#REPLY").focus();
	textarea.find("#REPLY").attr("placeholder",label);
   
}

//查看更多评论
var index;//记录更多评论的点击次数
$(document).ready(function(){
	index=0;//初始化
});
$("#moreComment").click(function(){
    index++;
	$.post(
		"/meet/api/topic?m=getMoreComment",
		{
			'index':index,
			'topic_id':$(".topic").attr("id")
		},
    function(data){
		data=jQuery.parseJSON(data);
		for(var i=0;i<data.length;i++){
			var name="'"+data[i].nickname+"'";
			//alert(name);
			//var src="http://img02.fs.yiban.cn/"+""+data[i].from_user_ybid+""+"/avatar/user/200";
			$(".comment ul.comment-ul").append('\
				<li id="'+data[i].id+'">\
				<div class="col-xs-12" style="height:20px;"></div>\
				<div class="col-xs-2 img popMask" id="'+data[i].from_user_ybid+'" onclick="popMask(event,this)">\
				</div>\
				<div class="col-xs-10">\
				<div class="col-xs-12">\
				<span style="font-size:15px;">'+data[i].nickname+'</span>\
				<div class="operate">\
				<span>'+data[i].praiseCount+'</span>\
				<button type="button" class="btn-reply" onclick="huifuClick(this,'+name+',2)">回复</button>\
				<span>'+data[i].commentCount+'</span>\
				</div>\
				</div>\
				<div class="col-xs-12">\
				<span style="font-size:10px;">'+data[i].time+'</span>\
				</div>\
				</div>\
				<div class="col-xs-10 col-xs-offset-2" style="margin-top:5px;">\
				<p>'+data[i].content+'</p>\
				</div>\
				<div class="col-xs-12 textarea" style="display:none">\
				<textarea id="REPLY" class="commentInput" placeholder="回复" onfocus="focusTextarea(this)" onblur="blurTextarea(this)"></textarea>\
				<button type="button" class="btn-replyComment" onmousedown="replyComment(this)">回复</button>\
				</div>\
				</li>');
			$(".comment ul.comment-ul li:last-child").find(".img").append('<img src="http://img02.fs.yiban.cn/'+data[i].from_user_ybid+'/avatar/user/200" class="commentAvator"/>');
			if(data[i].isPraised)
				$(".comment ul.comment-ul li:last-child").find(".operate").prepend('<button type="button" class="great" onclick="praise(this,2,'+data[i].id+')">取消赞</button>');
			else
				$(".comment ul.comment-ul li:last-child").find(".operate").prepend('<button type="button" onclick="praise(this,2,'+data[i].id+')">点赞</button>');
			if(data[i].commentCount>0)
				$(".comment ul.comment-ul li:last-child").find(".textarea").before('\
					<div class="col-xs-12">\
					<button type="button" class="btn-viewComment" onclick="viewComment(this)">查看回复</button>\
					</div>');
		}
	});
});

//回复评论
function replyComment(e){
	$.post(
		"/meet/api/topic?m=addComment",
        {
            'topic_id':$(".topic").attr('id'),
            'content':$(e).prev().val(),
            'to_id':$(e).attr("id"),
            'comment_id':$(e).parent().attr('id')
        },
        function(data){
        	data=jQuery.parseJSON(data);
        	if(data.errno==0){
        		//alert("回复成功！");
        		var count=parseInt($(e).parents("li").find(".btn-reply").next().text());
        		if(count==0){
        			$(e).parent().before('\
        				<div class="col-xs-12">\
        				<button type="button" class="btn-viewComment" onclick="viewComment(this)">查看回复</button>\
        				</div>');
        		}
        		count=count+1;
        		$(e).parents("li").find(".btn-reply").next().text(count);
        		$(e).parents("li").find(".btn-hideComment").click();
        		$(e).parents("li").find(".btn-viewComment").click();
        	}
        	else
        		alert(data.errmsg);
        });
}

//查看回复
function viewComment(e){
	$(e).parent().before('\
		<div class="reply col-xs-9 col-xs-offset-3">\
		<ul></ul>\
		</div>');
	$.post(
		"/meet/api/topic?m=getCommentDetail",
		{
			'comment_id':$(e).parents("li").attr('id')
		},
		function(data){
			data=jQuery.parseJSON(data);
			for(var i=0;i<data.length;i++){
				var name="'"+data[i].from_nickname+"'";
				$(e).parents("li").find(".reply ul").append('\
					<li id="'+data[i].id+'" onclick="huifuClick(this,'+name+',3)">\
					<span class="from" id="'+data[i].from_user_ybid+'">'+data[i].from_nickname+'</span>回复<span>'+data[i].to_nickname+'</span>：'+data[i].content+'</li>');
			}
			$(e).parent().hide();
			$(e).parent().after('\
				<div class="col-xs-12">\
				<button type="button" class="btn-hideComment" onclick="hideComment(this)">收起回复</button>\
				</div>');
		});
}

//收起回复
function hideComment(e){
	$(e).parents("li").find(".reply").remove();
	$(e).parent().prev().show();
	$(e).parent().remove();
}