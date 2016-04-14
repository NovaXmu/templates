<!DOCTYPE html>
<html lang=zh>
	<head>
		<meta charset="utf-8">
		<title>兑换页面</title>
		{include file="mall/styleTag.tpl"}
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="{$base}mall/css/public.css">
		<link rel="stylesheet" href="{$base}mall/css/index.css">
		<link rel="stylesheet" href="{$base}mall/css/exchange.css">
	</head>
	<body class="exchange">
		
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				{include file="mall/Header.tpl"}
				<div id="content">
					<div class="bg">
						<div class="row" align="center" style="width:100%;">
							<div class="col-xs-6 padl" align="center" style="margin-top:3%;">
								<img src='{$detail.pic|default: "{$base}templates/mall/img/1.jpg"}' width="80%">
							</div>
							<div class="col-xs-6 padr" style="margin-top:3%;">
								{* 确认兑换 *}
								<div id="confirm-div">
									<p id="id" style="display:none;">{$detail.id|default:'null'}</p>
									<p id="cent" style="line-height:200%;font-weight:700px;">
									该商品将花费您<br>
									<a style="color:yellow;font-size:200%;">{$detail.price|default:'未知价格'}&nbsp;</a>网薪<br>
									确定兑换吗？<br>
									<div class="row">
										<input type="button" value="确定" id="confirmBtn" style="background-color:#ffda0e;"/>
										<input type="button" value="取消" onclick="javascript:window.location.href='exchange?m=list'" style="background-color:#3e90ad;"/>
									</div>
									</p>
								</div>
								{* 隐藏，兑换成功后ajax动态显示 *}
								<div id="success-div" style="display:none;">
									<h3 class="msg" style="color:rgb(250, 135, 155);font-weight:bold;">恭喜你！</h3>
									<p>获得左图商品</p>
									<p>请凭如下流水号</p>
									<p class="token" style="color: rgb(0, 140, 140);font-weight:bold;"></p>
									<p>前往学生事务大厅领取</p>
								</div>
								{* 隐藏，兑换失败后ajax动态显示 *}
								<div id="fail-div" style="display:none;">
									<h3 class="msg" style="color: rgb(0, 140, 140);font-weight:bold;">抱歉</h3>
									<p id="errmsg"></p>
									<p>可以前往小赚一把试试手气</p>
								</div>
							</div>
						</div>
						<p style="margin-left:5%;">继续逛逛&gt;&gt;</p>
						<div class="row" style="margin-left:0;margin-right:0;">
							<a href="/mall/auction?m=list"><div class="col-xs-6 padl"  align="center" id="bot1">
								<img src="{$base}mall/img/bid_cover.png" width=80% />
								<p>
								竞价商城
								</p>
							</div></a>
							<a href="/mall/earn"><div class="col-xs-6 padr" align="center" id="bot2">
								<img src="{$base}mall/img/game_cover.png" width="80%" />
								<p>
								小赚一把
								</p>
							</div></a>
						</div>
					</div>
				</div>
				{include file="mall/Footer.tpl"}
			</div>
		</div>

		{include file="mall/scriptTag.tpl"}
		<script src="{$base}mall/js/exchange.js"></script>
	</body>
</html>