<!DOCTYPE html>
<html lang=zh>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/public.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/courseDetail.css"></head>
<body>
<div class=".container">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2 centered content">
            <img src="{$base}/roster/wechat/img/courseList.png" id="main">        
            <div class="col-sm-12 header">
                <img src="{$base}/roster/wechat/img/header.png" id="top">     
                <!-- <button type="button" class="btn-back">
                    <img src="{$base}/roster/wechat/img/back.png"></button> -->
                <span class="title">{$course['name']}</span>
                <button type="button" class="btn-detail" id="checkLog" onClick="checkLog()">
                    <img src="{$base}/roster/wechat/img/detail.png">
                </button>
                <button type="button" class="btn-detail" id="checkin" onClick="checkin()" style="display:none;">
                    <img src="{$base}/roster/wechat/img/code.png">
                </button>
            </div>
            {if $course != NULL}
            <div class="col-sm-12 main">
                <div class="col-xs-12 text"></div>
                <div class="col-xs-10 col-xs-offset-1 centered code">
                    <img src="{$base}/roster/wechat/img/border.png" id="border">
                    {if $course['time'] == -1}
                    <img src="{$base}/roster/wechat/img/end.png" id="image">
                    {else}
                     <img src="{$base}/roster/wechat/img/start.png" id="image" onClick="startCheck()">
                    {/if}
                    <span id="code"></span>
                </div>
                <div class="col-xs-12 text" style="text-align:center">
                    扫一扫上面的二维码图案，进行签到
                </div>
            </div>
            {/if}
        </div>
    </div>
</div>
    
</body>
<script src="{$base}/roster/wechat/js/jquery-1.12.0.min.js"></script>
<script src="{$base}/roster/wechat/js/bootstrap.min.js"></script>
<script src="{$base}/roster/wechat/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
    window.onload=function(){
        var body_height=window.screen.height;
        var top_height=$(".header").height();
        var main_height=body_height-top_height;
        $("div.content").css('height',body_height);
        $("div.main").css("max-height",main_height);
    }

    function startCheck(){
        $('#image').css('display', 'none');
        $.get(
            '/roster/api/wechat?m=startCheck&courseId=' + {$course['id']},
            function (data, status) {
            $('QRcode').html('');
            if (status == "success") {
                data = jQuery.parseJSON(data);
                if (data.errno == '0') {
                    token = data.errmsg;
                    str = 'http://xmu.novaxmu.cn/roster/checkin?token='+token;
                    $('#code').qrcode({
                        width:200,
                        height:200,
                        text: str
                    });
                }else{
                    alert('error');
                }
            }
            else {
                alert("网络中断，请检查网络连接");
            }
        });   
    }

    function checkLog(){
        window.location.href="/roster/wechat?m=checkLog&courseId=" + {$course['id']};
    }
</script>


</html>
