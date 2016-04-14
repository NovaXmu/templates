<div id="header">
  <p id="baseUrl" style="display:none;">{$base}</p>
  <div class="row">
    <a class="glyphicon glyphicon-home" aria-hidden="true" href="/mall"></a>
    <a href="/mall/person" id="mine-entry">
      <img id="avatar" src="{$personInfo.yb_userhead}" alt="avatar" class="img-circle">
      <div>
        <p>
        我的商城
        </p>
      </div>
    </a>
  </div>
  <h4 id="username">{$personInfo.yb_usernick} (ID:{$personInfo.yb_userid})</h4>
  <h4 id="userid" style="display:none;">{$personInfo.yb_userid}</h4>
  <h4 id="balance">
  <img src="{$base}mall/img/balance_logo_white.png" alt="" id="balance-logo">
  我的网薪：
  <span class="num">{$personInfo.yb_money}</span>
  </h4>
</div>