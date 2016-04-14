<!DOCTYPE html>
<html lang=zh>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/public.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/signList.css"></head>
<body>
<div class=".container">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2 centered content">
            <img src="{$base}/roster/wechat/img/courseList.png" id="main">        
            <div class="col-sm-12 header">
                <img src="{$base}/roster/wechat/img/header.png" id="top"> 
                <div class="title">
                    <button type="button" class="btn-back" onClick="checkin()">
                        <img src="{$base}/roster/wechat/img/back.png">
                    </button>
                    {$course['name']}
                </div>
                <div class="num">
                    <div class="progress" style="width:80%;">
                       <div class="progress-bar progress-bar-success" role="progressbar" 
                          aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"  
                          style="width:{$list['count']/$list['total']*100}%;">
                       </div>
                       <span style="color:black; padding-top:5%;">已有{$list['count']}人签到/共{$list['total']}人</span>
                    </div>
                    <!-- <img src="{$base}/roster/wechat/img/1.png" id="fore1">
                    <img src="{$base}/roster/wechat/img/2.png" id="fore2"> -->
                </div>
            </div>
            <div class="col-xs-12 main">
                <div class="col-xs-12 pag">
                    <button type="button" class="btn-sign btn-selected" onClick="showCheckin()">已签到</button>
                    <button type="button" class="btn-no-sign btn-unselected" onClick="showNotCheckin()">未签到</button>
                </div>
                <div class="col-xs-12 attr">
                    <img src="{$base}/roster/wechat/img/attr.png">
                    <div class="col-xs-12 divAttr">
                        <div class="col-xs-3">序号</div>
                        <div class="col-xs-4">姓名</div>
                        <div class="col-xs-5">联系方式</div>
                    </div>
                </div>
                <div class="col-xs-12 list" id="notCheckin" style="display:none;">
                    {$i = 1}
                    {foreach from=$list['notCheckin'] item=log}
                    <div class="col-xs-12 item">
                        <img src="{$base}/roster/wechat/img/item.png">
                        <div class="col-xs-12 item-value">
                            <div class="col-xs-3">{$i++}</div>
                            <div class="col-xs-4">{$log['user']['name']}</div>
                            <div class="col-xs-5">{$log['user']['telephone']}</div>
                        </div>
                    </div>
                    {/foreach}
                </div>
                <div class="col-xs-12 list" id="checkin">
                    {$i = 1}
                    {foreach from=$list['checkin'] item=log}
                    <div class="col-xs-12 item">
                        <img src="{$base}/roster/wechat/img/item.png">
                        <div class="col-xs-12 item-value">
                            <div class="col-xs-3">{$i++}</div>
                            <div class="col-xs-4">{$log['user']['name']}</div>
                            <div class="col-xs-5">{$log['user']['telephone']}</div>
                        </div>
                    </div>
                    {/foreach}
                </div>
                <button type="button" class="btn-more">
                <img src="{$base}/roster/wechat/img/more.png" id="more">
                 <!-- <img src="{$base}/roster/wechat/img/bottom.png" id="bottom">
                <span class="moreLabel">查看更多</span></button> -->
            </div>
            
        </div>
    </div>
</div>
    
</body>
<script src="{$base}/roster/wechat/js/jquery-1.12.0.min.js"></script>
<script src="{$base}/roster/wechat/js/bootstrap.min.js"></script>
<script type="text/javascript">
    window.onload=function(){
        var body_height=window.screen.height;
        var top_height=$(".header").height();
        var main_height=body_height-top_height;
        //alert(list_height);
        $("div.content").css('height',body_height);
        $("div.main").css('max-height',list_height);
    }

    $(".pag button").click(function(){
        $(this).siblings().removeClass("btn_selected").addClass("btn_unselected");
        $(this).removeClass("btn_unselected").addClass("btn_selected");
    });

    function checkin(){
        window.location.href="/roster/wechat?m=course&courseId=" + {$course['id']};
    }

    function showCheckin(){
        $('#checkin').css('display', '');
        $('#notCheckin').css('display','none');
    }

    function showNotCheckin(){
        $('#checkin').css('display', 'none');
        $('#notCheckin').css('display','');
    }
</script>


</html>
