<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>厦大易班扫码签到</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- Loading Bootstrap -->
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">

    <link href="{$base}rollcall/css/board.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.6.2/html5shiv.js"></script>
    <![endif]-->
</head>
<body>

<div class="container" id="page">
    <div class="row" style="padding-top: 170px;">
        <div id="left-content" class="col-md-5 col-md-offset-1">
            <div id="act" style="display:none;">{$act}</div>
            <div id="info" style="display:none;">
                {foreach $info as $each}
                    <p>{$each}</p>
                {/foreach}
            </div>
            <div id="instruction">
                <div id="act-name">{$info["name"]}</div>
                <!-- <p>签到方法：从微信进入“厦大易班”服务号公众平台，选择子菜单“易活动” -/-> “扫码签到”，扫描屏幕右边的二维码</p> -->
                <div id="content">
                    <img class="img-responsive" src="{$base}rollcall/img/process.png?v=1.1" alt="" id="process">

                    <div id="text">还需要哪些提示呢？还没想好怎么写 #test</div>
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <span id="QRcode"></span>
        </div>
    </div>

    <div id="footer" class="navbar-fixed-bottom">
        <div class="wrapper">
            <div class="credits">
                <p>Designed and built with all the love in the world by the Nova Studio.</p>

                <div class="crew"></div>
            </div>
            <div class="copyrights">
                <p>©2015 <a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">Nova Studio</a></p>
            </div>
        </div>
    </div>
</div>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script src="{$base}rollcall/js/jquery.qrcode.min.js"></script>
<script src="{$base}rollcall/js/board.js"></script>
<script src="{$base}rollcall/js/offline.min.js"></script>
</body>
</html>
