<!DOCTYPE html>
<html>
<head>
	<title>厦大易班·返校同路人</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
	<meta http-equiv="Conent-Type" content="text/html;chartset=utf-8"/>
	<meta name="viewport" content="width=device-width,initial-scale=1"/>
	<link rel="stylesheet" type="text/css" media="(max-width:700px)" href="mobile.css"/>
  <link rel="stylesheet" type="text/css" media="(min-width:701px)" href="pc.css"/>
	<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>

</head>
<body>
	<div class="container">
		<header>
			<h1>
				同路人
				<br/>
				填写信息
			</h1>
		</header>
		<div class="form">
			<form id="contactform" action="/wap/together" method="post" onsubmit="return check_empty()">
				<input type="hidden" name="m" value="insert">
				<h2>你好，{$data['name']}<br>请填写以下信息，寻找一起拼车返校的同学。</h2>
			    <br/>
                {if $data['depart_date_date']}
                    <p class="contact">
                        <input type="checkbox" name="pc" {if $data['pc']} checked {/if}/>已经拼到车了
                    </p>
                {/if}
				{*
				<fieldset>
					<p class="contact">
					    <label class="vehicle">交通工具</label>
				    </p>
					        <select class="select-style" name="method">
						      <option value="coach" name="coach">汽车</option>
						      <option value="train" name="train">火车</option>
						      <option value="plane" name="plane">飞机</option>
				            </select>
			    </fieldset>
			    <p class="contact">
				   <label for="depart_date">出发时间</label>
				</p>
                <input type="date" name="depart_date" value="{$data['depart_date']}"/>

                <p class="contact">
				   <label for="arrive_date">到达时间</label>
				</p>
                <input type="date" name="arrive_date" value="{$data['arrive_date']}"/>
            	*}
            	<fieldset>
					<p class="contact">
					    <label class="depart_place">出发地点</label>
				    </p>
					        <select class="select-style" tabindex="4" name="depart_place" value="{$data['depart_place']}">
						      {* <option value="">depart_place</option> *}
							  <option value="厦门高崎国际机场">厦门高崎国际机场</option>
							  <option value="厦门火车站(梧村)">厦门火车站(梧村)</option>
							  <option value="厦门北站">厦门北站</option>
							  <option value="厦门高崎火车站">厦门高崎火车站</option>
							  <option value="枋湖汽车站">枋湖汽车站</option>
							  <option value="湖滨汽车站">湖滨汽车站</option>
							  <option value="梧村汽车站">梧村汽车站</option>
							  <option value="集美汽车站">集美汽车站</option>
							  <option value="杏林汽车站">杏林汽车站</option>
								<option value="厦大本部">厦大本部</option>
								<option value="厦大学生公寓">厦大学生公寓</option>
								<option value="厦大翔安校区">厦大翔安校区</option>
				            </select>
			    </fieldset>

                <fieldset>
					<p class="contact">
					    <label class="arrive_place">到达地点</label>
				    </p>
					        <select class="select-style" name="arrive_place" tabindex="5" value="{$data['arrive_place']}">
						      {*<option value="">arrive_place</option>*}
								<option value="厦门高崎国际机场">厦门高崎国际机场</option>
								<option value="厦门火车站(梧村)">厦门火车站(梧村)</option>
								<option value="厦门北站">厦门北站</option>
								<option value="厦门高崎火车站">厦门高崎火车站</option>
								<option value="枋湖汽车站">枋湖汽车站</option>
								<option value="湖滨汽车站">湖滨汽车站</option>
								<option value="梧村汽车站">梧村汽车站</option>
								<option value="集美汽车站">集美汽车站</option>
								<option value="杏林汽车站">杏林汽车站</option>
						      <option value="厦大本部">厦大本部</option>
						      <option value="厦大学生公寓">厦大学生公寓</option>
						      <option value="厦大翔安校区">厦大翔安校区</option>
				            </select>
			    </fieldset>
                <p class="contact">
				   <label for="depart_date">出发日期</label>
				</p>
                <input type="date" tabindex="1" require="required" name="depart_date_date" value="{$data['depart_date_date']}"/>
                <p class="contact">
				   <label for="depart_date">出发时间</label>
				</p>
                <input type="time" tabindex="2" require="required" name="depart_date_time" value="{$data['depart_date_time']}"/>

                {*
                <p class="contact">
				   <label for="arrive_date">到达时间</label>
				</p>
                <input type="date" name="arrive_date_date"/>
                <input type="time" name="depart_date_time"/>

				r="depart_place" required=""/>


			    <p class="contact">
				   <label for="arrive_place">达到地点</label>
				</p>
                <input type="text" name="arrive_place" value="{$data['arrive_place']}" placeholder="arrive_place" required=""/>
            	*}

                 <fieldset>
					<p class="contact">
					    <label class="wait_time">等待时间（分钟）</label>
				    </p>
				    <input name="waitingtime" tabindex="3" type="text" require="required" value="{$data['waitingtime']}">
				    {*
					        <select class="select-style" name="wait_time">
						      <option value="">wait_time</option>
						      <option value="30">30分钟</option>
						      <option value="60">1小时</option>
						      <option value="120">2小时</option>
						      <option value="04">3小时</option>
						      <option value="05">4小时</option>
						      <option value="06">5小时</option>
				            </select>
				    *}
			     </fieldset>



                {*
                <p class="contact">
				   <label for="flite">班次</label>
				</p>
                <input type="text" name="flight" value="{$data['flight']}" placeholder="flight" required=""/>
            	*}

			    <p class="contact">
					<label for="phone">手机号码</label>
				</p>
					<input id="phone" name="contact" tabindex="6" require="required" value="{$data['contact']}" placeholder="phone number" type="text">

				<p/>

				<input class="buttom" id="submit" tabindex="7" value="提交" type="submit">

			</form>
		</div>
	</div>
</body>
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
<script>
	$(document).ready(function() {
	$('select[name=arrive_place] option').each(function() {
		var d = $('select[name=arrive_place]').attr("value");
		if($(this).val() == d) {
			$(this).attr("selected","selected");
		}
	});
	$('select[name=depart_place] option').each(function() {
		var d = $('select[name=depart_place]').attr("value");
		if($(this).val() == d) {
			$(this).attr("selected","selected");
		}
	});
});

	function check_empty () {
		var depart_date_date = document.getElementsByName('depart_date_date')[0].value;
		var depart_date_time = document.getElementsByName('depart_date_time')[0].value;
		var waitingtime = document.getElementsByName('waitingtime')[0].value;
		var contact = document.getElementsByName('contact')[0].value;
		if(depart_date_time && depart_date_date && waitingtime && contact)
		{
			$.ajax({
				type: "POST",
				url: "/wap/together?m=insert",
				data: $('#contactform').serialize(),
				success: function(data) {
					data = JSON.parse(data);
					if (data.errno == 0){
						window.location.href= '/wap/together?m=view';
					} else {
						alert(data.errmsg);
					}
				}
			});
			return false;
		}
		else
		{
			alert("信息不完整");
			return false;
		}
	}

</script>
