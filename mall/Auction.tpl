<!DOCTYPE html>
<html lang=zh>
	<head>
		<meta charset="utf-8">
		<title>竞价页面</title>
		{include file="mall/styleTag.tpl"}
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="{$base}mall/css/public.css">
		<link rel="stylesheet" href="{$base}mall/css/index.css">
		<link rel="stylesheet" href="{$base}mall/css/auction.css">
	</head>
	<body class="auction">
		
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				{include file="mall/Header.tpl"}
				<div id="content">
					<div class="bg">
						<div class="row" align="center" style="width:100%;">
							<div class="col-xs-6 padl" align="center" style="margin-top:3%;">
								<img src='{$detail.pic|default:"{$base}templates/mall/img/1.jpg"}' width="80%">
							</div>
							<div class="col-xs-6 padr" style="margin-top:3%;">
								<!-- 确认兑换 -->
								<div id="choose-div">
									<p id="id" style="display:none;">{$detail.id|default:'null'}</p>
									<p>您选择的竞价商品：{$detail.name|default:'未命名'}</p>
									
									<p>
									当前竞价: <span>{$detail.price|default:'未知价格'}&nbsp;</span>网薪
									</p>
									<p>
										开始时间：{$detail.startTime|default:'未知'}
									</p>
									<p>
									截止时间：{$detail.endTime|default:'未知'}
									</p>
									请选择加价幅度：<br>
									<div id="add">
										<div class="row">
											<div class="col-xs-3 ab" amount="10" id="add10" style="background-color:rgba(254, 203, 0, 1)">+10</div>
											<div class="col-xs-3 col-xs-offset-1 ab" amount="50" id="add50" style="background-color:rgba(234, 97, 0, 1)">+50</div>
											<div class="col-xs-3 col-xs-offset-1 ab" amount="100" id="add100" style="background-color:rgba(234, 104, 119, 1)">+100</div>
										</div>
										<div class="row">
											<div class="col-xs-3 ab" amount="200" id="add200" style="background-color:rgba(102, 254, 254, 1)">+200</div>
											<div class="col-xs-3 col-xs-offset-1 ab" amount="500" id="add500" style="background-color:rgba(0, 152, 254, 1)">+500</div>
											<div class="col-xs-3 col-xs-offset-1 ab" amount="1000" id="add1000" style="background-color:rgba(173, 93, 160, 1)">+1000</div>
										</div>
									</div>
									<div class="row">
										<input type="button" value="出价" class="col-xs-4 col-xs-offset-4" id="submitBtn" style="background-color:rgba(119, 119, 119, 1);text-align:center;border:none;"/>
									</div>
								</div>
								<!-- 隐藏，兑换成功后ajax动态显示 -->
								<div id="success-div" style="display:none;">
									<h3 class="msg" style="color:rgb(250, 135, 155);font-weight:bold;">恭喜你！</h3>
									<p>竞价成功</p>
									<p>截止时间：{$detail.endTime|default:'未知'}</p>
									
									<p>点击头像进入"我的商城"随时关注竞价结果</p>
								</div>
								<!-- 隐藏，兑换失败后ajax动态显示 -->
								<div id="fail-div" style="display:none;">
									<h3 class="msg" style="color: rgb(0, 140, 140);font-weight:bold;">抱歉</h3>
									<p>你竞价的物品：{$detail.name|default:'未命名'}</p>
									<p id="errmsg"></p>
									<p>请选择其他商品竞价或继续逛逛</p>
								</div>
							</div>
						</div>
						<p style="margin-left:5%;">继续逛逛&gt;&gt;</p>
						<div class="row" style="margin-left:0;margin-right:0;">
							<a href="/mall/exchange?m=list"><div class="col-xs-6 padl"  align="center" id="bot1">
								<img src="{$base}mall/img/shop_cover_narrow.png" width=80% />
								<p>
								网薪商城
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
		<script src="{$base}mall/js/auction.js"></script>
	</body>
</html>