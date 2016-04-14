

	$("#submitBtn").bind("click", toAuction);

	$(".ab").click(function() {
		$("#add .ab").removeClass('ab-active');
		$(this).addClass('ab-active');
	});

	function toAuction() {
		var id = $("#id").text();
		var price = $(".ab-active").attr("amount");
		if(price==null) {
			alert("请选择加价幅度");
		} else if (id==null) {
			alert("请求失败：缺少商品id参数，请返回上一页重新兑换");
		} else {
			$.get(
			'/mall/api/auction?m=auction2&id=' + id + '&price=' + price,
			function(data) {
				$("#choose-div").hide();
				var data = jQuery.parseJSON(data);
				if(data.errno == 0) {
					// 竞价成功
					$("#success-div").show();
				}
				else {
					// 竞价失败
					$("#fail-div").find('p#errmsg').text(data.errmsg);
					$("#fail-div").show();
				}
			}
		);
		}
	}
