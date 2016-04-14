<!-- 签到补领网薪 -->
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  {include file="common/CommonHead.tpl"}
  <link rel="stylesheet" href="{$base}checkin/css/index.css"></head>
<body>
  {include file="common/Header.tpl"}
  <div id="content">
    <div class="wrapper checked-in auto">
      <h2 class="title">{$title}</h2>
    </div>
    <div class="wrapper checked-in">
      <div class="icon">
              <img src="{$base}checkin/img/right.png"></div>
     {if $isPay}
      <p>
        您有
        <span class="emph order">{$count|default:"0"}</span>
        次签到网薪尚未领取
      </p>
      <p>
        累计
        <span class="emph monthCount">{$money|default:"0"}</span>
        网薪等待领取
      </p>
        <div style="text-align:center;" class="btn-view">
          <button type="button" style="background-color:#046D22;font-size:20px;height:50px;border-style:double"
          onclick="getMoney()">领取网薪</button>
        </div>
      {else}
        <p>
        您已累计签到
        <span class="emph order">{$count|default:"0"}</span>
        次
        </p>
        <p>
          累计获得
          <span class="emph monthCount">{$money|default:"0"}</span>
          网薪
        </p>
      {/if}
    </div>

    <!--<div class="wrapper remark" {if $remark == ''}style="display:none"{/if}>
      <p>{$remark}</p>
    </div>-->
  </div>
  {include file="common/Footer.tpl"}
  <script type="text/javascript" src="{$base}checkin/js/Chart.js"></script>
  <script type="text/javascript" src="{$base}common/js/WeixinApi.js?v=1"></script>
  <script type="text/javascript">
  function getMoney(){
  $.post(
    "/checkin/api/extendpay",
    {},
    function (data){
      data=jQuery.parseJSON(data);
      alert(data.errmsg);
      location.reload();
    });
}
  </script>
</body>
</html>