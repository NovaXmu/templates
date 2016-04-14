$(document).ready(function() {
	var baseUrl = $("#header #baseUrl").html();
	$(".item:odd").css('background-color',"#3EF09E");
	$(".item:odd").find('.desc').css("color","#fff").end().find('.tri').css("color","#3EF09E");
	$(".item:odd .desc .auctionBtn").attr("src", baseUrl + 'mall/img/auction_btn_white.png');
	$(".item:even .desc .auctionBtn").attr("src", baseUrl + 'mall/img/auction_btn_green.png');

	$(".toggleDt").bind("click", toggleDetail);
	
	var flag = true;
	function toggleDetail() {
		var thisDesc =$(this).parents(".desc").eq(0);
		thisDesc.find('.detail').toggle('fast');
		var id = thisDesc.find('.item-id').text();
		if(flag) {
			$.get(
				'/mall/api/auction?m=detail&id=' + id
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

});