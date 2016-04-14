<!-- 话题榜 -->
<!DOCTYPE html>
<html lang=zh>
<head>
	{include file="meet/link.tpl"}
	<title>话题榜</title>
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
	<link rel="stylesheet" href="{$base}meet/css/comment.css">
	<link rel="stylesheet" href="{$base}meet/css/mask.css">
	<link rel="stylesheet" href="{$base}meet/css/messageBlock.css">
	<link rel="stylesheet" href="{$base}meet/css/topicLists.css">
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
					<div id="title">话题榜</div>
				</div>
				<div id="content" class="clearfix">
					{include file="meet/MessageBlock.tpl"}
					<div id="board">
					<div class="tabs">
						<button type="button" class="tab-left active">话题榜</button>
						<button type="button" class="tab-right">发话题</button>
					</div>
					<!--发话题-->
					<div class="topicLaunch" style="display:none">
						<div class="col-xs-12 topicInfo">
							<div class="col-xs-12" id="name">
								<span>话题名称</span>
								<input type="text" name="topicName"/>
							</div>
							<div class="col-xs-12" id="introduction">
								<span>话题内容</span>
								<textarea id="topicContent"></textarea>
							</div>
						</div>
						<div class="col-xs-12 launch">发布</div>
					</div>

					<!--话题榜-->
					{foreach from=$hot item=hotTopic}
					<div class="topic" id="{$hotTopic['id']}">
						<div class="enterTopic col-xs-12">
							<div class="topicName col-xs-12" onclick="topicClick(event,this)">
								<div class="col-xs-9 col-xs-offset-3 name">
									<span>{$hotTopic['title']}</span>
								</div>
								<div class="col-xs-9 col-xs-offset-3 time">
									<span>{$hotTopic['time']}</span>
								</div>
							</div>
							<div class="face popMask" id="{$hotTopic['user_ybid']}" style="background-image:url('http://img02.fs.yiban.cn/{$hotTopic['user_ybid']}/avatar/user/200')"></div>
							<div class="col-xs-12 topicContent">
								<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">
									<p>{$hotTopic['content']}</p>
									<div style="float:right;">
										{if $hotTopic['isPraised'] eq 'true'}
										<img src="{$base}meet/img/quxiaozan.png" class="dianzan great"
							    onmousedown="praise(this,1,{$hotTopic['id']});" />
										{else}
										<img src="{$base}meet/img/dianzan.png" class="dianzan"
								onmousedown="praise(this,1,{$hotTopic['id']});" />
										{/if}
										<span style="font-size:15px;">{$hotTopic['praiseCount']}</span>

										<img src="{$base}meet/img/pinglun.png" style="margin-left:15px;" onclick="pinglunClick(this)">
										<span style="font-size:15px;">{$hotTopic['commentCount']}</span>
									</div>
								</div>

							</div>
						</div>
						<div class="forbidEnter col-xs-12">
							<textarea id="COMMENT" class="commentInput" onfocus="focusTextarea(this)" onblur="blurTextarea(this)" placeholder="我也说一句"></textarea>
							<button type="button" class="btn-comment" 
						onmousedown="comment(this,{$hotTopic['id']},{$hotTopic['user_ybid']})"
						style="display:none">发送</button>
						</div>
					</div>
					{/foreach}

				{foreach from=$list item=topic}
					<div class="topic" id="{$topic['id']}">
						<div class="enterTopic col-xs-12">
							<div class="topicName col-xs-12" onclick="topicClick(event,this)">
								<div class="col-xs-9 col-xs-offset-3 name">
									<span>{$topic['title']}</span>
								</div>
								<div class="col-xs-9 col-xs-offset-3 time">
									<span>{$topic['time']}</span>
								</div>
							</div>
							<div class="face popMask" id="{$topic['user_ybid']}" style="background-image:url('http://img02.fs.yiban.cn/{$topic['user_ybid']}/avatar/user/200')"></div>
							<div class="col-xs-12 topicContent">
								<div class="col-xs-9 col-xs-offset-3" style="padding-top:10px;">
									<p>{$topic['content']}</p>
									<div style="float:right;">
										{if $topic['isPraised'] eq 'true'}
										<img src="{$base}meet/img/quxiaozan.png" class="dianzan great" onclick="praise(this,1,{$topic['id']})"/>
										{else}
										<img src="{$base}meet/img/dianzan.png" class="dianzan" 
								onclick="praise(this,1,{$topic['id']})"/>
										{/if}
										<span style="font-size:15px;">{$topic['praiseCount']}</span>

										<img src="{$base}meet/img/pinglun.png" style="margin-left:15px;" onclick="pinglunClick(this)">
										<span style="font-size:15px;">{$topic['commentCount']}</span>
									</div>
								</div>

							</div>
						</div>
						<div class="forbidEnter col-xs-12">
							<textarea id="COMMENT" class="commentInput" onfocus="focusTextarea(this)" onblur="blurTextarea(this)" placeholder="我也说一句"></textarea>
							<button type="button" class="btn-comment" 
					onmousedown="comment(this,{$topic['id']},{$topic['user_ybid']})"
					style="display:none">发送</button>
						</div>
					</div>
					{/foreach}
					<button type="button" id="moreTopic">更多话题</button>
				</div>
			</div>
				{include file="meet/footer.tpl"}
			</div>
	</div>
	{include file="meet/script.tpl"}
	<script src="{$base}meet/js/topicLists.js"></script>
	<script src="{$base}meet/js/comment.js"></script>
	<script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
	<script src="{$base}meet/js/mask.js"></script>
</body>
</html>