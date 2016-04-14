<!DOCTYPE html>
<html lang="zh-cn">
  <head>
      <meta charset="utf-8">
      <title>厦大易班后台系统</title>
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

      <!-- Loading Bootstrap -->
      <link href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">

      <!-- Loading Flat UI -->
      <link href="{$base}cms/css/flat-ui.min.css" rel="stylesheet">

      <link href="{$base}cms/css/board.css" rel="stylesheet">

      <link href="{$base}cms/css/weditor.css" rel="stylesheet">

      <link href="{$base}cms/css/datepicker/jquery-ui.css" rel="stylesheet">

      <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
      <!--[if lt IE 9]>
        <script src="http://cdn.bootcss.com/html5shiv/3.6.2/html5shiv.js"></script>
      <![endif]-->
    </head>
  <body>
    <div class="container">
      <div class="page-header">
        <h1>
          厦大易班<small data-toggle="modal" data-target="#User" style="padding-left: 30px;"><strong>{$user}</strong></small>
          <button type="button" class="btn btn-info btn-sm" style="float: right;margin-top: 35px;" onclick="location.href='/cms/api/login?m=logout'">退出登录</button>
        </h1>
      </div>

      <div class="row">
        <div class="col-md-3">
          <ul class="list-unstyled lead" id="models" style="border-right: 2px solid #e7e9ec;padding-right: 30px;margin-right: 15px;">
            {foreach $models as $model}
                <li class="board-list"><button id="model" type="button" data-model="{$model.key}" class="btn btn-primary btn-lg btn-block">{$model.name}</button></li>
            {/foreach}
          </ul>
        </div>

        <div class="col-md-9" id="panel"></div>

      </div>

      <div id="footer" class="text-center">
        <hr>
        <div class="wrapper">
          <div class="credits">
            <p>Designed and built with all the love in the world by the Nova Studio.</p>
            <div class="crew"></div>
          </div>
          <div class="copyrights">
            <p>©<a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">Nova Studio</a>&nbsp;2015.All rights reserved.</p>
          </div>
        </div>
      </div>
    </div>

{* ====个人信息管理框========================================================================================= *}

    <div class="modal fade" id="User" tabindex="-1" role="dialog" aria-labelledby="ManagerLabel" aria-hidden="false">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
            个人信息
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <div class="form-group">
                <label for="name" class="col-sm-2 control-label">昵称</label>
                <div class="col-sm-6">
                  <input maxlength="10" type="text" class="form-control" id="name" placeholder="{$user}">
                </div>
              </div>
              <div class="form-group">
                <label for="password" class="col-sm-2 control-label">新密码</label>
                <div class="col-sm-3">
                  <input type="password" class="form-control" id="password">
                </div>
                <label for="confirm" class="col-sm-2 control-label">确认密码</label>
                <div class="col-sm-3">
                  <input type="password" class="form-control" id="confirm">
                </div>
              </div>
              <div class="form-group text-center">
                <p class="text-info" id="info"><small>可单项修改，密码长度需多于六位</small></p>
                <button type="button" id="UserUpdateBtn" class="btn btn-primary" autocomplete="off">
                  提交更改
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script src="{$base}cms/js/flat-ui.min.js"></script>
    <script src="{$base}cms/js/weditor.js"></script>
    <script src="{$base}cms/js/datepicker/jquery-ui.js"></script>
    <script src="{$base}cms/js/Chart.js"></script>
    <script>
        var base = {$base};
    </script>
    <script src="{$base}cms/js/board.js"></script>
  </body>
</html>
