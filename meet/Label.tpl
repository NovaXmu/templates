<!-- 编辑名片 -->
<!DOCTYPE html>
<html lang=zh>
	<head>
		{include file="meet/link.tpl"}
		<title>编辑名片</title>
		<link rel="stylesheet" href="{$base}meet/css/label.css">
	</head>
	<body>
		
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				<div id="top">
					<a href="/meet/person?m=card" target="_top" id="back"><span class="glyphicon glyphicon-chevron-left"></span>我的名片</a>
					<div id="title">{$title}</div>
				</div>
				<div id="content" class="clearfix">
					<div class="labels" id="{$type}">
						<ul>
						{foreach from=$list item=label}
							<li id="{$label['id']}">
								<div class="picture">
									<img src="{$base}meet/img/label/{$label['id']}.png"/><br>
									<span>{$label['name']}</span>
								</div>
								{if $label['isSet'] eq 'true'}
								<div class="love set">
									<img src="{$base}meet/img/pink.png"/>						
								</div>
								{else}
								<div class="love">
									<img src="{$base}meet/img/love.png"/>						
								</div>
								{/if}
							</li>
						{/foreach}
						</ul>
					</div>
					<div class="save">保存并发布</div>
				</div>
			</div>

		{include file="meet/script.tpl"}
		<script src="{$base}meet/js/label.js"></script>		
	</body>
</html>