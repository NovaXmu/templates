<!DOCTYPE html>
<html lang=zh>
	<head>
		<meta charset="utf-8">
		<title>首页</title>
		{include file="mall/styleTag.tpl"}
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="{$base}mall/css/public.css">
		<link rel="stylesheet" href="{$base}mall/css/index.css">
	</head>
	<body class="index">
		
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				{include file="mall/Header.tpl"}
				<div id="content">
					<!-- 不同页面的具体内容 -->
					<div id="showbox" class="row">
						<span id="carousel-left" class="arrow col-xs-1">&lt;</span>
						<ul id="carousel" class="col-xs-8 col-xs-offset-1">
						{if is_array($newestList)}
							{if is_array($newestList['auction'])}
							<li>
								<a href="/mall/auction?m=auction1&id={$newestList['auction'].id|default:'null'}" >
									<div class="img-wrapper">
										<img src='{$newestList["auction"].pic|default: "{$base}templates/mall/img/1.jpg"}'>
										
									</div>
									<div class="crsl-info">
										<p class="name">{$newestList['auction'].name|default:'未命名'}</p>
										<p class="type">类型：最新竞价商品</p>
									</div>
								</a>
							</li>
							{/if}
							{if is_array($newestList['exchange'])} 
							<li>
								<a href="/mall/exchange?m=exchange1&id={$newestList['exchange'].id|default:'null'}" >
									<div class="img-wrapper">
										<img src='{$newestList["exchange"].pic|default: "{$base}templates/mall/img/1.jpg"}'>
										
									</div>
									<div class="crsl-info">
										<p class="name">{$newestList['exchange'].name|default:'未命名'}</p>
										<p class="type">类型：最新可兑换商品</p>
									</div>	
								</a>
							</li>
							{/if}
						{/if}

						{if is_array($hotList)}
							{foreach $hotList as $value}
							<li>
								{if $value.type eq "0"}
								<a href="/mall/auction?m=auction1&id={$value.id|default:'null'}" >
								{elseif $value.type eq "1"}
								<a href="/mall/exchange?m=exchange1&id={$value.id|default:'null'}" >
								{/if}
									<div class="img-wrapper">
										<img src='{$value.pic|default:"{$base}templates/mall/img/1.jpg"}'>
										
									</div>
									<div class="crsl-info">
										<p class="name">{$value.name|default:'未命名'}</p>
										<p class="type">类型：{if $value.type eq "0"}
										热门竞价商品{elseif $value.type eq "1"}热门可兑换商品{else}未知{/if}</p>
									</div>
									
								</a>
							</li>
							{/foreach}
						{/if}
						</ul>
						<span id="carousel-right" class="arrow col-xs-1 col-xs-offset-1">&gt;</span>
					</div>
					<a href="/mall/exchange?m=list">
						<div id="entry1">
							<img src="{$base}mall/img/shop_cover.png" width="100%"/>
							<div>
								<p>
								<img src="{$base}mall/img/shop_logo.png"/> 网薪兑换商城
								</p>
							</div>
						</div>
					</a>
					<div>
						<div class="row" style="margin-left:0;margin-right:0;">
							<a href="/mall/auction?m=list"><div class="col-xs-6 padl" id="entry2">
								<img src="{$base}/mall/img/bid_cover.png" width="100%" />
								<p>
								<img src="{$base}/mall/img/bid_logo_white.png"/> 竞价商城
								</p>
							</div></a>
							<a href="/mall/earn"><div class="col-xs-6 padr" id="entry3">
								<img src="{$base}/mall/img/game_cover.png" width="100%" />
								<p>
								<img src="{$base}/mall/img/dice_logo_white.png"/> 小赚一把
								</p>
							</div></a>
						</div>
					</div>
				</div>
				
				{include file="mall/Footer.tpl"}
			</div>
		</div>

		{include file="mall/scriptTag.tpl"}
		<script src="{$base}mall/js/jquery.roundabout.min.js" type="text/javascript" charset="utf-8"></script>
		<script>
			$(document).ready(function() {
				$("#carousel").roundabout({
					responsive: true,
					maxScale: 0.55,
					minScale: 0.2,
					autoplay: false,
					clickToFocusCallback: onFocus,
					triggerFocusEvents: true,
					btnNext: $("#carousel-right"),
					btnPrev: $("#carousel-left"),
					btnNextCallback: onFocus,
					btnPrevCallback: onFocus,
					btnStopAutoplay: $(".arrow"),
					autoplayDuration: 2500
				},onFocus);

				function onFocus() {
					$("#carousel").find(".crsl-info").hide() /*.css("background-color", "transparent")*/;
					$("#carousel .roundabout-in-focus").find(".crsl-info").show()/*.css("background-color", "black")*/;
				}
			});
		</script>
	</body>
</html>