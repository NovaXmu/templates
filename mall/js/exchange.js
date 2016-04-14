

	$("#confirmBtn").bind("click", toExchange);

	function toExchange() {
		var id = $("#id").text();
		$.get(
			'/mall/api/exchange?m=exchange2&id=' + id,
			function(data) {
				$("#confirm-div").hide();
				var data = jQuery.parseJSON(data);
				if(data.errno == 0) {
					// 兑换成功
					var token = data.token;
					var str1 = token.substr(0,4);
					var str2 = token.substr(4,4);
					var str3 = token.substr(8,4);
					$("#success-div .token").text(str1 + " " + str2 + " " + str3);
					$("#success-div").show();
				}
				else {
					$("#fail-div").find('p#errmsg').text(data.errmsg);
					$("#fail-div").show();
				}
			}
		);
	}