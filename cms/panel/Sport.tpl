<style>
	#options {
		width: 35%;
		float: left;
	}
	#options select {
		width: 80%;
		margin-bottom: 1em;
	}
	#logs {
		width: 65%;
		float: left;
	}
	caption {
		font-weight: bold;
		font-size: 150%;
		text-align: center;
	}
</style>

<div class="row" style="height:60px;position:relative">
	<h4 style="display:inline;line-height:60px;">运动会</h4>
	<button type="button" class="btn-info" style="border:none;position:absolute;margin-left:20px;top:25%;border-radius:5px;" data-toggle="modal" data-target="#newProject">新建项目</button>
</div>
<div class="row" style="margin-bottom: 20px;">
	<ul class="nav nav-tabs nav-justified" role="tablist" id="sportNav">
		<li role="presentation" class="active" data-id="upload" id="uploadGrade">
			<a role="tab" class="text-muted" data-toggle="tab" aria-controls="uploadContent" href="#uploadContent">上传成绩</a>
		</li>
		<li role="presentation" data-id="history" id="historyGrade">
			<a role="tab" class="text-info" data-toggle="tab" aria-controls="log" href="#log">历史成绩</a>
		</li>
	</ul>
</div>

<div class="tab-content">
	<div class="row tab-pane active" id="uploadContent">
		<div class="col-md-4" data-id="item">
			<select class="item" onchange="getScore()"></select>
		</div>
		<div class="col-md-4" data-id="xueyuan">
			<select class="type" onchange="getScore()">
				<option value="1">本科生</option>
				<option value="2">研究生</option>
			</select>
		</div>
		<!--<div class="col-md-2">
			<button type="button" class="btn-info btn-sm btn-show" onclick="getScore()" style="border:none;">显示分数</button>
		</div>-->
		<div class="col-md-2">
			<button type="button" class="btn-info btn-sm btn-empty" style="border:none;">清空数据</button>
		</div>
		<div class="col-md-2">
			<button type="button" class="btn-success btn-sm btn-upload" style="border:none;">上传数据</button>
		</div>
		<div id="xueyuan">
			<ul style="list-style:none;width:800px;padding:15px;">
			</ul>
		</div>
	</div>

	<div class="row tab-pane" id="log">
		<div id="options">
			<strong>多选栏按住<em>Ctrl</em>键选择，<em>Ctrl+A</em>全选</strong>
			<select class="item"></select>
			<select class="xueyuans" style="height: 20em;" multiple></select>
			<select class="years" multiple></select>
			<select class="types" style="height: 3em;" multiple>
				<option value="1" selected>本科生</option>
				<option value="2" selected>研究生</option>
			</select>
		</div>
		<div id="logs">

		</div>
	</div>
</div>

