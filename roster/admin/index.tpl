<!DOCTYPE html>
<meta charset="utf-8">
<html lang=zh>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/css/public.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/css/frame_menu.css">
    
<body>
    <div class="row">
        <div class="col-sm-2 frame_menu">
            <div class="avatar">
                <img src="{$base}/roster/img/6.png">
                <h5>{$user.job}</h5>
                <h5>{$user.nickname}</h5>
            </div>
            <div class="menu">
                <a onClick='loadIndex(this)' id="menu_index">
                    <div class="menu_index selected">
                        <div class="left left_selected"></div>
                        <div class="right">
                            <img src="{$base}/roster/img/icon_index.png">首页</div>
                    </div>
                </a>
                {if $user.privilege == 2}
                <a onClick='loadProjectList(this)' id="menu_projectList">
                    <div class="menu_project">
                        <div class="left"></div>
                        <div class="right">
                            <img src="{$base}/roster/img/icon_manage.png">项目</div>
                    </div>
                </a>
                {/if}
                {if $user.privilege == 1}
                <a onClick='loadManagerList(this)' id='menu_managerList'>
                    <div class="menu_manage">
                        <div class="left"></div>
                        <div class="right">
                            <img src="{$base}/roster/img/icon_manage.png">后台</div>
                    </div>
                </a>
                {/if}
            </div>
        </div>
        <div class="col-sm-10 frame_content">
            <div class="top">
                <span>孔子学院</span>
                <span>>></span>
                <button type="button" class="btn-first" data="1">首页</button>
                <button type="button" class="btn-exit" onClick='logout()'>
                    <img src="{$base}/roster/img/icon_exit.png">                
                    <span>退出</span>
                </button>
            </div>
            <div class="main">
                <div class="main_content col-sm-10 col-sm-offset-1" id='right'></div>
            </div>
        </div>
        </div>
        <div id="footer" class="text-center">
            <hr>
            <div class="wrapper">
                <div class="credits">
                    <p>Designed and built with all the love in the world by the Nova Studio.</p>

                    <div class="crew"></div>
                </div>
                <div class="copyrights">
                    <p>©<a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">Nova Studio</a>&nbsp;2015.All rights
                        reserved.</p>
                </div>
            </div>
    </div>
</body>
<script src="{$base}/roster/js/jquery-1.12.0.min.js"></script>
<script src="{$base}/roster/js/bootstrap.min.js"></script>
<script>
var loading = '<div class="spinner">\
                  <div class="rect1"></div>\
                  <div class="rect2"></div>\
                  <div class="rect3"></div>\
                  <div class="rect4"></div>\
                  <div class="rect5"></div>\
                </div>';

function load(e){
    e.html(loading);
}

$(".btn-first").click(function(){
    switch($(this).attr("data")){
        case '1':{
            loadIndex($(".menu a#menu_index"));
            break;
        }
        case '2':{
            loadProjectList($(".menu a#menu_projectList"));
            break;
        }
        case '3':{
            loadManagerList($(".menu a#menu_managerList"));
            break;
        }
    }
});
function changeMenu(e){
    $(e).siblings().children().removeClass('selected');
    $(e).siblings().find('.left').removeClass("left_selected");
    $(e).find(".menu_project").addClass('selected');
    $(e).find(".left").addClass('left_selected');
    $(".btn-first").nextUntil(".btn-exit").remove();
}
function logout(){
    window.location.href = '/roster/admin?m=login';
}

function loadIndex(e){
    changeMenu(e);
    $(".btn-first").text("首页");
    $(".btn-first").attr("data",'1');
    load($('#right'));
    document.getElementById('right').innerHTML='';
}
      
function loadManagerList(e){
    changeMenu(e);
    $(".btn-first").text("后台");
    $(".btn-first").attr("data",'3');
    load($('#right'));
    $('#right').load('/roster/super?m=managerList', function(response,status,xhr) {
        if ( status == "success" ) {
             $('[name="checkbox-my"]').bootstrapSwitch();
               $(".switch").children().css("width","100px");
               $(".switch").children().children().css("width","147px");
               $(".switch").children().children().children().css("width","49px");
        }
    });
}

function loadProjectList(e){
    changeMenu(e);
    $(".btn-first").text("项目");
    $(".btn-first").attr("data",'2');
    load($('#right'));
    $('#right').load('/roster/project?m=projectList&page=1&time=0');
}

</script>
</html>