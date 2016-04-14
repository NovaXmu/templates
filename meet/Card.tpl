<!-- 我的名片 -->
<!DOCTYPE html>
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>我的名片</title>
	<link rel="stylesheet" href="{$base}meet/css/card.css">
</head>
<body>
		<div class="col-sm-8 col-sm-offset-2 centered" id="main">
			<div id="top">
				<a href="/meet/person?m=index{if $isMe neq 'true'}&user_ybid='{$info['user_ybid']}'{/if} " target="_top" id="back">
					<span class="glyphicon glyphicon-chevron-left"></span>
					主页
				</a>
				<div id="title">{if $isMe eq 'true'}我{else}{$info['nickname']}{/if}的名片</div>
			</div>
			<div id="content" class="clearfix">

					<div id="list">
						<ul>
						{foreach from=$list key=key item=card}
							<li class="act" data-type="{$card['type']}">
								<div class="top">
									<span>{if $isMe eq 'true'}我{else}{$info['nickname']}{/if}爱的{$card['title']}</span>
									{if $isMe eq 'true'}<p>把你最爱的{$card['title']}和大家分享吧</p>{/if}
								</div>
								<div class="card">
									<div class="info">
										{foreach from=$card['list'] item=label}
										<label id="{$label['id']}">{$label['name']}</label>
										{/foreach}
									</div>
									{if $isMe eq 'true'}
									<div class="bottom">更新资料</div>
									{/if}</div>
							</li>
						{/foreach}
						</ul>
					</div>
					<p id="d" style="clear: both">左右滑动查看更多个人信息</p>
				</div>

		</div>

	{include file="meet/script.tpl"}
	<script src="{$base}meet/js/hammer.min.js"></script>
	<script src="{$base}meet/js/slideshow.js"></script>
	<script src="{$base}meet/js/card.js"></script>
</body>
</html>