<!-- 话题|pk消息 -->
<!DOCTYPE html>
<html lang=zh>
<head>
	{include file="meet/link.tpl"}
	<title>消息</title>
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
	<link rel="stylesheet" href="{$base}meet/css/messageDetails.css">
	<link rel="stylesheet" href="{$base}meet/css/comment.css">
	<link rel="stylesheet" href="{$base}meet/css/mask.css">
	<link rel="stylesheet" href="{$base}meet/css/messageBlock.css">
</head>
<body>
{include file="meet/Remodal.tpl"}
	<div class="remodal-bg">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				<div id="top">
					<a href="/meet/message?m=index" target="_top" id="back">
						<span class="glyphicon glyphicon-chevron-left"></span>
						消息记录
					</a>
					<div id="title">{$title}</div>
				</div>
				<div id="content" class="clearfix">
					{include file="meet/MessageBlock.tpl"}
					<div id="board">
						{foreach from=$list item=record}
						<div class="recordMenu col-xs-12">
							<div class="record col-xs-12">
								<div class="recordName col-xs-12" onclick="{if $type eq '5'}viewTopic(this){/if}">
									<div class="col-xs-9 col-xs-offset-3 name">
										<span id="{$record['topic_id']}">{$record['title']}</span>
									</div>
									<div class="col-xs-9 col-xs-offset-3 time">
										<span>{$record['time']}</span>
									</div>
								</div>
								<div class="face popMask" id="{$record['from_user_ybid']}" style="background-image:url('http://img02.fs.yiban.cn/{$record['from_user_ybid']}/avatar/user/200')"></div>
								<div class="col-xs-12 recordContent">
									<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">
										<p>{$record['content']}</p>
									</div>
								</div>
							</div>
							{if $type eq '5'}
							<div class="col-xs-12 recordReply">
								<textarea id="COMMENT" class="commentInput" onfocus="focusTextarea(this)" onblur="blurTextarea(this)" placeholder="回复"></textarea>
								<button type="button" class="btn-comment" onmousedown="comment(this,{$record['topic_id']},{$record['from_user_ybid']},{$record['comment_id']})"
							style="display:none">发送</button>
							</div>
							{/if}
						</div>
						{/foreach}
						<button type="button" class="moreRecords" id="{$type}">更多消息</button>
					</div>
				</div>
			</div>
	</div>
	{include file="meet/script.tpl"}
	<script src="{$base}meet/js/messageDetails.js"></script>
	<script src="{$base}meet/js/comment.js"></script>
	<script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
	<script src="{$base}meet/js/mask.js"></script>
</body>
</html>