<!DOCTYPE html>
<html lang=zh>
	<head>
		<meta charset="utf-8">
		<title></title>
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="{$base}mall/css/public.css">
		<link rel="stylesheet" href="{$base}mall/css/gamelist.css">
		<link rel="stylesheet" href="{$base}mall/css/bobing.css">
		{include file="mall/styleTag.tpl"}
	</head>
	<body class="game">
		
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 centered" id="main">
				{include file="mall/Header.tpl"}
				<div id="content">
					<div id = "main-content" class="bg">
						<div id = "panel">
							<div id = "picture-area">
								<img class = "bowl" src="{$base}mall/img/bobing/wan.png">
							</div>
							<p id = "button-area" class="text-center">
							<button type="button" class="btn btn-success btn-lg" id="submitbutton">手气不错</button>
							</p>
							<p class = "text-center" id = "notice"></p>
						</div>
					</div>
				</div>
				
				{include file="mall/Footer.tpl"}
			</div>
		</div>
		
		{include file="mall/scriptTag.tpl"}
		<script>
			function ChangeHTML()
		{
		document.getElementById('notice').innerHTML = '';
		document.getElementById('picture-area').innerHTML = '<img class = "bowl" src="{$base}mall/img/bobing/active.gif">';
		document.getElementById('button-area').innerHTML = '<button type="button" class="btn btn-primary btn-lg" disabled = "disabled">博饼中……</button>';
		var t = setTimeout(SendRequest, 3000);
		}
		function SendRequest() {
		$.get(
		'/mall/api/bobing?m=bobing',
		function(data, status) {
			if (status == 'success') {
				var data = JSON.parse(data);
				if(data.errno == 0) {
					var dice = data.data.dice;
					var result = data.data.money;
					var remaintimes = data.data.remainTimes;
					var bobingLevel = data.data.bobingLeval;
					document.getElementById('picture-area').innerHTML = '';
					for (var i = 0; i < 6; i++) {
						
							document.getElementById('picture-area').innerHTML += '<img class = "dice" src="{$base}mall/img/bobing/' + dice[i] + '.png">';
						
					}
		
					if (remaintimes > 0) {
						document.getElementById('button-area').innerHTML = '<button type="button" class="btn btn-success btn-lg" onclick=ChangeHTML();>再来试试</button>';
					} else {
						document.getElementById('button-area').innerHTML = '<p class="text-center">很抱歉，你今天已经用完了博饼机会，明天再来吧</p>';
					}
						document.getElementById('notice').innerHTML = '你赢得了：'
						document.getElementById('notice').innerHTML += '<span class="text-center" id="diceresult">' + result + '网薪</span>';
						document.getElementById('notice').innerHTML += '<p class="text-center" id="bobingLevel">' + bobingLevel;
				} else {
					document.getElementById('picture-area').innerHTML = '<img class = "bowl" src="{$base}mall/img/bobing/wan.png">';
					document.getElementById('button-area').innerHTML = '';
					document.getElementById('notice').innerHTML = data.errmsg;
				}
			} else {
				alert("请求失败，网络故障");
			}
		}
		);
		}
		
		document.getElementById('submitbutton').onclick = ChangeHTML;
		</script>
	</body>
</html>