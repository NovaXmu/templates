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
    <script src="{$base}roster/js/admin/projectList.js"></script>
  </head>
  <body>
    <!-- big content -->
      
      <!-- content right -->
      <div id='right'>
         <!-- Tools -->
      <section id='tools'>
        <ul class='breadcrumb' id='breadcrumb'>
          <li class='title' id='now' onClick=loadProject(0)>正在进行</li>
          <li class='title' id='future' onClick=loadProject(1)>即将开始</li>
          <li class='title' id='past' onClick=loadProject(-1)>已结束</li>
          <li> 
            <button class='btn btn-success' onclick=showAddProject()>
              <i class='icon-plus'>添加项目</i>
            </button>
          </li>
        </ul>
      </section>
      <!-- Content -->
      <div id='content'>
        <div class='panel panel-default'>
          <!--add Project-->
          <div id='addPanel' style='display:none'>
            <form class='form=horizontal' role='form'>
              <div class='form-group'>
                <label for='name' class='col-sm-2 control-label'>项目名称</label>
                <div class='col-sm-10'>
                  <input type='text' class='form-control' id='name' placeholder='请输入项目名称'>
                </div>
              </div>
              <div class='form-group'>
                <label for='start_time' class='col-sm-2 control-label'>项目开始时间</label>
                <div class='col-sm-10'>
                  <input type='date' class='form-control' id='start_time'>
                </div>
              </div>
              <div class='form-group'>
                <label for='end_time' class='col-sm-2 control-label'>项目结束时间</label>
                <div class='col-sm-10'>
                  <input type='date' class='form-control' id='end_time'>
                </div>
              </div>
              <div class='form-group'>
                <div class='col-sm-2 col-sm-10'>
                  <button type='subnit' class='btn btn-info' onClick=addProject()>添加</button>
                </div>
              </div>
            </form>
          </div>
          <!-- add Project end-->


        <!-- list Panel -->
        <div id='listPanel' style="display:''">
                <!-- table -->
                <table class='table'>
                  <thead>
                    <tr>
                      <th>项目名称</th>
                      <th>项目开始时间</th>
                      <th>项目结束时间</th>
                      <th>项目申报时间</th>
                      <th class='actions'>操作</th>
                    </tr>
                  </thead>
                  <tbody id='tbody'>
                   
                  </tbody>
                </table>
                <!-- table end -->
                <div class='panel-footer' id='panel-footer'>
                <ul class='pagination pagination-sm'>
                  <li>
                    <a onclick=frontPage()>上一页</a>
                  </li>
                  <li class='active'>
                    <a id='page'></a>
                  </li>
                  <li>
                    <a onclick=nextPage()>下一页</a>
                  </li>
                </ul>                     
            </div>
        </div>
        <!-- list panel end -->
      </div>
      </div>
      <!-- content right end -->
      
    <!-- big content end -->
  </body>
</html>
