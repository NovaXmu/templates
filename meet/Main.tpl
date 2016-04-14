<!-- 个人主页 -->
<!DOCTYPE html>
<html lang=zh>
<head>
    {include file="meet/link.tpl"}
    <title>遇见</title>
    <link rel="stylesheet" href="{$base}meet/css/main.css">
</head>
<body>

    <div class="col-sm-8 col-sm-offset-2 centered" id="main">
        <div id="top">
            <a href="javascript:history.go(-1)" id="back"><span class="glyphicon glyphicon-chevron-left"></span>返回</a>
            <div id="title">遇见</div>
        </div>
        <div id="content" class="clearfix">
            <div id="showcase">
                <span style="font-size: x-large; color: white;">{$info['nickname']}</span><br>
                <span style="display:none" class="sex">{$info['sex']}</span>
                <span>活跃度：{$info['interpersonal']}</span><br>            
                <span>魅力值：{$info['charm']}</span><br>            
                <button type="button" id="{$info['ybid']}">查看名片</button>
                <img src="" style="height:70%;float:right;display: none"/>
            </div>
        </div>
        {include file="meet/footer.tpl"}
    </div>
{include file="meet/script.tpl"}
<script src="{$base}meet/js/main.js"></script>
</body>
</html>