<div class="modal fade" id="newProject" tabindex="-1" role="dialog" aria-labelledby="newProjectModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">新建项目</h4>
      </div>
      <div class="modal-body">
      <label style="font-size:20px;width:25%">项目名称</label>
      <input type="text" id="projectName"/>
      <button type="button" class="btn-info btn-newProject" style="margin-left:10px;">确定</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	//@ sourceURL=sports.js
	$(document).ready(function(){
		selectView();

		/*$("#uploadGrade").click(function(){
			$(".uploadContent").show();
		});
		$("#historyGrade").click(function(){
			$(".uploadContent").hide();
		});*/
	});
	function selectView() {
		var thisYear = new Date().getFullYear();
		for ( var y=2014; y <= new Date().getFullYear(); y++ ) {
			if ( y == thisYear ) {
				$("select.years").append('<option selected value="'+ y +'">' + y + '</option>');
			} else {
				$("select.years").append('<option value="'+ y +'">' + y + '</option>');
			}
		}
		$.post(
			"/cms/api/sport?m=index",
			function( data ){
				data=jQuery.parseJSON(data);
				for( var i = 0; i < data.itemList.length; i++ ) {
					if ( !data.itemList[i] ) continue;
					$("select.item").each(function(index) {
						if (index == 0) {
							$(this).append('<option value="'+data.itemList[i]['id']+'">'+data.itemList[i]['name']+'</option>');
						} else {
							$(this).append('<option value="'+data.itemList[i]['id']+'">'+data.itemList[i]['name']+'</option>');
						}
					});
			    }

			    for( var j = 0; j < data.xueyuanList.length; j++ ) {
					if ( !data.xueyuanList[j] ) continue;
					var score = data.scoreList[j]? data.scoreList[j]['score'] : "";
			    	$("div#xueyuan ul").append('\
			    		<li style="width:380px;float:left;dispaly:inline;" data-id="'+data.xueyuanList[j]['id']+'">\
			    		<label style="width:63%;font-size:18px;">'+data.xueyuanList[j]['xueyuan']+'</label>\
			    		<input type="text" value="'+ score +'" style="width:20%;height:25px;vertical-align:middle;line-height:25px;"/>\
			    		</li>');
					$(".xueyuans").append('<option selected value="'+ data.xueyuanList[j]['id'] +'">' + data.xueyuanList[j]['xueyuan'] + '</option>');
			    }

				getHistory();
			}
		);
	}

	function getScore(){
		var item_id=$("#uploadContent select.item option:selected").val();
		var type=$("#uploadContent select.type option:selected").val();
		$.get(
			"/cms/api/sport?m=getScore",
			{
				'item_id':item_id,
				'type':type
			},
			function(data){
				data=jQuery.parseJSON(data);
				if(data.length==0)
					$(".btn-empty").click();
				else
				{
					var i=0;
					$("#xueyuan ul li").each(function(){
						if(data[i]['xueyuan_id']==$(this).data("id")){
							$(this).children("input").val(data[i]['score']);
			                i++;
						}
			            
		            });
				}
			});
	}

	$(".btn-empty").click(function(){
		$("#xueyuan ul li").each(function(){
			$(this).children("input").val("");
		});
	});
	$(".btn-upload").click(function(){
		$(this).attr("disabled",true);
		var itemId=$("#uploadContent select.item option:selected").val();
		var type=$("#uploadContent select.type option:selected").val();
		var score_arr = new Array();
		$("#xueyuan ul li").each(function(){
			var score=$(this).children("input").val();
			if(score==""){
				score=0;
			}
			score_arr.push(score);
		});
		$.post(
			"/cms/api/sport?m=addScore",
			{
				'item_id':itemId,
				'type':type,
				'score_arr':JSON.stringify(score_arr)
			},
			function(data){
				$(".btn-upload").attr("disabled",false);
				data=jQuery.parseJSON(data);
				if(data.errno==0) {
					alert("上传成功！");
				} else
					alert(data.errmsg);
			}
		);
	});
	$(".btn-newProject").click(function(){
		var name=$("#projectName").val();
		$.post(
				"/cms/api/sport?m=addItem",
				{
					'name':name
				},
				function(response){
					response=jQuery.parseJSON(response);
					if(response.errno==0){
						alert("创建成功！");
						$("select.item").each(function() {
							$(this).append('<option value="'+ response.data +'">'+ name +'</option>');
						});
					} else {
						alert(response.errmsg);
					}
					$("#newProject .close").click();
				}
		);
	});

	function getHistory() {
		var item = $("#log .item").find("option:selected").val();
		var itemName = $("#log .item").find("option:selected").text();
		var xueyuanIds = [];
		var years = [];
		var type = $("#log .types").find("option:selected").size() == 1? $("#log .types").find("option:selected").val() : null;
		var typeText = type==1? "本科生分数" : type==2? "研究生分数" : " ";
		$("#log .xueyuans").find("option:selected").each(function() {
			xueyuanIds.push($(this).val());
		});
		$("#log .years").find("option:selected").each(function() {
			years.push($(this).val());
		});
		$.get(
				'/cms/api/sport?m=history&item=' + item,
				{
					xueyuanIds: JSON.stringify(xueyuanIds),
					years: JSON.stringify(years),
					type: type
				}, function(response) {
					if ( response.errno == 0 ) {
						$("#logs").empty();
						var history = response.data.historyData;
						var xyNameList = response.data.xueyuan;
						for ( var year in history ) {
							var list = history[year];
							var table = $('<table class="table table-striped table-bordered">\
							<caption>' + year + "&nbsp;&nbsp;&nbsp;" +  itemName + "&nbsp;&nbsp;&nbsp;" + typeText + '</caption>\
								<thead>\
								<tr>\
								<td>学院</td>\
								<td>分数</td>\
								<td>时间</td>\
								</tr>\
								</thead>\
								<tbody>\
								</tbody>\
								</table>');
							for ( var i in list ) {
								if ( !list[i] ) continue;
								table.find("tbody").append("<tr><td>"+ xyNameList[list[i]["xueyuan_id"]-1] +"</td><td>"+ list[i]["score"] +"</td><td>"+ list[i]["time"] +"</td></tr>");
							}
							$("#logs").append(table);
						}
					} else {
						alert(response.errmsg);
					}
				}, "JSON"
		);
	}

	$("#options select").on("change", getHistory);
</script>