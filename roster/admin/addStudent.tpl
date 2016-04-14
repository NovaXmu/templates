<!DOCTYPE html>
<html class='no-js' lang='en'>
  <head>
    <meta charset='utf-8'>
    <meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible'>
    <title>汉语推广南方基地——项目后台</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
  </head>
  <body class='login'>
    <div class='wrapper'>
      <div class='row'>
        <div class='col-lg-12'>
          <div class='brand text-center'>
            <h2>
              汉语推广南方基地
            </h2>
          </div>
        </div>
      </div>
      <div class='row'>
        <div class='col-lg-12'>
          <form method='post' action='/roster/api/admin/project?m=addStudent' enctype='multipart/form-data'>
              <h3>导入Excel表：</h3>
              <input type='file' name='file_stu'/>
              <input type='submit' value="导入"/>
            </form>
        </div>
      </div>
    </div>
  </body>
  <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
  <script type="text/javascript"> 
        function add(){
          var file = $('#file').val();
          $.post(
              "/roster/api/admin/project?m=addStudent",
              {
                'file_stu':file,
                'projectId':1,
                'classId':3
              },
              function(data){
                var data = jQuery.parseJSON(data);
                if(data.errno == 0){
                  alert(data.errmsg);
                }else{
                  alert(data.errmsg);
                }
              }
            )
        }
    </script>
</html>
