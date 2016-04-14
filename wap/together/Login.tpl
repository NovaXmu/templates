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
	<div class="container">
		<header>
			<h1>
				同路人
				<br/>
				信息验证
			</h1>
		</header>
		<div class="form">
			<form id="contactform" action="/wap/together?m=view" method="POST" onsubmit="return check_empty()">
				{* 登录之后统一去view判断有无记录，是否需要转至插入页面 *}

				<p class="contact">
					<label for="stuNum">学号</label>
				</p>
				<input id="stuNum" name="num" placeholder="student number" required="required" tabindex="1" type="text">

				<p class="contact">
					<label for="password">密码</label>
				</p>
				<input id="password" name="pwd" placeholder="password" required="required" tabindex="2" type="password">
				{if isset($m)}
					<script type="text/javascript">
						alert("信息有误");
					</script>
				{/if}
                </p>
				<input class="buttom" name="submit" id="submit" tabindex="3" value="登录" type="submit">
			</form>
		</div>
	</div>
</body>
<br><br><br>
<footer class="footer ">
  	<div>
  	<hr>
  	  	<tr><div class="row footer-top">
  	    	<div class="col-sm-6 col-lg-6">
  	    	  <p class="text-center" align="center">Designed and built with all the love in the world by the Nova 		Studio.</p>
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
    	        <p class="text-center" align="center">©2015 <a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">	Nova Studio</a></p>
    	</div></tr>
    <hr>
  </div>
</footer>
<script type="text/javascript">
  function check_empty () {
    var num = document.getElementsByName('num')[0].value;
    var pwd = document.getElementsByName('pwd')[0].value;
    if(num && pwd)
    {
      return true;
    }
    else
    {
      alert("信息不完整");
      return false;
    }
  }
</script>
