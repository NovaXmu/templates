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
                <span class="title">课程列表</span>
                <input type="date" class="time" id="dateTime" value="{$date}" onChange="searchCourseList()">
                <!-- <span class="time">2月14日</span> style="color:#337ab7; background-color:rgba(255,255,255,.15); border:0px; border-color:rgba(0,0,0,.5; height:35px;"-->
            </div>
            <div class="col-sm-12 list">
                {if $user['type'] == 2}
                {foreach from=$list item=course}
                <div class="col-sm-12 course" onClick="course({$course['id']})">
                    <img src="{$base}/roster/wechat/img/course.png" class="course_background">            
                    <div class="col-xs-8 info">
                        <div class="course_name">{$course['name']}</div>
                        <div class="course_time">时间：{$course['start']|cat:" ~ "|cat:$course['end']}</div>
                        <div class="course_place">地点：{$course['address']}</div>
                    </div>
                    <div class="col-xs-4 indate">
                        {if $course['endTime'] gte $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
                        <img src="{$base}/roster/wechat/img/now.png">
                        {else if $course['check'] == 0}<!-- 未点名 -->
                        <span>未点名</span>
                        <img src="{$base}/roster/wechat/img/out.png">
                        {else}
                        <span>已点名</span>
                        <img src="{$base}/roster/wechat/img/out.png">
                        {/if}
                    </div>
                </div>
                {/foreach}
                {else}
                {foreach from=$list item=course}
                <div class="col-sm-12 course">
                    <img src="{$base}/roster/wechat/img/course.png" class="course_background">            
                    <div class="col-xs-8 info">
                        <div class="course_name">{$course['name']}</div>
                        <div class="course_time">时间：{$course['start']|cat:" ~ "|cat:$course['end']}</div>
                        <div class="course_place">地点：{$course['address']}</div>
                    </div>
                    <div class="col-xs-4 indate">
                        {if $course['endTime'] gte $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
                        <img src="{$base}/roster/wechat/img/now.png">
                        {else if $course['check'] == 0}<!-- 未点名 -->
                        <img src="{$base}/roster/wechat/img/8.png">
                        {else if $course['check'] == -1}<!-- 未签到 -->
                        <img src="{$base}/roster/wechat/img/10.png">
                        {else}
                        <img src="{$base}/roster/wechat/img/9.png">
                        {/if}
                    </div>
                </div>
                {/foreach}
                {/if}
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
    var loading = '<div class="spinner">\
                  <div class="rect1"></div>\
                  <div class="rect2"></div>\
                  <div class="rect3"></div>\
                  <div class="rect4"></div>\
                  <div class="rect5"></div>\
                </div>';


    function searchCourseList(){
        $(".container").html(loading);
        var date = $('input#dateTime').val();
        window.location.href="/roster/wechat?m=courseList&projectId={$projectId}&date=" + date;
    }

    function course(id){
        $(".container").html(loading);
        window.location.href="/roster/wechat?m=course&courseId="+id;
    }
</script>
</html>
