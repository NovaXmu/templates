<html lang=zh>
<head>
    <title>2048</title>
    <meta charset="utf-8">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">
    <meta name="viewport"
          content="width=device-width, target-densitydpi=160dpi, initial-scale=1.0, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- 游戏js css--->
    <link href="{$base}mall/css/game2048.css?v=2.0" rel="stylesheet" type="text/css">
    <link href="{$base}mall/css/tile_pos.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="{$base}mall/css/public.css">
    <link rel="stylesheet" href="{$base}mall/css/gamelist.css">


    {include file="mall/styleTag.tpl"}
</head>
<body class="game">

<div class="row">
    <div class="col-sm-8 col-sm-offset-2 centered" id="main">
        {include file="mall/Header.tpl"}
        <div id="content">
            <div id="main-content" class="bg">
                    <div class="above-game">
                        <a class="restart-button">新游戏</a>
                        <div class="scores-container">
                            <div class="score-container">0</div>
                            <div class="best-container">0</div>
                        </div>
                    </div>

                    <div class="game-container" style="margin-left:auto; margin-right:auto;">
                        <div class="game-message" style="display: none;">
                            <p></p>

                            <div class="lower">
                                <a class="keep-playing-button">Keep going</a>

                            </div>
                        </div>

                        <div class="grid-container">
                            <div class="grid-row">
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                            </div>
                            <div class="grid-row">
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                            </div>
                            <div class="grid-row">
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                            </div>
                            <div class="grid-row">
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                                <div class="grid-cell"></div>
                            </div>
                        </div>

                        <div class="tile-container">

                        </div>
                    </div>

            </div>
        </div>

        {include file="mall/Footer.tpl"}
    </div>
</div>
{include file="mall/scriptTag.tpl"}
<script src="{$base}mall/js/2048/bind_polyfill.js"></script>
<script src="{$base}mall/js/2048/classlist_polyfill.js"></script>
<script src="{$base}mall/js/2048/animframe_polyfill.js"></script>
<script src="{$base}mall/js/2048/keyboard_input_manager.js"></script>
<script src="{$base}mall/js/2048/html_actuator.js"></script>
<script src="{$base}mall/js/2048/grid.js"></script>
<script src="{$base}mall/js/2048/tile.js"></script>
<script src="{$base}mall/js/2048/local_storage_manager.js"></script>
<script src="{$base}mall/js/2048/game_manager.js"></script>
<!-- 获取分数 -->
<script type="text/javascript" src="{$base}mall/js/2048/get_score.js"></script>
<script>
</script>
</body>
</html>