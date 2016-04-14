<!-- PK -->
<!DOCTYPE html>
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>PK</title>
    <link rel="stylesheet" href="{$base}meet/css/pk.css">
</head>
<body>

    <div class="col-sm-8 col-sm-offset-2 centered" id="main">
        <div id="top">
            <a href="javascript:history.go(-2)" id="back"><span class="glyphicon glyphicon-chevron-left"></span>返回</a>
            <div id="title">PK</div>
        </div>
        <div id="content" class="clearfix">
            <div id="ers" class="row">
                <div id="er1" class="col-xs-5">
                    <div class="wrap">
                        <img src="http://img02.fs.yiban.cn/{$result['me']['ybid']}/avatar/user/200" alt="avatar">
                    </div>
                    <p class="name">{$result['me']['nickname']}</p>
                    <p class="value">{$result['point1']}</p>
                </div>
                <div id="vs" class="col-xs-2">
                    <h2>VS</h2>
                </div>
                <div id="er2" class="col-xs-5">
                    <div class="wrap">
                        <img src="http://img02.fs.yiban.cn/{$result['he']['ybid']}/avatar/user/200" alt="avatar">
                    </div>
                    <p class="name">{$result['he']['nickname']}</p>
                    <p class="value">{$result['point2']}</p>
                </div>
            </div>
            <!--<div class="boards">-->
                <!--左右滑动出现多个仪表盘-->
                <!--<ul>
                    <li>-->
                        <canvas id="meColor" width="20" height="10"></canvas>
                        <span>{$result['me']['nickname']}&#12288;&#12288;</span>
                        <canvas id="heColor" width="20" height="10"></canvas>
                        <span>{$result['he']['nickname']}</span>
                        <div class="board">
                            <canvas class="canvas"></canvas>
                            <p class="result">{$result['message']}</p>
                        </div>
                   <!-- </li>
                </ul>-->
           <!-- </div>
            <div id="d">
                <p>左右滑动更多PK</p>
            </div>-->
        </div>
    </div>

{include file="meet/script.tpl"}
<!--<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>-->
<script src="{$base}meet/js/pk.js"></script>
</body>
</html>