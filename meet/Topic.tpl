<!--话题详情-->
<!DOCTYPE html>
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>话题详情</title>
    <link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal.css">
    <link rel="stylesheet" href="{$base}meet/css/Remodal-1.0.1/remodal-default-theme.css">
    <link rel="stylesheet" href="{$base}meet/css/topic.css">
    <link rel="stylesheet" href="{$base}meet/css/comment.css">
    <link rel="stylesheet" href="{$base}meet/css/mask.css">
    <link rel="stylesheet" href="{$base}meet/css/messageBlock.css">
</head>
<body>
{include file="meet/Remodal.tpl"}
<div class="remodal-bg">
    <div class="col-sm-8 col-sm-offset-2 centered" id="main">
        <div id="top">
            <a href="/meet/topic?m=index" target="_top" id="back">
                <span class="glyphicon glyphicon-chevron-left"></span>
                话题榜
            </a>

            <div id="title">话题详情</div>
        </div>
        <div id="content" class="clearfix">
            {include file="meet/MessageBlock.tpl"}
            <div id="board">
                <div class="col-xs-12 head">
                    <div class="name">{$topic['title']}</div>
                    <div class="time">{$topic['time']}</div>
                </div>
                <div class="col-xs-12 main" id="{$topic['user_ybid']}">
                    <img src="http://img02.fs.yiban.cn/{$topic['user_ybid']}/avatar/user/200" class="avator popMask"
                         id="{$topic['user_ybid']}"/>

                    <div class="col-xs-12 content topic" id="{$topic['id']}">
                        <p>{$topic['content']}</p>

                        <div style="float:right;color:#000">
                            {if $topic['isPraised'] eq 'true'}
                            <img src="{$base}meet/img/quxiaozan.png" class="dianzan great"
                                 onclick="praise(this,1,{$topic['id']})"/>
                            {else}
                            <img src="{$base}meet/img/dianzan.png" class="dianzan"
                                 onclick="praise(this,1,{$topic['id']})"/>
                            {/if}
                            <span style="font-size:15px;">{$topic['praiseCount']}</span>

                            <img src="{$base}meet/img/pinglun.png" style="margin-left:15px;"
                                 onclick="pinglunClick(this)">
                            <span style="font-size:15px;">{$topic['commentCount']}</span>
                        </div>
                        <textarea id="COMMENT" class="commentInput" onfocus="focusTextarea(this)"
                                  onblur="blurTextarea(this)" placeholder="我也说一句"></textarea>
                        <button type="button" class="btn-comment"
                                onmousedown="comment(this,{$topic['id']},{$topic['user_ybid']})" style="display:none">发送
                        </button>
                    </div>
                    <div class="col-xs-12 comment">
                        <ul class="comment-ul">
                            {foreach from=$topic['comment'] item=comment}
                            <li id="{$comment['id']}">
                                <div class="col-xs-12" style="height:20px;"></div>
                                <div class="col-xs-2 img popMask" id="{$comment['from_user_ybid']}">
                                    <img src="http://img02.fs.yiban.cn/{$comment['from_user_ybid']}/avatar/user/200"
                                         class="commentAvator"/>
                                </div>
                                <div class="col-xs-10">
                                    <div class="col-xs-12">
                                        <span style="font-size:15px;">{$comment['nickname']}</span>

                                        <div class="operate">
                                            {if $comment['isPraised'] eq 'true'}
                                            <button type="button" class="great"
                                                    onclick="praise(this,2,{$comment['id']})">取消赞
                                            </button>
                                            <span>{$comment['praiseCount']}</span>
                                            {else}
                                            <button type="button" onclick="praise(this,2,{$comment['id']})">点赞</button>
                                            <span>{$comment['praiseCount']}</span>
                                            {/if}
                                            <button type="button" class="btn-reply"
                                                    onclick="huifuClick(this,'{$comment['nickname']}',2)">回复
                                            </button>
                                            <span>{$comment['commentCount']}</span>
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <span style="font-size:10px;color: #aaaaaa" onclick="return false;">{$comment['time']}</span>
                                    </div>
                                </div>
                                <div class="col-xs-10 col-xs-offset-2" style="margin-top:5px;">
                                    <p>{$comment['content']}</p>
                                </div>
                                {if $comment['commentCount'] neq '0'}
                                <div class="col-xs-12">
                                    <button type="button" class="btn-viewComment" onclick="viewComment(this)">查看回复
                                    </button>
                                </div>
                                {/if}
                                <div class="col-xs-12 textarea" style="display:none">
                                    <textarea id="REPLY" class="commentInput" placeholder="回复"
                                              onfocus="focusTextarea(this)" onblur="blurTextarea(this)"></textarea>
                                    <button type="button" class="btn-replyComment" onmousedown="replyComment(this)">回复
                                    </button>
                                </div>
                            </li>
                            {/foreach}
                        </ul>
                    </div>
                    <button type="button" id="moreComment">更多评论</button>
                </div>
            </div>
        </div>
    </div>
</div>
{include file="meet/script.tpl"}
<script src="{$base}meet/js/topic.js"></script>
<script src="{$base}meet/js/comment.js?v=1.0001"></script>
<script src="{$base}meet/js/Remodal-1.0.1/remodal.js"></script>
<script src="{$base}meet/js/mask.js"></script>
</body>
</html>