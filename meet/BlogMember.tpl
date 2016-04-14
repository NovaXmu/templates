<!-- 部落成员 -->
<!DOCTYPE html>
<html lang=zh>
<head>
	{include file="meet/link.tpl"}
	<title>部落成员</title>
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
	<link rel="stylesheet" href="{$base}meet/css/blogMember.css">
	<link rel="stylesheet" href="{$base}meet/css/messageBlock.css">
	<link rel="stylesheet" href="{$base}meet/css/mask.css">
</head>
<body>
{include file="meet/Remodal.tpl"}
	<div class="remodal-bg">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				<div id="top">
					<a href="/meet/blog?m=blog" target="_top" 
					id="back">
						<span class="glyphicon glyphicon-chevron-left"></span>
						部落列表
					</a>

					<div id="title">{$title}</div>
					<span id="alt">部落成员</span>
				</div>
				<div id="content" class="clearfix">
					{include file="meet/MessageBlock.tpl"}
					<div id="board">
						<div class="row">
							{foreach from=$list item=member}
							<div class="col-xs-6 member" style="text-align:center;margin-bottom:10px;" id="{$member['user_ybid']}">
								<img class="wrap popMask" id="{$member['user_ybid']}" src="http://img02.fs.yiban.cn/{$member['user_ybid']}/avatar/user/200" >
								<br>
								<span class="nickname">{$member["nickname"]}</span>
								<br>
								<span>{$member['point']}分</span>
							</div>
							{/foreach}
						</div>
					</div>
				</div>

			</div>
	</div>
	{include file="meet/script.tpl"}
	<script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
	<script src="{$base}meet/js/mask.js"></script>

</body>
</html>