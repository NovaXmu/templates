$(document).ready(function() {
	//样式调整
	adjust();
	//显示绑定厦大表单
	$(".xmu-bind").bind("click", function() {
		$(".menu").hide();
		$(".bindXmu").show();
	});
	//绑定易班
	$(".yiban-bind").bind("click", bindYiban);
	//解除厦大绑定
	$(".xmu-unbind").bind("click", function() {
		unbind("xmu");
	});
	//解除易班绑定
	$(".yiban-unbind").bind("click", function() {
		unbind("yiban");
	});
	//阻止回车键默认行为
	$("input").keydown(function(event) {
		if (event.keyCode == "13") {
			event.preventDefault();
		}
	});
	//返回选择
	$(".return").click(function() {
		$(".bindXmu").hide();
		$(".menu").show();
	});
});

function adjust() {
	var square = $("div.option");
	var count = square.length;
	$(".bind").css("width",142*count + "px");
}

//绑定厦大账号
$("#xmu-form .submit").bind("click", function (event) {
	$.post(
		"/wap/api/xmulinkin",
		{
			num: $("#stdNum").val(),
			password: $("#password").val(),
			openid: $("#openid").text()
		},
		function (data, status) {
			var data = eval("(" +  data + ")");
			if (status == "success") {
				if (data.errno == 0) {
					alert('绑定成功！');
					WeixinApi.closeWindow({
				        success : function(resp){
				            
				        },
				        fail : function(resp){
				     
				        }
					});
				}
				else {
					alert(data.errmsg);
				}
			}
			else {
				alert("请求失败");
			}
		}
	);
	event.stopPropagation();
	event.preventDefault(); 
});

function bindYiban() {
	var openid = $("#openid").text();
	/*$.get(
		'/wap/api/yibanlinkin?openid=' + openid,
		function() {

		}
	);*/

	window.location.href = '/wap/api/yibanlinkin?openid=' + openid;
}

function unbind(m) {
	if (confirm("确定解除绑定？")) {
		var openid = $("#openid").text();
		$.get(
			"/wap/api/unlink",
			{
				"openid": openid,
				"m": m
			},
			function (data, status) {
				var data = eval("(" +  data + ")");
				if (status == "success") {
					if (data.errno == 0) {
						alert("成功解除绑定");
						window.location.reload();
					}
					else {
						alert(data.errmsg);
					}
				}
				else {
					alert("请求失败");
				}
			}
		);
	}
}


WeixinApi.ready(function(Api) {
	Api.hideOptionMenu();
});