<!-- 部落消息 -->
<!DOCTYPE html>
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>查看消息</title>
    <link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
    <link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
    <link rel="stylesheet" href="{$base}meet/css/message.css">
    <link rel="stylesheet" href="{$base}meet/css/mask.css"></head>
<body>
{include file="meet/Remodal.tpl"}
    <div class="remodal-bg">
            <div class="col-sm-8 col-sm-offset-2 centered" id="main">
                <div id="top">
                    {if $type eq '1'}
                    <a href="/meet/message?m=index" 
                    target="_top" id="back">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                        消息记录
                    </a>
                    <div id="title">{$title}</div>
                    {/if}
                    {if $type eq '2'}
                    <a href="/meet/blog?m=activity&blog_id={$return_id}" target="_top" id="back">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                        部落
                    </a>
                    <div id="title">{$title}</div>
                    <span id="alt">活动消息</span>
                    {/if}
                    {if $type eq '3'}
                    <a href="/meet/blog?m=blog" 
                    target="_top" id="back">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                        部落列表
                    </a>
                    <div id="title">{$title}</div>
                    <span id="alt">部落消息</span>
                    {/if}
                </div>
                <div id="content" class="clearfix">
                    {include file="meet/MessageBlock.tpl"}
                    {if $ret['errno'] eq '0'}
                    <div id="listBlock">
                        <div class="col-xs-10 col-xs-offset-1 centered messagelist">
                            <button type="button" class="More" onclick="viewMore({$type},{$to_id})">查看更多消息</button>
                            <ul>
                                {foreach from=$list item=message name=record}
                                <li style="text-align:
                    {if $message['from_user_ybid'] eq $user}right{else}left{/if}" id="{if $smarty.foreach.record.last}lastMsg{/if}">
                                    <img src="http://img02.fs.yiban.cn/{$message['from_user_ybid']}/avatar/user/30" 
                                    class="face popMask" id="{$message['from_user_ybid']}">
                                    <span style="font-size:10px;display:none;">{$message['time']}</span>
                                    <p style="font-size:15px;">{$message['content']}</p>
                                </li>
                                {/foreach}
                            </ul>
                        </div>
                        <div class="col-xs-10 col-xs-offset-1 centered enter" onclick="switchMessage('{$title}',{$type},{$to_id})">
                            {if $type eq '1'}发消息{/if}
                        {if $type eq '2'}群发活动消息{/if}
                        {if $type eq '3'}群发部落消息{/if}
                        </div>
                    </div>
                    {else}
                    <p style="margin-top:20px;">{$ret['errmsg']}</p>
                    {/if}
                </div>

            </div>
    </div>
    {include file="meet/script.tpl"}
    <script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
    <script src="{$base}meet/js/message.js"></script>
    <script src="{$base}meet/js/mask.js"></script>
</body>
</html>