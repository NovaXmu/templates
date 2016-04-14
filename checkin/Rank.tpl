{*签到排行*}
<!DOCTYPE html>
<html lang="zh-cn">
	<head>
	<meta name="format-detection" content="telephone=no" />
			<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
			<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
			<script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
			{include file="common/CommonHead.tpl" }
	</head>
	<body>
	    <link rel="stylesheet" href="{$base}checkin/css/rank.css">
		<link rel="stylesheet" href="{$base}checkin/css/rank_mobile.css">
		{include file="common/Header.tpl"}
		<div id="content">
		    <div class="wrapper">
				<h2 class="title"><b>{$title}</b></h2>
				<table class="table table-hover">
				<thead>
               <tr>
               <th>排名</th>
               <th>学号</th>
               <th>签到次数</th>
               </tr>
              </thead>
                {$i=1}
                {foreach $data as $row}
                <tbody>
                 <tr>
			    <td>{$i++}</td>
                <td>{$row.num}</td>
				<td>{$row.count}</td>
                 </tr>
                {/foreach}
                </table>
	        </div>
		</div>
		</body>
		<footer>
		{include file="common/Footer.tpl"}
		</footer>
</html>
