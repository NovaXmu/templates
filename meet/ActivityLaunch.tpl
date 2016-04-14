<!DOCTYPE html>
<meta charset="utf-8"/>
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>发起活动</title>
    <link rel="stylesheet" href="{$base}meet/css/activityLaunch.css">
</head>
<body>
<div class="col-sm-8 col-sm-offset-2 centered" id="main">
    <div id="top">
        <a href="/meet/blog?m=activity&blog_id={$blog_id}" target="_top" id="back">
            <span class="glyphicon glyphicon-chevron-left"></span>
            {$title}
        </a>
        <div id="title">发起活动</div>
    </div>
    <div id="content" class="clearfix">
        <div class="activity clearfix">
            <div id="name">
                <span>活动名称</span>
                <input type="text" name="actName"/>
            </div>
            <div id="introduction">
                <span>活动内容</span>
                <textarea id="actContent"></textarea>
            </div>
            <div id="time">
                <span>报名截止时间</span>
                <input type="date" name="deadline"/>
            </div>
            <div id="maxnum" style="margin-bottom:20px;">
                <span>人数限制(包括发起者)</span>
                <input type="number" name="limit_num"/>
            </div>
            <button id="launch">发布</button>
        </div>
    </div>
</div>
{include file="meet/script.tpl"}
<script src="{$base}meet/js/activityLaunch.js"></script>
</body>
</html>