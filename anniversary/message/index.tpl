<!DOCTYPE html>
<html style="height: 100%">
<head>
	<meta charset="utf-8">
	<meta name="title" content="厦门大学校庆留言榜-2016">
	<meta name="author" content="Zhou Xiaoqing">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="{$base}/anniversary/message/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="{$base}/anniversary/message/css/index.css?v=1">
	<link rel="stylesheet" type="text/css" href="{$base}/anniversary/message/css/slides.css?v=1">
</head>
<body>
    <div class="col-xs-12 title">
    	<img src="{$base}/anniversary/message/img/logo.png" /><span id="spec-title">逐梦百年&#12288;感恩南强</span>
    	<p>已有<span id="total">{$count}</span>人祝厦门大学生日快乐</p></div>
    <div id="barrage-container" class="col-xs-12">
    {foreach from=$messageList item=message}
    	<div>{$message['content']}</div>
    {/foreach}
    </div>
    <div id="slides" class="col-xs-12">
      <div id="world-container" class="col-xs-12"></div>
      <div id="china-container" class="col-xs-12"></div>
    </div>
	<div id="send-container" class="col-xs-12">
		<div class="input-group">
			<input type="text" class="form-control" placeholder="为校庆留言" id="message">	
			<span class="input-group-btn">
				<button class="btn btn-default" type="button" id="send" data-toggle="modal" data-target="#infoModal">送上祝福</button>
			</span>
		</div>
		<div class="team">策划：厦门大学学生公益会<br>技术：厦门大学Nova工作室</div>
	</div>

  <div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">填写信息(可选)</h4>
      </div>
      <div class="modal-body">
        <div class="input-group">
          <span class="input-group-addon" id="name">姓名</span>
          <input type="text" class="form-control" aria-describedby="name"></div>
        <div class="input-group">
          <span class="input-group-addon" id="school">学校</span>
          <input type="text" class="form-control" aria-describedby="school"></div>
        <div class="input-group">
          <span class="input-group-addon" id="tel">手机号</span>
          <input type="text" class="form-control" aria-describedby="tel"></div>
        <div class="input-group">
          <span class="input-group-addon" id="grade">毕业年份</span>
          <input type="text" class="form-control" aria-describedby="grade"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" id="btn-submit">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
    <script src="{$base}/anniversary/message/js/jquery-1.11.2.min.js"></script>
    <script src="{$base}/anniversary/message/js/bootstrap.min.js"></script>
    <script src="{$base}/anniversary/message/js/echarts.js"></script>
	<script src="{$base}/anniversary/message/js/world.js"></script>
	<script src="{$base}/anniversary/message/js/worldmap.js"></script>
	<script src="{$base}/anniversary/message/js/china.js"></script>
	<script src="{$base}/anniversary/message/js/chinamap.js"></script>
	<script src="{$base}/anniversary/message/js/jquery.slides.min.js"></script>
	<script src="{$base}/anniversary/message/js/comment.js"></script>
	<script>
	window.onload=function(){
		init_screen();
    var worldLoc={$worldLoc|json_encode};
    var chinaLoc={$chinaLoc|json_encode};
    getworldData(worldLoc);
    getchinaData(chinaLoc);

    $("#btn-submit").click(function(){
      var time=new Date().getTime()+"";
      window.location.href="http://test.novaxmu.cn/anniversary/message?v="+time+"";
    });
	}
    $(function() {

      $('#slides').slidesjs({
        width: 940,
        height: 528,
        play: {
          active: true,
          auto: true,
          interval: 10000,
          swap: true
        }
      });
    });
  </script>
</html>