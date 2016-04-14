<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function($) {
		$("body.index #header #balance-logo").attr("src", "{$base}mall/img/balance_logo_white.png");
		$("body.mine #header #balance-logo").attr("src", "{$base}mall/img/balance_logo_white.png");
		fixAvatar();
	});
	$(window).resize(function(event) {
		fixAvatar();
	});
	function fixAvatar() {
		var avatarWidth = $("#mine-entry").width();
		$("#mine-entry").height(avatarWidth);
	}
	var schoolid = {$personInfo.yb_schoolid};

	if ( schoolid != "314" && ($(document.body).hasClass("exchange") ||  $(document.body).hasClass("auction"))) {
		$(".item").hide();
		$(".not-xmu").show();
	}

	function showXmuItems(e) {
		e.preventDefault();
		$(".item").show();
		$(".not-xmu").hide();
	}
</script>