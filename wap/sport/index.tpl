<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>厦大田径运动会积分榜</title>
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.18.1/build/cssreset/cssreset-min.css">
    <link href="{$base}wap/sport/css/score.css?v=4.3" rel="stylesheet"></head>
    <script>
        var BASE = {$base};
    </script>
<body>

    <nav>
        <div id="order">
            <span>排序：</span>
            <menu>
                {foreach from=$orderList item=name key=num}
                    {if $num eq $order}<li class="selected" data-key="{$num}">{$name}</li>{/if}
                {/foreach}
                {foreach from=$orderList item=name key=num}
                    {if $num != $order}<a href="sport?m=index&order={$num}&year={$year}"><li data-key="{$num}">{$name}</li></a>{/if}
                {/foreach}
            </menu>
        </div>
        <div id="year">
            <menu>
                {foreach from=$yearList item=y}
                    {if $year == $y}<li class="selected">{$y}</li>{/if}
                {/foreach}
                {foreach from=$yearList item=y}
                    {if $year != $y}<a href="sport?m=index&order={$order}&year={$y}"><li>{$y}</li></a>{/if}
                {/foreach}
                {*<li class="selected">2015</li>
                <li>2014</li>*}
            </menu>
        </div>
    </nav>

    <header id="main-title">
        <h1>厦大易班，为校运会加油！</h1>
        <span>{$row}更新</span>
    </header>
    {*<div id="test"></div>*}
    <div id="tops"></div>
    <div id="lessers"></div>
    <div id="message-board">
        <h2>留言板</h2>
        <div id="input-wrap">
            <textarea name="input" id="input" placeholder="为你支持的学院呐喊吧！(少于100字)"></textarea>
        </div>
        <button id="new-msg">发表</button>
        <ul id="msg-list" data-page="1">
            {foreach from=$message item=each key=index name=posts}
                <li data-id="{$each.id}">
                    <div class="wrap">
                        <div class="user" data-openid="{$each.openid}">
                            <div class="avatar">
                                <img src="{$each.headimgurl}" alt="头像"/>
                            </div>
                            <span class="username">{$each.nickname}</span>
                        </div>
                        <div class="msg">{$each.content}</div>
                    </div>
                    <div class="footer">
                        <time>{$each.time}</time>
                        <div class="floor-num"></div>
                    </div>
                </li>
            {/foreach}

            {*<li>
                <div class="wrap">
                    <div class="user">
                        <div class="avatar">
                            <img src="{$base}wap/sport/img/avatar-placeholder.jpg" alt=""/>
                        </div>
                        <span class="username">ziyang</span>
                    </div>
                    <div class="msg">加油加油！</div>
                </div>
                <div class="floor-num">2</div>
            </li>*}
        </ul>
        <button id="prev">上一页</button>
        <button id="next">下一页</button>
        {*<div id="more-msg">更多评论...</div>*}
    </div>
    {*<div id="back-to-top">回到顶部</div>*}
    <footer>
        <div id="footer-top">
            <p>积分榜仅供参考</p>
            <p>最终成绩以体育教学部公布为准</p>
        </div>
        <div id="footer-bottom">
            <p>
                Designed and built with all the love in the world by the Nova Studio.
            </p>
            <p>
                ©2015
                <a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">Nova Studio</a>
            </p>
        </div>
    </footer>

    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script src="{$base}wap/sport/js/WeixinApi.js"></script>
    {*<script src="{$base}wap/sport/js/modernizr-custom.js?v=0.2"></script>*}

    <script src="{$base}wap/sport/js/score.js?v=1.54"></script>
</body>
</html>