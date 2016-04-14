<!DOCTYPE html>
<html lang=zh>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta charset="utf-8">
		<title>竞价商品列表</title>
		{include file="mall/styleTag.tpl"}
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="{$base}mall/css/public.css?v=1.0.1">
		<link rel="stylesheet" href="{$base}mall/css/list.css" />
	</head>
	<body class="auction">
		
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				{include file="mall/Header.tpl"}
				<div id="content" class="container-fluid">
					<p style="display: none;" class="not-xmu">抱歉，您所在的学校目前暂时没有上架商品，你可以<a href="" onclick="showXmuItems(event)">去厦门大学的商城看看</a></p>
					{if is_array($list)}
					{foreach $list as $value}
					<div class="item row">
						<div class="col-xs-4 pic"><img src='{$value.pic|default:"{$base}templates/mall/img/1.jpg"}' class="pic" alt="商品图片"></div><!--放图片-->
						<div class="col-xs-8 desc">
							<p class="item-id" style="display:none;">{$value.id|default:'null'}</p>
							<p>礼品名称: {$value.name|default:'未命名'}</p>
							<p>当前竞价：{$value.price|default:'未知价格'}</p>
							<p>剩余数量：{$value.remainAmount|default:'未知价格'}</p>
							<p><a onclick="toggleCondition()" class="toggleCond">限制条件>></a>
								<p style="display:none;" class="condition"> 
									经验：
								{if array_key_exists("jy",$value.limitConds)}
									{if $value.limitConds["jy"] > 0}
									大于{$value.limitConds["jy"]}
									{elseif $value.limitConds["jy"] < 0}
									小于{-$value.limitConds["jy"]}
									{elseif $value.limitConds["jy"] == "" ||  $value.limitConds["jy"] == 0}
									无限制
									{/if}
								{else}
									无限制
								{/if}
								<br>
								性别：
								{if array_key_exists("sex",$value.limitConds)}
									{if $value.limitConds["sex"] == "M"}
									男
									{elseif $value.limitConds["sex"] == "F"}
									女
									{else}
									无限制
									{/if}
								{else}
									无限制
								{/if}
								<br>
								注册时间：
								{if array_key_exists("registTime",$value.limitConds)}
									{if $value.limitConds["registTime"] > 0}
									晚于{$value.limitConds["registTime"]|date_format:'%Y-%m-%d %H:%M:%S'}
									{elseif $value.limitConds["registTime"] < 0}
									早于{abs($value.limitConds["registTime"])|date_format:'%Y-%m-%d %H:%M:%S'}
									
									{elseif $value.limitConds["registTime"] == "" ||  $value.limitConds["registTime"] == 0}
									无限制
									{/if}
								{else}
									无限制
								{/if}
								<br>
								每人限购：
								{if array_key_exists("amountLimit",$value.limitConds)}
									{if $value.limitConds["amountLimit"] == ""||$value.limitConds["amountLimit"] == 0}
									无限制
									{else}
									{$value.limitConds["amountLimit"]}
									{/if}
								{else}
									无限制
								{/if}</p>
							</p>
							<div class="row">
								<div>
									<a href="" class="toggleDt"><span>礼品详情>></span></a>
									<br/>
									<div class="detail" style="display:none;">{$value.description|default:'无'}</div>
								</div>
								
								<div class="col-xs-6 col-xs-offset-6">
									<a href="auction?m=auction1&id={$value.id|default:'null'}"><img src="" class="auctionBtn"/></a>
								</div>
							</div>
						</div>
						<!-- 不同页面的具体内容 -->
					</div>
					{/foreach}
				{/if}
					{include file="mall/Footer.tpl"}
				</div>
			</div>
		</div>
		{include file="mall/scriptTag.tpl"}
		<script src="{$base}mall/js/auctionlist.js"></script>
	</body>
</html>