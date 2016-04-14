<!DOCTYPE html>
<html>
<head>
  <title>厦大易班·返校同路人</title>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
  <meta http-equiv="Conent-Type" content="text/html;chartset=utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <link rel="stylesheet" type="text/css" media="(max-width:700px)" href="mobile.css"/>
  <link rel="stylesheet" type="text/css" media="(min-width:701px)" href="pc.css"/>
</head>
<body>
  <div class="container-view">
    <header>
      <h1>
        {$route["name"]}的同路人
      </h1>
    </header>
    <div class="list">
      <h2>
        出发日期：{$route["depart_date"]}<br>
        出发地点：{$route["depart_place"]}<br>
        到达地点：{$route["arrive_place"]}<br>
        等待时间：{$route["waitingtime"]}分钟<br>
      </h2>
      <br/>
      <div class="info">
        <table align="center">
          {if ($data|@count) != 1}
            <thead>
              <tr>
                <td align="center" class="name">姓名</td>
                <td align="center" class="depart_date">出发时间</td>
                <td align="center" class="waitingtime">可等待至</td>
                <td align="center" class="contact">联系方式</td>
              </tr>
            </thead>


            {foreach $data as $row}
              {if $row["num"] == $route["num"]}
                {continue}
              {/if}
              {if !$row}
                {break}
              {/if}
                <tr>
                  <td align="center" class="name">{$row["name"]}</td>
                  <td align="center"class="depart_date">{$row["depart_date"]}</td>
                  <td align="center" class="waitingtime">{$row["waitingtime"]}</td>
                  <td align="center" class="contact">{$row["contact"]}</td>
                </tr>
            {/foreach}
          {else}
            <tr><td>其他人都拼到车了诶，转发给同学们，看看谁还和你一起出发<td></tr>
          {/if}
          </table>
      </div>
    </div>
  </div>
</body>
<br><br><br>
<footer class="footer ">
    <div>
    <hr>
        <tr><div class="row footer-top">
          <div class="col-sm-6 col-lg-6">
            <p class="text-center" align="center">Designed and built with all the love in the world by the Nova     Studio.</p>
          </div>
        </div></tr>

        <tr><center>
            <div class="row about" style="margin:0 auto with:100%">
              <div style="margin-left:5%;width:25%;float:left">
                <h4>Leader</h4>
                <ul class="list-unstyled">
                  <ul class="list-unstyled">@.  孑良</ul>
                </ul>
              </div>
              <div style="margin-left:5%;width:25%;float:left">
                <h4>FE</h4>
                <ul class="list-unstyled">
                  <ul class="list-unstyled">@Echo</ul>
                </ul>
              </div>
              <div style="margin-left:5%;width:35%;float:left">
                <h4>SRD</h4>
                <ul class="list-unstyled">
                  <ul class="list-unstyled">@杜康</ul>
                  <ul class="list-unstyled">@Hot BALIL·</ul>
                </ul>
              </div>
            </div>
        </center></tr>


      <tr><div style="line-height:hei;height:hei;">
              <p class="text-center" align="center">©2015 <a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">  Nova Studio</a></p>
      </div></tr>
    <hr>
  </div>
</footer>


