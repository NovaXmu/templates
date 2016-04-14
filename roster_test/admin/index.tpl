<html class='no-js' lang='en'>
  <head>
    <meta charset='utf-8'>
    <meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible'>
    <title>汉语推广南方基地——后台管理系统</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="{$base}roster/css/admin/public.css" rel="stylesheet" type="text/css" />
    <link href="{$base}roster/css/admin/dashboard.css" rel="stylesheet" type="text/css" />
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script src="http://www.novaxmu.cn/templates/cms/js/vendor/jquery.min.js"></script>
    <script>
      $(document).ready(function(){
        var superAdmin = 1;
        var projectAdmin = 2;
        switch({$user['privilege']}){
          case 1:
            loadAdminList();
            break;
          case 2:
            loadProjectList();
            break;
        }
      });
      function loadProjectList(){
        $('#right').load('/roster/project?m=projectList');
      }
      function loadAdminList(){
        $('#right').load('');
      }
    </script>
  </head>
  <body class='main page'>
    <!-- top -->
    <div class='navbar navbar-default' id='navbar'>
      <a class='navbar-brand' href='#'>
        汉语推广南方基地——后台管理系统
      </a>
      <ul class='nav navbar-nav pull-right'>
        <!-- <li>
          <a href='#'>
            <i class='icon-cog'></i>
            <button id="modifyPwd" type="button" data-model="test" style="background-color:transparent;border:0" onClick=showModifyPasswordDiv()>
            修改密码
            </button>
          </a>
        </li> -->
        <li class='dropdown user'>
          <a class='dropdown-toggle' data-toggle='dropdown' href='#'>
            <i class='icon-user'></i>
                <strong>
                    {$user['nickname']}
                </strong>
            <b class='caret'></b>
          </a>
          <ul class='dropdown-menu'>
            <li>
              <a href="/Art/cmsLogout">注销</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
    <!-- top end -->
    
    <!-- big content -->
    <div id='wrapper'>
      <!-- content left -->
      <section id='sidebar'>
        <i class='icon-align-justify icon-large' id='toggle'></i>
        <ul id='dock'>
          <li class='active launcher'>
            <i class='icon-dashboard'></i>
            <a>
            {if $user.privilege == 'projectAdmin'}
            <button id="dashboard" type="button" data-model="dashboard" style="background-color:transparent;border:0" onClick=loadProjectList()>
            项目列表
            {else}
            <button id="dashboard" type="button" data-model="dashboard" style="background-color:transparent;border:0" onClick=loadAdminList()>
            后台管理
            {/if}
            </button></a>
          </li>
        </ul>
        <div data-toggle='tooltip' id='beaker' title='Nova'></div>
      </section>
      <!-- content left end-->
      
      <!-- content right -->
      <div id='right'>
         <!-- Tools -->
      <section id='tools'>
        <ul class='breadcrumb' id='breadcrumb'>
          <li class='title'>
          </li>
        </ul>
      </section>
      <!-- Content -->
      <div id='content'>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            <i class='icon-beer icon-large'></i>
            欢迎!
            <div class='panel-tools'>
            </div>
          </div>
          <div class='panel-body'>
            
          </div>
        </div>
      </div>
      </div>
      <!-- content right end -->
      
    </div>
    <!-- big content end -->
  </body>
</html>
