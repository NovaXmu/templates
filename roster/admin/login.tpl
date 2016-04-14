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
          <form id="cmsLogin_form">
            <fieldset class='text-center'>
              <legend>后台管理系统</legend>
              <div class='form-group'>
                <input class='form-control' placeholder='账号' type='text' id="account" name="account">
              </div>
              <div class='form-group'>
                <input class='form-control' placeholder='密码' type='password' id="password" name="password">
              </div>
              <div class='text-center'>
                <div class='checkbox'>
                  <label>
                    <input type='checkbox'>
                    记住我
                  </label>
                </div>
                <input class="btn btn-default" type="button" value="登录" onClick="cmsLogin()"/>
                <br>
              </div>
            </fieldset>
          </form>
        </div>
      </div>
    </div>
  </body>
  <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
  <script type="text/javascript"> 
        function validator(account, password){
            if(account == null || account ==''){
                alert("请输入后台账户");
                return false;
            }
            if(password == null || password == ''){
                alert("请输入密码");
                return false;
            }
            return true;
        }
        function cmsLogin(){ 
            //添加验证信息
            var account = $('#account').val();
            var password = $('#password').val();
            if(!validator(account, password)){
                return false;
            }
            $.post(
                    "/roster/api/admin/login",
                    {
                        'account':account,
                        'password':password
                    },
                    function(data){
                        var data = jQuery.parseJSON(data);
                        if(data.errno == 0){
                          window.location.href = '/roster/admin?m=index';
                        }else{
                          alert(data.errmsg);
                        }
                    });
        } 
    
        function goBack(){
            history.go(-1);
        }
    </script>
</html>
