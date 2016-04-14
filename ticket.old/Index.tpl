<!-- 抢票页 -->
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="format-detection" content="telephone=no" />
        <title>{$title}</title>
        <link rel="stylesheet" href="{$base}common/css/reset.css" >
        <link rel="stylesheet" href="{$base}ticket/css/index.css">
        <link rel="stylesheet" href="{$base}ticket/css/index_mobile.css">
        <script src="http://api.map.baidu.com/api?v=1.5&ak=Etxi30fzk4gLlFdmGibikF2E" type="text/javascript"></script>
        <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    </head>
    <body>
        <div id="smarty" style="display:none">
            <div id="result">{nocache}{$result|default:"fetching result not found"}{/nocache}</div> <!-- 是否抢到票的结果 -->
            <div id="openid">{nocache}{$openid|default:"openid not found"}{/nocache}</div> <!-- openid -->
            <div id="actID">{$id|default:"actID not found"}</div> <!-- 活动id -->
            <div id="actName">{$name|default:"actName not found"}</div> <!-- 活动名称 -->
            <div id="leftT"> {$leftTicket|default:"number of leftTicket not found"}</div> <!-- 总票数 -->
            <div id="leftChance">{$leftChance|default:"number of leftChance not found"}</div> <!-- 可抢次数 -->
            <div id="startTime">{$startTime|default:"startTime not found"}</div> <!-- 开始时间 -->
            <div id="endTime">{$endTime|default:"endTime not found"}</div> <!-- 结束时间 -->
            <div id="demand">{$demand|default:"click"}</div> <!-- 抢票类型，值为click等 -->
            <div id="actContent">{$content|default:"actContent not found"}</div> <!-- 活动详情 -->
            <div id="token">{$token|default:"token not found"}</div> <!-- 抢到票的情况下显示的token -->
            <div id="base">{$base|default:"/templates/"}</div>
            <div id="indexPic">{$indexPic|default: "{$base}templates/ticket/img/cover.jpg"}</div>
            {* <div id="picArr">
                <li>http://m3.img.srcdd.com/farm4/d/2014/1128/15/D5288091FF0A7443D1D03A525BA83359_B1280_1280_490_326.jpeg</li>
                <li>http://m1.img.srcdd.com/farm4/d/2014/1128/15/6143B7C4C74E5FE74E72BC4FC883FD54_B1280_1280_490_326.jpeg</li>
                <li>http://m1.img.srcdd.com/farm4/d/2014/1128/15/6FE13F4CF6305BFFB04B6A3267E33546_B1280_1280_490_367.jpeg</li>
            </div> *}
            {if !empty($picArr)}
            <div id="picArr">
                {foreach $picArr as $picUrl}
                <li>{$picUrl}</li>
                {/foreach}
            </div>
            {/if}
            {if !empty($location)}
            <div id="location">
                {foreach $location as $data}
                <li>{$data}</li>
                {/foreach}
            </div>
            {/if}
            <div class="stopLoopingButton"></div>
        </div>

        <div class="t-wrapper">

            <div class="nav" style="background-image: url({$base}ticket/img/brand.png)">
                <ul>
                    <li class="home">首页</li>
                    <li class="ticket">抢票</li>
                    <li class="detail">活动详情</li>
                    {if !empty($picArr)}
                    <li class="pics">活动图片</li>
                    {/if}
                    {* {if !empty($location)}
                    <li class="map">地图</li>
                    {/if} *}
                </ul>
            </div>
            <div class="toChange"></div>
        </div>

        {include file="common/Footer.tpl"}
        <script type="text/javascript" src="{$base}common/js/WeixinApi.js?v=1.1"></script>
        <script type="text/javascript" src="{$base}ticket/js/index.js?v=1.2.1"></script>
    </body>
</html>
