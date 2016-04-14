
	var baseUrl = $("#header #baseUrl").html();
	$(".item:odd").css('background-color',"#0099FF");
	$(".item:odd").find('.desc').css("color","#fff").end().find('.tri').css("color","#0099FF");
	$(".item:odd .desc .exchangeBtn").attr("src", baseUrl + 'mall/img/exchange_btn_white.png');
	$(".item:even .desc .exchangeBtn").attr("src", baseUrl + 'mall/img/exchange_btn_blue.png');

	$(".toggleDt").bind("click", toggleDetail);
	$(".toggleCond").bind("click", toggleCondition);
	var flag = true;
	function toggleDetail() {
		var thisDesc =$(this).parents(".desc").eq(0);
		thisDesc.find('.detail').toggle('fast');
		var id = thisDesc.find('.item-id').text();
		if(flag) {
			$.get(
				'/mall/api/exchange?m=detail&id=' + id
			);
			flag = false;
		} else {
			flag = true;
		}
		return false;
	}

	function toggleCondition() {
		$(this).parent().siblings(".condition").eq(0).toggle('fast');
		return false;
	}