<!DOCTYPE html>
<meta charset="UTF-8">
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>活动成员</title>
    <link rel="stylesheet" href="{$base}meet/css/activityMember.css">
    <link rel="stylesheet" href="{$base}meet/css/message.css">
<body>
<div class="activity" id="{$activity_id}">
    <div class="col-sm-8 col-sm-offset-2 centered" id="main">
        <div id="top">
            <a href="/meet/blog?m=activity&blog_id={$blog_id}" target="_top" id="back">
                <span class="glyphicon glyphicon-chevron-left"></span>
                部落
            </a>

            <div id="title">{$title}</div>
        </div>
        <div id="content" class="clearfix">
            {include file="meet/MessageBlock.tpl"}
            <div id="listBlock">
                <div class="" id="nameList">
                    <!-- <a style="font-size:15px;" class="return">收起</a><br>
                     <canvas id="returnLine" width="100" height="30";></canvas><br>-->
                    <h2>当前参与人数：{$list|count}</h2>

                    <div>
                        {foreach from=$list item=member}
                            <p id="{$member['user_ybid']}">
                                <span>{$member['nickname']}</span>
                                {if $member['user_ybid'] neq $user}
                                    <button class="btn-letter"
                                            onclick="switchMessage('{$member['nickname']}',1,{$member['user_ybid']})">私信
                                    </button>
                                {/if}
                            </p>
                        {/foreach}
                    </div>
                </div>
                <div class="enter"
                     onclick="switchMessage('{$title}',2,{$activity_id})">发送群私信
                </div>
            </div>
        </div>

    </div>
</div>

{include file="meet/script.tpl"}
<script src="{$base}meet/js/activityMember.js"></script>
</body>
</html>