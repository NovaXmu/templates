{* 我的商城 *}
<!DOCTYPE html>
<html lang=zh>
	<head>
		<meta charset="utf-8">
		<title>我的商城</title>
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="{$base}mall/css/public.css">
		<link rel="stylesheet" href="{$base}mall/css/mine.css?v=1.01">
		<link rel="stylesheet" href="{$base}mall/css/list.css" />
		{include file="mall/styleTag.tpl"}
	</head>
	<body class="mine">
		
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				{include file="mall/Header.tpl"}
				<div id="content">
					{* 导航 *}
					<div id="nav" class="row">
						<div class="col-xs-4 active">我的兑换</div>
						<div class="col-xs-4">我的竞价</div>
						<div class="col-xs-4">小赚一把</div>
					</div>
					<div id="main">
						{if {$data|@count}==0}
						<ul>
							<li class="part item message">
								<div>
									你还没有任何兑换记录哦，再去逛逛吧~
								</div>
							</li>
							<li class="part item message">
								<div>
									你还没有任何竞价记录哦，再去逛逛吧~
								</div>
							</li>
							<li class="part item message">
								<div>
									{* 我的网薪小游戏 *}
								</div>
							</li>
						</ul>
						{else} 
						<ul>
							<li class="part">
								<div>
									{* 我的兑换 *}
									<p style="margin-top:10px;">兑换须知：请在成功兑换后七天内，到思明校区学生事务大厅领取（翔安校区可提前预约），逾期不候。</p>
									{if {$data['exchange']|@count}==0}
									<div class="item message row">你还没有任何兑换记录哦，再去逛逛吧~</div>
									{else}
									{foreach $data['exchange'] as $item}
									<div class="item row">
										<div class="col-xs-4 pic"><img src='{$item.info.pic|default:"{$base}templates/mall/img/1.jpg"}' class="pic" alt="商品图片"></div>
										<div class="col-xs-8 desc">
											<p class="item-id" style="display:none;">{$item.info.id}</p>
											<p>礼品名称: {$item.info.name|default:"未命名"}</p>
											<p>兑换价格：{$item.info.price|default:"未知"}</p>
											<p>兑换密钥: {$item.token|mb_substr:0:4:'utf-8'|default:"未知"}&nbsp;{$item.token|mb_substr:4:4:'utf-8'}&nbsp;{$item.token|mb_substr:8:4:'utf-8'}</p>
											<p>是否已兑换：{if $item.isUsed == '0'}是{elseif $item.isUsed == '1'}否{else}未知{/if}</p>
											<p>过期时间：{$item.itemTokenExpires}</p>
										</div>
									</div>
									{/foreach}
									{/if}
									
								</div>
							</li>
							<li class="part">
								<div>
									{* 我的竞价 *}
									{if {$data['auction']|@count}==0}
									<div class="item message row">你还没有任何竞价记录哦，再去逛逛吧~</div>
									{else}
									{foreach $data['auction'] as $item}
									<div class="item row">
										<div class="col-xs-4 pic"><img src='{$item.info.pic|default:"{$base}templates/mall/img/1.jpg"}' class="pic" alt="商品图片"></div><!--放图片-->
										<div class="col-xs-8 desc">
											<p class="item-id" style="display:none;">{$item.info.id}</p>
											<p>礼品名称: {$item.info.name|default:"未命名"}</p>
											<p>我的出价：{$item.price|default:"未知"}&nbsp;&nbsp;&nbsp;&nbsp;<a href="auction?m=auction1&id={$item.info.id}" style="color:rgb(51, 153, 204);">再次出价&gt;&gt;</a></p>
											<p>最高出价：{$item.info.price|default:"未知"}</p>
											<p>截止时间：{$item.info.endTime|default:"未知"}</p>
											<p>竞价结果：</p>
											<div id="auction-result">
												{if $item.info.isOverdued == 0}
												{* 进行中 *}
												<span style="color: rgb(255, 244, 44);font-weight:bold;">竞价仍在进行中...</span>
												{else}
												{* 已结束 *}
													{if $item.token == null}
													{* 空手而归 *}
													<span style="color: rgb(0, 140, 140);font-weight:bold;">抱歉，本次竞价空手而归，去其他地方逛逛吧</span>
													{elseif $item.token == "Token Wrong"}
													{* 无法支付最高价 *}
													<span style="color: rgb(0, 140, 140);font-weight:bold;">抱歉，虽然您竞得最高价，但余额不足</span>
													{else}
													<span style="color:rgb(250, 135, 155);font-weight:bold;">恭喜你，赢得本次竞价！请凭以下流水号 <span class="token" style="font-size:130%;color:rgb(51, 153, 204)">{$item.token|mb_substr:0:4:'utf-8'}&nbsp;{$item.token|mb_substr:4:4:'utf-8'}&nbsp;{$item.token|mb_substr:8:4:'utf-8'}</span> 前往学生事务大厅领取</span>
													<p>过期时间：{$item.itemTokenExpires}</p>
													{/if}
												{/if}
											</div>
										</div>
									</div>
									{/foreach} 
									{/if}
									
								</div>
							</li>
							<li class="part">
								<div>
									{* 我的网薪小游戏 *}
									{if {$totalAward|@count}==0}
									<div class="item message row">你还没有任何游戏记录哦，再去耍耍吧~</div>
									{else}
									{foreach $totalAward as $gameName=>$value}
									{if $gameName == 'bobing'}
									<div class="item row">
										<div class="col-xs-4 pic"><a href="/mall/earn?m=bobing"><img src="{$base}mall/img/bobing-logo.png" class="pic" alt="博饼图标"></a></div><!--放图片-->
										<div class="col-xs-8 desc">
											<p class="game-name" style="font-size:130%;">博饼赚网薪</p>
											<p>我赚到了{$value}网薪</p>
											<a href="" style="color:rgb(51, 153, 204)" class="showLogBtn">我的博饼记录&gt;&gt;</a>
										</div>
										<table class="table" style="display: none;">
											<thead>
												<tr>
													<th>#</th>
													<th>时间</th>
													<th>点数</th>
													<th>网薪</th>
												</tr>
											</thead>
											<tbody>
												{foreach $log['bobing'] as $thisLog}
												<tr>
													<th scope="row">{$thisLog@key + 1}</th>
													<td>{$thisLog.time}</td>
													<td>{$thisLog.randNum}</td>
													<td>{$thisLog.award}</td>
												</tr>
												{/foreach}
												
											</tbody>
										</table>
									</div>
									{/if}
									{if $gameName == 'game2048'}
									<div class="item row">
										<div class="col-xs-4 pic"><a href="/mall/earn?m=game2048"><img src="{$base}mall/img/game2048.png" class="pic" alt="2048图标"></a></div><!--放图片-->
										<div class="col-xs-8 desc">
											<p class="game-name" style="font-size:130%;">2048</p>
											<p>我赚到了{$value}网薪</p>
											<a href="" style="color:rgb(51, 153, 204)" class="showLogBtn">我的2048记录&gt;&gt;</a>
										</div>
										<table class="table" style="display: none;">
											<thead>
												<tr>
													<th>#</th>
													<th>时间</th>
													<th>分数</th>
													<th>网薪</th>
												</tr>
											</thead>
											<tbody>
												{foreach $log['game2048'] as $thisLog}
												<tr>
													<th scope="row">{$thisLog@key + 1}</th>
													<td>{$thisLog.time}</td>
													<td>{$thisLog.randNum}</td>
													<td>{$thisLog.award}</td>
												</tr>
												{/foreach}
												
											</tbody>
										</table>
									</div>
									{/if}
									{/foreach}
									{/if}
								</div>
							</li>
						</ul>
						{/if}
					</div>
				</div>
				
				{include file="mall/Footer.tpl"}
			</div>
		</div>

		{include file="mall/scriptTag.tpl"}
		<!-- Loading GreenSock JS -->
		<script type="text/javascript" src="{$base}mall/js/greensock/TweenMax.min.js"></script>
		<script type="text/javascript" src="{$base}mall/js/greensock/TweenLite.min.js"></script>
		<script type="text/javascript" src="{$base}mall/js/greensock/TimelineLite.min.js"></script>
		<script type="text/javascript" src="{$base}mall/js/greensock/Draggable.min.js"></script>
		<script type="text/javascript" src="{$base}mall/js/greensock/plugins/CSSPlugin.min.js"></script>
		<script src="{$base}mall/js/mine.js?v=1.01" type="text/javascript" charset="utf-8"></script>
	</body>
</html>