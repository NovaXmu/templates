<!-- 部落列表 -->
<!DOCTYPE html>
<meta charset="UTF-8">
<html lang=zh>
<head>
	<title>部落列表</title>
	{include file="meet/link.tpl"}
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
	<link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
	<link rel="stylesheet" href="{$base}meet/css/mask.css">
	<link rel="stylesheet" href="{$base}meet/css/messageBlock.css">
	<link rel="stylesheet" href="{$base}meet/css/blogLists.css">
</head>
<body>
	{include file="meet/Remodal.tpl"}
	<div class="remodal-bg">
			<div class="col-sm-8 col-sm-offset-2" id="main">
				<div id="top">
					<a href="/meet/person?m=index" target="_top" id="back">
						<span class="glyphicon glyphicon-chevron-left"></span>
						主页
					</a>
					<div id="title">部落列表</div>
					<span id="alt" title="创建">
						<span class="glyphicon glyphicon-plus" onclick="create();"></span>
				</div>
				<div id="content" class="clearfix">
					{include file="meet/MessageBlock.tpl"}
					<div id="board">
						<div class="tabs">
							<button type="button" class="tab-left {if $smarty.get.isMine != 1}active{/if}">部落列表</button>
							<button type="button" class="tab-right {if $smarty.get.isMine == 1}active{/if}">我加入的</button>
						</div>
						<div class="col-sm-12 establish" style="display: none;font-size:20px;">
							<h2>创建新部落</h2>
							<br/>
							<span>部落名</span>
							<input type="text" id="name"/>
							<br>
							<br>
							<span>简&#12288;介</span>
							<input type="text" id="introduction"/>
							<br>
							<br>
							<button type="button" class="submit" style="background-color: #238D98;color: white;">提交</button>
						</div>
						<div class="col-xs-12 bloglist">
							{foreach from=$list item=blog}
							<div id="{$blog['id']}" class="blog">
								<div class="info">
									<div class="part">
										<div class="iconfont icon-pageview" style="font-size:20px;">
											<span class="num">{$blog["count"]}</span>
										</div>
									</div>
									<div class="part">
										{if $blog['isHost'] eq 'true'}
										<img src="{$base}meet/img/crown.png" class="IfAdded">
										{elseif $blog['isJoined'] eq 'true'}
										<img src="{$base}meet/img/pink.png" class="Added">
										{else}
										<img src="{$base}meet/img/grey.png" class="noAdded">
										{/if}
										<span class="name">{$blog["name"]}</span>
										<p class="other">{$blog["introduction"]}</p>
									</div>
									<div class="part">
										<div class="part-img popMask" id="{$blog['user_ybid']}" data-t="{$blog['type']}" style="
										{if $blog['type'] eq '1'}
												background-image: url('{$base}meet/img/1.jpg');
										{/if}
										{if $blog['type'] eq '2'}
												background-image:url('http://img02.fs.yiban.cn/{$blog['user_ybid']}/avatar/user/200')
										{/if}"></div>
									</div>
								</div>
								<div class="banner">
									<button class="view" type="button" onclick="viewMember(this);">查看成员</button>
									<button class="view" type="button" 
							onclick="viewMessage('3',{$blog['id']});">查看消息</button>
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
	<script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
	<script src="{$base}meet/js/blogLists.js"></script>
	<script src="{$base}meet/js/mask.js"></script>
</body>
</html>