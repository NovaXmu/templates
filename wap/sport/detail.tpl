<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$list['info']['xueyuan']}</title>

    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="{$base}wap/sport/css/bootstrap.min.css">
    <link href="{$base}wap/sport/css/detail.css?v=1.04" rel="stylesheet">
</head>
<body>
    <!--<div class="hidden openid" style="display:none"></div>-->
    <div class="col-md-8 col-md-offset-2 col-xs-12" id="{$list['info']['id']}" style="text-align:center;padding:0px;">
        <div style="font-size:25px;color:#8b0000;height:40px;line-height:40px;">
        <a  href="javascript:history.go(-1)" target="_top"><img src="{$base}wap/sport/img/shangyiye.png" style="position:relative;top:20%;float:left"></a>{$list['info']['xueyuan']}</div>
        <div style="height:20px;"></div>
        <div class="black col-xs-4 col-xs-offset-4"></div>
        <div class="white"></div>
        <div class="grades">
        <span style="font-size:25px;">各项成绩表</span>
        <table>
            <tr style="background-color:#dcdcdc;font-size:18px;">
                <th class="name">项目</th>
                <th class="bk">本科生</th>
                <th class="yjs">研究生</th>
            </tr>
            {foreach from=$list['item'] item=sport key=num}
            <tr style="background-color:{if $num is odd}#ffffff{else}#dcdcdc{/if}">
                <th class="name">{$sport['name']}</th>
                <th class="bk {if $sport['grade']['bk_change'] == ""}
                    {elseif $sport['grade']['bk_change'] > 0} rise
                    {elseif $sport['grade']['bk_change'] < 0} fall
                    {elseif $sport['grade']['bk_change'] == 0} nochange
                {/if}">{$sport['grade']['bk']}</th>
                <th class="yjs {if $sport['grade']['yjs_change'] == ""}
                    {elseif $sport['grade']['yjs_change'] > 0} rise
                    {elseif $sport['grade']['yjs_change'] < 0} fall
                    {elseif $sport['grade']['yjs_change'] == 0} nochange
                {/if}">{$sport['grade']['yjs']}</th>
            </tr>
            {/foreach}
            <tr>
                <th>总分</th>
                <th>{$list['info']['jifen_bk']}</th>
                <th>{$list['info']['jifen_yjs']}</th>
            </tr>
        </table>
    </div>
    </div>
<hr>
    <footer class="footer ">
        <div class="container">
            <div class="row footer-top">
                <p class="text-center">积分榜仅供参考</p>
                <p class="text-center">最终成绩以体育教学部公布为准</p>
                <p class="text-center">
                    Designed and built with all the love in the world by the Nova Studio.
                </p>
            </div>
        </div>
        <div>
            <p class="text-center">
                ©2015
                <a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">Nova Studio</a>
            </p>
        </div>
    </footer>
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>