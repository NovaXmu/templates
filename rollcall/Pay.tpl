<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <title>{$name} | 扫码付网薪</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <script src="{$base}rollcall/js/jquery.qrcode.min.js"></script>

    <link rel="stylesheet" type="text/css" href="{$base}rollcall/temp/css/login.css">
</head>
<body>
<div class="container">
    <h1 id="code-title" class="text-center">{$name} | 发放网薪</h1>
    <div class="row">
        <div class="col-md-3" style="color: white;font-size: 18px;margin-top: 100px;">
            <p>关注"厦大易班"微信号</p>
            <p>在微信号中绑定易班帐号</p>
            <p>点击"网络文化节"->"收获网薪"</p>
            <p>扫描右侧二维码</p>
        </div>
        <div id="Qcode" class="col-md-6">
            <div id="code"></div>
            <button id="refresh" type="button" class="button button-glow button-royal" onclick="refresh();">点击刷新</button>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">

function refresh() {
    $.get(
        "/rollcall/api/pay?id={$id}",
        function (data) {
            data = jQuery.parseJSON(data);
            if (data.errno == '0') {
                $('div#code').html('')

                token = data.token;
                // http://www.helloweba.com/view-blog-226.html
                $('div#code').qrcode({
                    width: 530,
                    height: 530,
                    text: token
                });
            }
        }
    );
}
refresh();
</script>
</body>
</html>
