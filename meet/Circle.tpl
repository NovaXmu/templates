<!-- 圈子 -->
<!DOCTYPE html>
<html lang=zh>
<head>
	{include file="meet/link.tpl"}
	<title>圈子</title>
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
	<link rel="stylesheet" href="{$base}meet/css/circle.css">
	<link rel="stylesheet" href="{$base}meet/css/messageBlock.css">
	<link rel="stylesheet" href="{$base}meet/css/mask.css"></head>
<body>
{include file="meet/Remodal.tpl"}
	<div class="remodal-bg">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				<div id="top">
					<a href="/meet/person?m=index" id="back">
						<span class="glyphicon glyphicon-chevron-left"></span>
						主页
					</a>

					<div id="title">圈子</div>
				</div>
				<div id="content" class="clearfix">
					{include file="meet/MessageBlock.tpl"}
					<div id="board">
						<div class="row">
							{if isset($list[0])}
							<div class="stamp col-xs-4 col-xs-offset-1" id="m1" data-rate="{$list[0]['rate']}">
								<canvas class="canvas"></canvas>
								<img src="http://img02.fs.yiban.cn/{$list[0]['ybid']}/avatar/user/200" id="{$list[0]['ybid']}">

								<p class="name">{$list[0]['nickname']}</p>
							</div>
							{/if}
							    {if isset($list[1])}
							<div class="stamp col-xs-4 col-xs-offset-2" id="m2" data-rate="{$list[1]['rate']}">
								<canvas class="canvas"></canvas>
								<img src="http://img02.fs.yiban.cn/{$list[1]['ybid']}/avatar/user/200" id="{$list[1]['ybid']}">

								<p class="name">{$list[1]['nickname']}</p>
							</div>
							{/if}
						</div>
						<div class="row">
							{if isset($list[2])}
							<div class="stamp col-xs-4 col-xs-offset-4" id="me" data-rate="{$list[2]['rate']}">
								<canvas class="canvas"></canvas>
								<img src="http://img02.fs.yiban.cn/{$list[2]['ybid']}/avatar/user/200" id="{$list[2]['ybid']}">

								<p class="name">{$list[2]['nickname']}</p>
							</div>
							{/if}
						</div>
						<div class="row">
							{if isset($list[3])}
							<div class="stamp col-xs-4 col-xs-offset-1" id="m3" data-rate="{$list[3]['rate']}">
								<canvas class="canvas"></canvas>
								<img src="http://img02.fs.yiban.cn/{$list[3]['ybid']}/avatar/user/200" id="{$list[3]['ybid']}">

								<p class="name">{$list[3]['nickname']}</p>
							</div>
							{/if}
								{if isset($list[4])}
							<div class="stamp col-xs-4 col-xs-offset-3" id="m4" data-rate="{$list[4]['rate']}">
								<canvas class="canvas"></canvas>
								<img src="http://img02.fs.yiban.cn/{$list[4]['ybid']}/avatar/user/200" id="{$list[4]['ybid']}">

								<p class="name">{$list[4]['nickname']}</p>
							</div>
							{/if}
						</div>
					<p id="slogan">世界上另一个你</p>

					<p id="inst">点击头像查看名片</p>
				</div>
			</div>
			{include file="meet/footer.tpl"}
		</div>
</div>
{include file="meet/script.tpl"}
<script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
<script src="{$base}meet/js/circle.js"></script>
<script src="{$base}meet/js/mask.js"></script>
</body>
</html>