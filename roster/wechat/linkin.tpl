<!DOCTYPE html>
<html lang=zh>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">    

    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />    

    <meta http-equiv="Pragma" content="no-cache" />    

    <meta http-equiv="Expires" content="0" />    

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/public.css?v=1.0">
    <link rel="stylesheet" type="text/css" href="{$base}/roster/wechat/css/index.css?v=4.0"></head>
<body>
<input type="text">
<div class=".container">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2 centered content">
            <img src="{$base}/roster/wechat/img/index.png" id="main">
            <img src="{$base}/roster/wechat/img/logo.png" id="logo">
            <div class="warning"></div>
            <img src="{$base}/roster/wechat/img/tel.png" id="tel">
            <input type="text" id="input-tel">
            <button type="button" class="btn-bind" onClick="linkin()">
                <img src="{$base}/roster/wechat/img/bind.png"></button>
        </div>
    </div>
</div>
    
</body>
<script src="{$base}/roster/wechat/js/jquery-1.12.0.min.js"></script>
<script src="{$base}/roster/wechat/js/bootstrap.min.js"></script>
<script type="text/javascript">
    window.onload=function(){
        var height=document.documentElement.clientHeight;
        $("div.content").css("height",height);
        $("#input-tel").val("请输入手机号");
        $("#input-tel").focus(function(){
            if($(this).val()=="请输入手机号")
                $(this).val("");
        });
        $("#input-tel").blur(function(){
            if($(this).val()=="")
                $(this).val("请输入手机号");
        });
        alert("document.documentElement.clientHeight:"+document.documentElement.clientHeight+"\n"+"window.screen.availHeight="+window.screen.availHeight+"\n"+"document.body.clientHeight="+document.body.clientHeight+"\n"+"document.body.offsetHeight="+document.body.offsetHeight+"\n"+"document.body.scrollHeight="+document.body.scrollHeight+"\n"+"window.screen.height="+window.screen.height);
        
        
        function linkin(){
        var telephone = $('#input_tel').val();
        if(telephone == 0){
            alert('请填写手机号码');
            return false;
        }
        $.ajax({
            url:'/roster/api/linkin',
            type:'GET',
            data:{
                'telephone':telephone,
                'openid':{$openid}
            },
            success:function(data){
                var data=jQuery.parseJSON(data);
                if(data.errno==0){
                    $(".warning").text("绑定成功");
                    window.location.href={$base} + '../roster/wechat?m=projectList';
                }
                else
                    $(".warning").text("绑定失败，请重新输入手机号码");
            }
        });
    }
    }
</script>

</html>
