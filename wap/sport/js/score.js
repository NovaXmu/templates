// 初始化WeixinApi，等待分享
WeixinApi.ready(function(Api) {

    // 微信分享的数据
    var wxData = {
        "appId": "", // 服务号可以填写appId
        "imgUrl" : 'http://www.novaxmu.cn:8080/wap/sport/img/sports.jpg',
        "link" : 'http://www.novaxmu.cn:8080/wap/sport?m=index',
        "desc" : '校运会积分榜，厦大易班为您同步更新！',
        "title" : "厦门大学校运会积分榜"
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

function Score(numArray,name) {
	this.render = function() {
		var row = document.createElement("div");
		row.className = "row clearfix";
		for (var i = 0; i < numArray.length; i++ ) {
			var num = document.createElement("div");
			num.className = "num";
			num.innerHTML = numArray[i];
			row.appendChild(num);
		}
		var label = document.createElement("span");
		label.className = "label";
		label.innerHTML = name;
		row.appendChild(label);
		return row;
	}
}

function makeCard(data, index, hidden) {
		var card = document.createElement("div");
		card.className = "card";
		card.setAttribute("id", data.id);
		card.dataset.bk = data["jifen_bk"];
		card.dataset.yjs = data["jifen_yjs"];
		/*card.dataset.bkOld = data["jifen_bk_old"];
		card.dataset.yjsOld = data["jifen_yjs_old"];*/
		card.dataset.sum = data["sum"];
		card.dataset.time = data["time"];

		var ranking = document.createElement("div");
		ranking.className = "ranking";

		var medalImg = document.createElement("img");
		medalImg.src = BASE + "wap/sport/img/index/" + index + ".png";
		medalImg.setAttribute("alt","medal");

		ranking.appendChild(medalImg);
		card.appendChild(ranking);

		var header = document.createElement("header");
		header.style.backgroundImage = "url(/templates/wap/sport/img/logo/" + data['log_id'] + ".png)"

		var instName = document.createElement("h1");
		instName.className = "instName";
		instName.innerHTML = data['xueyuan'];
		header.appendChild(instName);
		card.appendChild(header);

		var scores = document.createElement("div");
		scores.className = "scores";

		var benkeScore = new Score(data["jifen_bk_result"],"(本科生)").render();
		var yjsScore = new Score(data["jifen_yjs_result"],"(研究生)").render();
		var totalScore = new Score(data["sum_result"],"(总分)").render();

		scores.appendChild(benkeScore);
		scores.appendChild(yjsScore);
		scores.appendChild(totalScore);

		$(scores).on("click", function() {
			location.href="sport?m=detail&xueyuan_id="+ data.id + "&year=" + $("#year").find("li.selected").text();
		});

		card.appendChild(scores);

		var footer = document.createElement("div");
		footer.className = "footer";

		var likeWrapper = document.createElement("div");
		likeWrapper.className = "like";
		if (data["isPraised"]) {
			likeWrapper.classList.add("liked");
		} else {
			likeWrapper.classList.remove("liked");
		}

		var jiayouTxt = document.createElement("span");
		jiayouTxt.innerHTML = "加油";
		var count = document.createElement("span");
		count.className = "count";
		count.innerHTML = data["dianzan"];
		likeWrapper.appendChild(jiayouTxt);
		likeWrapper.appendChild(count);

		$(likeWrapper).on("click", function() {
			/*$.get(
				"api/sport?m=cheer",
				{
					xueyuan_id: data.id,
					year: document.querySelector("#year li.selected").innerHTML
				},
				function(response) {
					if (response.errno != 0) {
						alert(response.errmsg);
					} else {
						if ( $(this).hasClass("liked") ) {
							//取消赞
							$(this).find(".count").text( Number($(this).find(".count").text()) - 1 );
						} else {
							//加赞
							$(this).find(".count").text( Number($(this).find(".count").text()) + 1 );
						}
						$(this).toggleClass("liked");
					}
				}.bind(this), "JSON"
			);*/
			var likeNumOnBar = $(this).parents(".card").siblings(".bar").find(".likes");
			$.ajax({
				url: "api/sport?m=cheer",
				data: {
					xueyuan_id: data.id,
					year: document.querySelector("#year li.selected").innerHTML
				},
				type: "GET",
				dataType: "JSON",
				beforeSend: loading,
				success: function(response) {
					loaded();
					if (response.errno != 0) {
						alert(response.errmsg);
					} else {
						if ( $(this).hasClass("liked") ) {
							//取消赞
							var num = Number($(this).find(".count").text()) - 1;
							$(this).find(".count").text(num);
							if (likeNumOnBar) {
								likeNumOnBar.text("加油数：" + num )
							}
						} else {
							//加赞
							num = Number($(this).find(".count").text()) + 1;
							$(this).find(".count").text(num);
							if (likeNumOnBar) {
								likeNumOnBar.text("加油数：" + num )
							}
						}
						$(this).toggleClass("liked");
					}
				}.bind(this)
			});
		});

		footer.appendChild(likeWrapper);
		card.appendChild(footer);


		if (hidden) {
			card.classList.add("hidden")
			var wrapper = document.createElement("div");
			wrapper.className = "card-wrapper";
			var bar = document.createElement("div");
			bar.className = "bar";
			bar.innerHTML = '<span class="xueyuan-name" style="font-weight: bold;">' + data['xueyuan'] + '</span><p style="text-align: right"><span class="total-score">总分：'+ data["sum"] +'</span>&nbsp;&nbsp;<span class="likes">加油数：'+ data["dianzan"] +'</span></p>';
			$(bar).on("click", function(e) {
				var itsCard = $(this).siblings(".card");
				itsCard.slideToggle("fast");
			});
			wrapper.appendChild(bar);
			wrapper.appendChild(card);
			return wrapper;
		}

		return card;
}

function makePost(data) {
	var li = document.createElement("li");
	li.dataset.id =  data.id;

	var wrap = document.createElement("div");
	wrap.className = "wrap";

	var user = document.createElement("div");
	user.className = "user";
	user.dataset.openid = data.openid;

	var avatar = document.createElement("div");
	avatar.className = "avatar";

	var img = document.createElement("img");
	img.src = data.headimgurl;
	img.setAttribute("alt","头像");

	var username = document.createElement("span");
	username.className = "username";
	username.innerHTML = data.nickname;

	var msg = document.createElement("div");
	msg.className = "msg";
	msg.innerHTML = data.content;

	var footer = document.createElement("div");
	footer.className = "footer";

	var time = document.createElement("time");
	time.innerHTML = data.time;

	avatar.appendChild(img);
	user.appendChild(avatar);
	user.appendChild(username);
	wrap.appendChild(user);
	wrap.appendChild(msg);
	footer.appendChild(time);
	li.appendChild(wrap);
	li.appendChild(footer);

	return li;

}

function showPostPage(index, loadingIcon) {
	$.ajax({
		url: "/wap/api/sport?m=getMoreMessage",
		type: "POST",
		data: {
			index: index
		},
		dataType: "JSON",
		beforeSend: loadingIcon? loading : null,
		complete: loadingIcon? loaded: null,
		success: function(response) {
			if ( response.length < 1 ) {
				return;
			}
			$("#msg-list").empty();
			$("#msg-list").data("page", index);
			for ( var i = 0; i < response.length; i++ ) {
				$("#msg-list").append(makePost(response[i]));
			}
		}
	});
}

onload = function() {
	var topWrapper = document.getElementById("tops");
	var lessersWrapper = document.getElementById("lessers");
	var request = new XMLHttpRequest();
	var order = document.querySelector("#order li.selected").dataset.key;
	var year = document.querySelector("#year li.selected").innerHTML;
	request.open("GET", "/wap/api/sport?m=update&order="+ order +"&year=" + year, true);
	request.onreadystatechange = function() {
		if ( request.readyState == 1 ) {
			loading();
		}
		if ( request.readyState == 4 && request.status == 200 ) {
			loaded();
			var response = request.responseText;
			if (response) {
				response = JSON.parse(response);
			}
			if ( Object.prototype.toString.call(response) == "[object Array]" ) {
				for ( var i = 0; i < response.length; i++ ) {
					if ( i < 8 ) {
						if ( topWrapper ) {
							topWrapper.appendChild(makeCard(response[i], i+1, false));
						}
					} else {
						if ( lessersWrapper ) {
							lessersWrapper.appendChild(makeCard(response[i], i+1, true));
						}
					}
				}

			}
		}
	};
	request.send(null);
	/*setInterval(function() {
		var currentPage = parseInt($("#msg-list").data("page"));
		if ( currentPage == 1 ) {
			showPostPage(1, false);
		}
	}, 3000)*/
};

$("menu li.selected").on("click", function() {
	$(this).siblings("a").find("li").toggle();
});


function loading() {
	var loading = document.getElementById("loading");
	loading.style.display = "block";
}

function loaded() {
	var loading = document.getElementById("loading");
	loading.style.display = "none";
}

$("button#prev").on("click", function() {
	var current = parseInt($("#msg-list").data("page"));
	if ( current <= 1 ) {
		alert("已经是第一页啦");
		return;
	}
	showPostPage(current - 1, true);
});

$("button#next").on("click", function() {
	var current = parseInt($("#msg-list").data("page"));
	showPostPage(current + 1, true);
});

$("#new-msg").on("click", function() {
	var content = $("textarea#input").val().trim();
	/*if ( !content ) {
		alert("亲，不能发表空内容");
	}*/
	if ( content.length > 100 ) {
		alert("亲，留言字数不能多于100字");
		return;
	}
	$.ajax({
		url: "/wap/api/sport?m=addMessage",
		type: "POST",
		data: {
			content: content
		},
		dataType: 'JSON',
		success: function(response) {
			if ( response.errno == 0 ) {
				//发布成功
				showPostPage(1, true);
				$("textarea#input").val("")
			} else {
				alert(response.errmsg);
			}
		}
	});
});


$(function () {
	var elem = document.createElement("img");
	elem.setAttribute("id", "loading");
	elem.src = BASE + "wap/sport/img/loader.gif";
	elem.style.display = "none";
	document.body.appendChild(elem);
});

/*
$(function() {
	var all = document.documentElement.className.split(" ");
	var str = "";
	for ( var i in all ) {
		if ( /\bno-\w+/gi.test(all[i]) ) {
			str+= ("</br>" + all[i]);
		}
	}
	$("#test").html(str);
})*/
