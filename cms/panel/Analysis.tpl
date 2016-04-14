<div class="row">
	<h4>数据展示</h4>
</div>
<div class="row analysis" style="text-align:center">
	<h6>各app用户点击量/浏览量统计</h6>

	<input type="radio" value="day" name="type"/>精确到天&#12288;
	<input type="radio" value="hour" name="type"/>精确到小时&#12288;
	<input type="radio" value="" name="type"/>不精确<br>
    <div class="day" style="margin-top:10px;">
    	start&#12288;
    	<input type='date' name='startDate'/>    
    	&#12288;to&#12288;
    	<input type='date' name='endDate'/>    
    </div>
    <div class="hour" style="margin-top:10px;display:none;">
    	选择日期&#12288
    	<input type="date" name="date"/>    
    </div>
	<button type="button" class="btn-success" id="generate" style="margin-top:10px;border-style:none;border-radius:5px;">generate</button> 

    <div class="label col-md-12" style="color:black;margin-top:20px;display:none">
    	<canvas id="cms" width="15" height="15"></canvas>
    	<span>cms&#12288;</span>
    	<canvas id="checkin" width="15" height="15"></canvas>
    	<span>checkin&#12288;</span>
    	<canvas id="mall" width="15" height="15"></canvas>
    	<span>mall&#12288;</span>
    	<canvas id="meet" width="15" height="15"></canvas>
    	<span>meet&#12288;</span>
    	<canvas id="ticket" width="15" height="15"></canvas>
    	<span>ticket&#12288;</span>
    	<canvas id="rollcall" width="15" height="15"></canvas>
    	<span>rollcall&#12288;</span>
    	<canvas id="wap" width="15" height="15"></canvas>
    	<span>wap&#12288;</span>
    	<canvas id="wechat" width="15" height="15"></canvas>
    	<span>wechat&#12288;</span>
    </div>
	<!--<canvas id="BarChart" width="900" height="500"></canvas>-->
</div>

<script type="text/javascript">
function generateChart(){
	//$(".analysis button").attr("disabled","disabled");
	$(".analysis .label").nextAll().remove();
	$(".analysis").append("<canvas id='Chart' width='900' height='500'></canvas>");

    var start=$("input[name='startDate']").val();
	var end=$("input[name='endDate']").val();
	var type=$("input[name='type']:checked").val();
	var date=$("input[name='date']").val();

	if(type=="hour"||type=="day")
		$(".label").show();
	else
		$(".label").hide();

	var ctx=$('#Chart').get(0).getContext('2d');
   
	$.get(
		"/analysis/nginx",
		{
			'start':start,
			'end':end,
			'm':"app",
			'type':type,
			'date':date
		},
		function(data){
			data=jQuery.parseJSON(data);
			if(data.errno!=0)
				alert(data.errmsg);
			else{
			if(type=="day"||type=="hour"){
				//折线图
				var Linedata = {
                    labels : [],
                    datasets : [
	                {
	                	label:"cms",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#FF0000",
		                pointColor : "#FF0000",
		                pointStrokeColor : "#fff",
		                data : []
	                },
	                {
	                	label:"checkin",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#00FF00",
		                pointColor : "#00FF00",
		                pointStrokeColor : "#fff",
		                data : []
	                },
	                {
	                	label:"mall",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#0000FF",
		                pointColor : "#0000FF",
		                pointStrokeColor : "#fff",
		                data : []
	                },
	                {
	                	label:"meet",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#FFFF00",
		                pointColor : "#FFFF00",
		                pointStrokeColor : "#fff",
		                data : []
	                },
	                {
	                	label:"ticket",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#00FFFF",
		                pointColor : "#00FFFF",
		                pointStrokeColor : "#fff",
		                data : []
	                },
	                {
	                	label:"rollcall",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#FF00FF",
		                pointColor : "#FF00FF",
		                pointStrokeColor : "#fff",
		                data : []
	                },
	                {
	                	label:"wap",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#C0C0C0",
		                pointColor : "#C0C0C0",
		                pointStrokeColor : "#fff",
		                data : []
	                },
	                {
	                	label:"wechat",
		                fillColor : "rgba(220,220,220,0.2)",
		                strokeColor : "#000000",
		                pointColor : "#000000",
		                pointStrokeColor : "#fff",
		                data : []
	                }
	                ]
                }
                for(var label in data.data){
                	Linedata['labels'].push(label);
                	var i=0;
                	for(var x in data.data[label]){
                		Linedata['datasets'][i]['data'].push(data.data[label][x]);
                		i++;
                	}
                }
                var myChart=new Chart(ctx).Line(Linedata);

			}
			else{
				//柱状图
				var Bardata={
			        labels:[],
			        datasets:[				
			        {
				        fillColor:"aquamarine",
				        strokeColor:"#fff",
				        data:[]

			        }]
		        }

		        for(var label in data.data){
			    Bardata['labels'].push(label);
       	        Bardata['datasets'][0]['data'].push(data.data[label]); 
		        }
                var mychart=new Chart(ctx).Bar(Bardata);

			}
		}
			$("#generate").removeAttr("disabled");
			
		});
}
	$(document).ready(function(){
		generateChart();

		var cms=$("#cms").get(0).getContext('2d');
		cms.fillStyle="#FF0000";
		cms.fillRect(0,0,15,15);

		var checkin=$("#checkin").get(0).getContext('2d');
		checkin.fillStyle="#00FF00";
		checkin.fillRect(0,0,15,15);

		var mall=$("#mall").get(0).getContext('2d');
		mall.fillStyle="#0000FF";
		mall.fillRect(0,0,15,15);

		var meet=$("#meet").get(0).getContext('2d');
		meet.fillStyle="#FFFF00";
		meet.fillRect(0,0,15,15);

		var ticket=$("#ticket").get(0).getContext('2d');
		ticket.fillStyle="#00FFFF";
		ticket.fillRect(0,0,15,15);

		var rollcall=$("#rollcall").get(0).getContext('2d');
		rollcall.fillStyle="#FF00FF";
		rollcall.fillRect(0,0,15,15);

		var wap=$("#wap").get(0).getContext('2d');
		wap.fillStyle="#C0C0C0";
		wap.fillRect(0,0,15,15);
		
		var wechat=$("#wechat").get(0).getContext('2d');
		wechat.fillStyle="#000000";
		wechat.fillRect(0,0,15,15);

		$("#generate").click(function(){
			$(this).attr('disabled','disabled');
			generateChart();
		});

		$("input[name='type']").change(function(){
			var type=$("input[name='type']:checked").val();
			if(type=="hour"){
				$(".day").hide();
				$(".hour").show();
			}
			else{
				$(".hour").hide();
				$(".day").show();
			}
		});
	});
</script>
