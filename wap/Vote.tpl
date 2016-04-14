<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>第三届“我最喜爱的十位老师”评选</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="{$base}wap/css/vote.css"/>
</head>
<body>
<div class="col-md-8 col-md-offset-2">
    <ul class="nav">
        <li class="active" data-target="#panel1"><a href="#">投票规则</a></li>
        <li data-target="#panel2"><a href="#">候选人</a></li>
    </ul>
    <div id="panel1" class="my-panel">
        <div class="box">
            <img src="{$base}wap/img/poster.jpg" alt="海报" style="width: 100%"/>
        </div>
        <div class="box">
            <div class="row vote-rules">
                <div class="col-xs-3 left-text">投票规则</div>
                <div class="col-xs-9 right-text">
                    点击上方“候选人”进入投票页面，点击老师的照片即可查看老师的个人简介；点击“选择”即可选择老师，出现“√”即为选中，再次点击即可取消选择；选满10位老师后，点击页面下方“投票”即可为自己心爱的老师们投票；<strong>每位用户限投1次，投满10个方为有效。</strong>请给你喜欢的老师投票吧~
                </div>
            </div>
            <div class="row vote-time">
                <div class="col-xs-3 left-text">投票时间</div>
                <div class="col-xs-9 right-text">8月16日12:00——9月11日24:00</div>
            </div>
        </div>
    </div>
    <div id="panel2" class="my-panel" style="display: none;">
        <div class="box">
            <div id="header">十大教师</div>
            <div id="body">

                {foreach from=$data item=teacher name=teachers}

                        {if ($smarty.foreach.teachers.index + 3) % 3 == 0 }
                            {if ($smarty.foreach.teachers.index + 9) % 9 == 0}
                                <div id="page{($smarty.foreach.teachers.index + 9) / 9}" class="page">
                            {/if}
                            <div class="row">
                        {/if}
                        <div class="card col-xs-4" data-id="{$teacher.id}">
                            <div class="avatar">
                                <div class="pic-wrapper">
                                    <img src="{$base}wap/img/votepics/{$teacher.id}.jpg" alt="" class="pic"/>

                                    <p class="vote-num"><span class="iconfont">&#xe600;</span><span class="vote">{$teacher.vote}</span></p>
                                </div>
                            </div>
                            <p class="name">{$teacher.name}</p>
                            {if $teacher.voted != 0}
                                <button class="vote-btn success iconfont"></button>
                            {else}
                                <button class="vote-btn"></button>
                            {/if}
                            <p class="institute" style="display: none">{$teacher.institute}</p>
                            <p class="introduction"  style="display: none">{$teacher.introduction}</p>
                        </div>
                    {if ($smarty.foreach.teachers.index + 1) % 3 == 0}
                        </div>
                    {/if}
                        {if ($smarty.foreach.teachers.index + 1) % 9 == 0}
                            </div>
                        {/if}
                {/foreach}
            </div>
            {if $voted == 1}
                <button id="submit" disabled="disabled">已投票</button>
            {else}
                <button id="submit" >投票</button>
            {/if}
            <div id="footer">
                <button type="button" class="btn btn-default prev-page btn-lg">上一页</button>
                <button type="button" class="btn btn-default next-page btn-lg">下一页</button>
                <p class="page-num"><span id="currentPage"></span>/3</p>
            </div>

        </div>
    </div>
</div>
<div id="p-footer">
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
<div class="modal fade" id="teacher-modal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true" style="font-size: 250%">&times;</span></button>
                <h4 class="modal-title">
                    <span class="name"></span>
                    <span class="vote-num">
                        <span class="iconfont">&#xe600;</span>
                        <span class="num">0</span>
                    </span>
                </h4>
            </div>
            <div class="modal-body">
                <div class="row show">
                    <div class="col-xs-6 col-xs-offset-3 right">
                        <div class="avatar">
                            <img src="" alt="照片" class="pic"/>
                        </div>
                    </div>
                </div>
                <div class="info">
                    <div class="row school">
                        <span class="left col-xs-2 col-xs-offset-1">学校</span>
                        <span class="right col-xs-8">厦门大学</span>
                    </div>
                    <div class="row institute">
                        <span class="left col-xs-2 col-xs-offset-1">学院</span>
                        <span class="right col-xs-8"></span>
                    </div>
                    <div class="row introduction">
                        <span class="left col-xs-2 col-xs-offset-1">简介</span>
                        <p class="right col-xs-8">
                        </p>
                    </div>
                </div>

            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<script src="{$base}wap/js/vote.js"></script>
</body>
</html>