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
    <script src="{$base}roster/js/admin/pro.js"></script>
  </head>
  <body>
    <!-- big content -->
      
      <!-- content right -->
      <div id='right'>
         <!-- Tools -->
      <section id='tools'>
        <ul class='breadcrumb' id='breadcrumb'>
          <li class='title' id='detail' onClick=loadProjectDetail()>项目详情</li>
          <li class='title' id='student' onClick=loadClass()>学员</li>
          <li class='title' id='course' onClick=loadCourse()>课程</li>
        </ul>
      </section>
      <!-- Content -->
      <div id='content'>
        <div class='panel panel-default'>
        </div>
      </div>
      <!-- content right end -->
      
    <!-- big content end -->
  </body>
</html>
