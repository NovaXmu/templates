<!-- 消息记录 -->
<!DOCTYPE html>
<html lang=zh>
<head>
	{include file="meet/link.tpl"}
	<title>消息记录</title>
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
	<link rel="stylesheet" href="{$base}meet/css/messageMenu.css">
	<link rel="stylesheet" href="{$base}meet/css/mask.css">
	<link rel="stylesheet" href="{$base}meet/css/messageBlock.css">
</head>
<body>
{include file="meet/Remodal.tpl"}
	<div class="remodal-bg">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				<div id="top">
					<a href="/meet/person?m=index" target="_top" id="back">
						<span class="glyphicon glyphicon-chevron-left"></span>
						主页
					</a>
					<div id="title">消息记录</div>
				</div>
				<div id="content" class="clearfix">
					{include file="meet/MessageBlock.tpl"}
					<div id="board">
					<!--消息记录-->
					<div class="messageMenu col-xs-12">
					<div class="enterMessage col-xs-12 toDetails" id="5">
							<div class="messageName col-xs-12">
								<div class="col-xs-9 col-xs-offset-3 name">
									<span>话题</span>
								</div>
							</div>
							<div class="face" style="background-image:url('{$base}meet/img/topic.png')"></div>
							<div class="col-xs-12 messageCount">
								<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">
								{if $list['topic'] eq 0}
								<p><span class="count" style="display:none">0</span>没有消息</p>
								{else}
								<p>有<span class="count">{$list['topic']}</span>条消息未读</p>
								{/if}								
								</div>
							</div>
						</div>
						<div class="enterMessage col-xs-12 toDetails" id="4">
							<div class="messageName col-xs-12">
								<div class="col-xs-9 col-xs-offset-3 name">
									<span>pk</span>
								</div>
							</div>
							<div class="face" style="background-image:url('{$base}meet/img/pk.png')"></div>
							<div class="col-xs-12 messageCount">
								<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">
								{if $list['pk'] eq 0}
								<p><span class="count" style="display:none">0</span>没有消息</p>
								{else}
								<p>有<span class="count">{$list['pk']}</span>条消息未读</p>
								{/if}	
								</div>
							</div>
						</div>
					{foreach from=$list['friend'] item=friend}
						<div class="enterMessage col-xs-12 toMessage">
							<div class="messageName col-xs-12">
								<div class="col-xs-9 col-xs-offset-3 name">
									<span>{$friend['nickname']}</span>
								</div>
							</div>
							<div class="face popMask" id="{$friend['user_ybid']}" style="background-image:url('http://img02.fs.yiban.cn/{$friend['user_ybid']}/avatar/user/200')"></div>
							<div class="col-xs-12 messageCount">
								<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">
								{if $friend['count'] eq 0}
								<p><span class="count" style="display:none">0</span>没有消息</p>
								{else}
								<p>有<span class="count">{$friend['count']}</span>条消息未读</p>
								{/if}	
								</div>
							</div>
						</div>
				    {/foreach}
					</div>
				</div>
				</div>

				{include file="meet/footer.tpl"}
			</div>
	</div>
	{include file="meet/script.tpl"}
	<script src="{$base}meet/js/messageMenu.js"></script>
	<script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
	<script src="{$base}meet/js/mask.js"></script>
</body>
</html>