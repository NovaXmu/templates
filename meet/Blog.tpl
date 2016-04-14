<!-- 部落 -->
<!DOCTYPE html>
<meta charset="utf-8">
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>部落</title>
    <link rel="stylesheet" href="{$base}meet/css/blog.css">
</head>
<body>
<!--修改活动-->
<div class="modal fade" id="update" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="name">
                    <span>活动名称</span>
                    <input type="text" name="actName"></div>
                <div class="content">
                    <span>活动内容</span>
                    <textarea id="actContent"></textarea>
                </div>
                <div class="deadline">
                    <span>活动截止时间</span>
                    <input type="date" name="deadline"></div>
                <div class="limitNum"> 
                    <span>人数限制(包括发起者)</span>
                    <input type="number" name="limitNum"/>            
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" onclick="update();">修改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!--修改活动-->
    <div class="col-sm-8 col-sm-offset-2 centered" id="main">
        <div id="top">
            <a id="back"  href="/meet/blog?m=blog" target="_top"><span class="glyphicon glyphicon-chevron-left"></span>部落列表</a>
            <div id="title">{$title}</div>
        </div>
        <div id="content" class="clearfix">
            <div class="tabs">
                <button type="button" class="tab-left {if $smarty.get.isHost == true}active{/if}">我发起的</button>
                <button type="button" class="tab-middle {if $smarty.get.isHost != true && $smarty.get.isJoined != true}active{/if}">活动列表</button>
                <button type="button" class="tab-right {if $smarty.get.isJoined == true}active{/if}">我加入的</button>
            </div>
            <div id="avatar">
                <div class="wrap">
                    <img src="http://img02.fs.yiban.cn/{$user}/avatar/user/200">
                </div>
                <p>{$nickname}</p>
            </div>
            <div id="list" class="clearfix">
                <ul style="visibility: hidden;">
                {foreach from=$list item=activity}
                    <li class="act" id="{$activity['id']}">
                        <div class="top">

                            <div>
                                <h4 class="activityName">{$activity['title']}</h4>
                            </div>
                            <div class="edit" onclick="updateModal(this)">
                            {if $activity['isHost'] eq 'true'}
                                <img src="{$base}meet/img/edit.png">
                            {else}
                            {/if}
                            </div>
                            <p>活动内容：<span class="activityContent">{$activity['content']}</span></p>
                            <p>报名截止时间：<span class="activityDeadline">{$activity['deadline']}</span></p>
                            <p>人数限制：<span class="activityLimitNum">
                            {if $activity['limitNum'] eq "-1"}
                            不限
                            {else}
                            {$activity['limitNum']}
                            {/if}</span></p>
                            {*<img src="{$base}meet/img/member.png">*}
                            <button class="view-members" type="button" onclick="viewMember(this)">|查看当前参与者</button>
                        </div>
                        <div class="bottom">
                            <div onclick="viewMessage('2',{$activity['id']})">查看消息</div>
                            {if $activity['isHost'] eq 'true'}
                            <div onclick="deleteAct(this)">取消活动</div>
                            {elseif $activity['isJoined'] eq 'true'}
                            <div onclick="quitAct(this)">退出活动</div>
                            {else}
                            <div onclick="joinAct(this)">加入活动</div>
                            {/if}
                        </div>
                    </li>
                {/foreach}
                </ul>
            </div>
            {if $list|count eq '0'}
            <p style="color:#b5b5b5">没有更多活动了...</p>
            {else}
            <p id="d" style="clear: both">左右滑动查看更多活动</p>
            {/if}
            <button id="new">
                发起活动
            </button>
        </div>

    </div>

{include file="meet/script.tpl"}
<script src="{$base}meet/js/hammer.min.js"></script>
<script src="{$base}meet/js/slideshow.js"></script>
<script src="{$base}meet/js/blog.js"></script>
</body>
</html>