<!DOCTYPE html>
<html lang=zh>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/public.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/courseList.css"></head>
<body>
<div class=".container">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2 centered content">
            <img src="{$base}/roster/wechat/img/courseList.png" id="main">        
            <div class="col-sm-12 header">
                <img src="{$base}/roster/wechat/img/header.png" id="top">     
                <!-- <button type="button" class="btn-close">
                    <img src="{$base}/roster/wechat/img/close.png"></button> -->
                <span class="title">项目列表</span>
            </div>
            <div class="col-sm-12 list">
                {foreach from=$list item=project}
                    <div class="col-sm-12 course" onClick="courseList({$project['id']})">
                    <img src="{$base}/roster/wechat/img/course.png" class="course_background">            
                    <div class="col-xs-8 info">
                        <div class="course_name">{$project['name']}</div>
                        <div class="course_time">介绍：{$project['introduction']}</div>
                    </div>
                    <div class="col-xs-4 indate">
                        {if $project['endTime'] gte $smarty.now|date_format:"%Y-%m-%d"}
                        <img src="{$base}/roster/wechat/img/now.png">
                        {else}
                        <img src="{$base}/roster/wechat/img/out.png">
                        {/if}
                    </div>
                </div>
                {/foreach}
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
        var list_height=body_height-top_height;
        //alert(list_height);
        $("div.content").css('height',body_height);
        $("div.list").css('max-height',list_height);
    }
    function courseList(id){
        window.location.href="/roster/wechat?m=courseList&projectId="+id;
    }
</script>
</html>
