<div class="row">
	<h4>签到平台</h4>
</div>
<div class="row">
	<!--左边栏-->
	<div class="col-md-5 col-sm-6 col-xs-6">
		<h5>选定日期：<span id="question_date">2014/12/10</span></h5>
		<h5>登录人数：<span id="question_count">45</span>人</h5>

		<div id="datepicker"></div>
		
		<div class="container">
			
		</div>
		<h6>回答人数</h6>
		<div id="question_option_num"></div>
</div>	

		<!--右边栏-->
		<div class="col-md-7 col-sm-6 col-xs-6">
			
			<h6>签到问题</h6>
			<textarea id="question_content" class="form-control" rows="3" placeholder="请输入签到问题"></textarea>
			
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3">
					<h6>选择类型</h6>
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9">
					<h6>答题类型</h6>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3">
					<button onclick="question_type_change();" id="question_type_button" class="btn btn-primary  btn-block" style="background-color: rgb(52, 152, 219);">单选</button>
					<div style="display: none; background-color: rgb(52, 152, 219);" id="question_type">radio</div>
				</div>
				<div class="col-md-3 col-sm-3 col-xs-3">
					<button onclick="test_type_change();" id="test_type_button" class="btn btn-primary  btn-block" style="background-color: rgb(219, 52, 130);">问题
					</button>
				</div>
			</div>
			<h6>备注</h6>
			<div class="row">
				<div class="col-md-10 col-sm-10 col-xs-10">
					<input id="question_commend" type="text" class="form-control" placeholder="请输入备注">
				</div>
			</div>
			<div class="row">
				<div class="col-md-9 col-sm-9 col-xs-9">
					<h6>选项</h6>
				</div>
				
				<div class="col-md-3 col-sm-3 col-xs-3">
					<h6>正确答案</h6>
				</div>
			</div>
			<div id="question_option">	   
				
			</div>

			<div class="row" style="margin-bottom:200px;">
				<div class="col-md-3 col-sm-3 col-xs-3">
					<button onclick="question_option_add();" class="btn btn-primary  btn-block" style="background-color:#16A085">
					新增选项
					</button>
				</div>
				<div class="col-md-3 col-sm-3 col-xs-3">
					<button onclick="deleteAll();" class="btn btn-primary btn-block" style="background-color:#AD9999;">清空选项
					</button>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-6">
					<button id="updateBtn" onclick="question_update();" class="btn btn-primary  btn-block" style="background-color:#E74C3C">
					保存该日问题
					</button>
				</div>
				<div>
				<p style="margin-left:15px;">备注：改变选择类型或是答题类型之前要先清空已有的选项；
				</p></div>
			</div>			
		</div>
</div>
		
<!--JS配置-->
<script>

	$(document).ready(function() {
		$( "#datepicker" ).datepicker( {
			dateFormat: "yy-mm-dd",
			onSelect: function(dateText, inst) {
				$("#question_date").text(dateText);
				question_show(dateText);
			}
		} );
		var today = formatDate((new Date()),"yyyy-MM-dd");
		question_show(today);
		$("#question_date").text(today);
	} );

	function formatDate(date,format) {
		var paddNum = function(num) {
		  num += "";
		  return num.replace(/^(\d)$/,"0$1");
		}
		//指定格式字符
		var cfg = {
		   yyyy : date.getFullYear() //年 : 4位
		  ,yy : date.getFullYear().toString().substring(2)//年 : 2位
		  ,M  : date.getMonth() + 1  //月 : 如果1位的时候不补0
		  ,MM : paddNum(date.getMonth() + 1) //月 : 如果1位的时候补0
		  ,d  : date.getDate()   //日 : 如果1位的时候不补0
		  ,dd : paddNum(date.getDate())//日 : 如果1位的时候补0
		  ,hh : date.getHours()  //时
		  ,mm : date.getMinutes() //分
		  ,ss : date.getSeconds() //秒
		}
		format || (format = "yyyy-MM-dd hh:mm:ss");
		return format.replace(/([a-z])(\1)*/ig,function(m) { return cfg[m]; } );
	} 

	function question_show(dateText) {
		$.get(

			'/cms/api/checkin?m=get&date=' + dateText,

			function(data) {

				var data = eval( '(' + data + ')');

				if (data.errno == 0) {
					if(data.data.length == 0) {
						$('#question_content').val("");
						$('#question_content').attr('question-id', "");
						$("#question_option").empty();
						$('#question_count').html("0");
						$("#question_type").html("radio");
						$("#question_type_button").html("单选");
						$("#question_type_button").css("background-color","#3498DB");
						$('#question_commend').val("");
					}
					else{
						$('#question_content').attr('question-id', data.data.id);
						$('#question_count').html(data.data.count);
						$('#question_content').val(data.data.content);
						if(data.data.optionType == "radio") {
							$("#question_type").html("radio");
							$("#question_type_button").html("单选");
							$("#question_type_button").css("background-color","#3498DB");
						}
						else {
							$("#question_type").html("checkbox");
							$("#question_type_button").html("多选");
							$("#question_type_button").css("background-color","#9B59B6");
						}
						if(data.data.questionType==0)
						{
							$("#test_type_button").html("问题");
							var optionLength = data.data.option.length;
						var type=$("#question_type").html();
						$("#question_option").empty();
						for (var i=0; i<optionLength; i++) {
							$("#question_option").append('\
								<div class="input-group" style="margin-bottom:5px">\
									<span class="input-group-btn">\
										<button onclick="question_option_click(this);" onmouseover="question_option_mousemovein(this);" onmouseout="question_option_mousemoveout(this);" class="btn btn-default question_option_button" type="button" style="background-color: rgb(127, 140, 141);">选项' + (i+1) + '</button>\
									</span>\
									<input type="text" style="width:70%;position:absolute;" class="form-control question_option_input" option_key="' + letter(i) + '">\
									<input type="'+type+'" class="form-control" style="width:30px;position:absolute;bottom:3px;right:10px;" name="right" value="'+letter(i)+'">\
								</div>');
						}
						$('#question_option').find('.question_option_input').each(function(i) {
							$(this).val(data.data.option[i].value).attr("option_key", data.data.option[i].key);
							for(var j=0;j<data.data.rightAnswer.length;j++)
							{
								if(data.data.rightAnswer[j]==$(this).attr('option_key'))
									$(this).next().attr("checked","checked");
							}

						} );
						}
						else
						{
							$("#test_type_button").html("问卷");
							var optionLength = data.data.option.length;
						$("#question_option").empty();
						for (var i=0; i<optionLength; i++) {
							$("#question_option").append('\
								<div class="input-group" style="margin-bottom:5px">\
									<span class="input-group-btn">\
										<button onclick="question_option_click(this);" onmouseover="question_option_mousemovein(this);" onmouseout="question_option_mousemoveout(this);" class="btn btn-default question_option_button" type="button" style="background-color: rgb(127, 140, 141);">选项' + (i+1) + '</button>\
									</span>\
									<input type="text" class="form-control question_option_input" option_key="' + letter(i) + '">\
								</div>');
						}
						$('#question_option').find('.question_option_input').each(function(i) {
							$(this).val(data.data.option[i].value).attr("option_key", data.data.option[i].key);
						} );
						}
						
						$("#question_option_num").empty();
						for(var j=0;j<optionLength;j++){
							$("#question_option_num").append('\
								<div class="input-group" style="margin-bottom:5px">\
									<span class="input-group-btn">\
										<button  class="btn btn-default " type="button" style="background-color: rgb(127, 140, 141);">选项' + (j+1) + '</button>\
									</span>\
									<input type="text"  class="form-control question_option_input" option_key="' + letter(j) + '" >\
		                        </div>');
						}
						$('#question_option_num').find('.question_option_input').each(function(j){
							$(this).val(data.data.option[j].count).attr("option_key",data.data.option[j].key);
						});
						$('#question_commend').val(data.data.remark);
					}
				}

				else {
					alert(data.errmsg);
				}
			}
		);
	}

	function question_update() {
		
		var option = [];
        var questionType=0;
        var rightAnswer=$('input[name="right"]:checked ').prev("input").attr('option_key');
        if($("#test_type_button").html()=="问卷")
        {
        	questionType=1;
        	rightAnswer='';
        }
        else 
        {
        	if($("#question_type_button").html()=="多选")
            {
        	rightAnswer=new Array();
        	$('input:checkbox[name="right"]:checked').each(function(i){
        		var a=$(this).prev("input").attr('option_key');
        		rightAnswer.push(a);

        	});
            }
            else
        	rightAnswer=$('input[name="right"]:checked ').prev("input").attr('option_key');
           if(rightAnswer=='')
           {
        	alert("未选择正确答案");
        	return false;
           }
       }
		$('#question_option').find('.question_option_input').each(function(i) {
			
			var temp = {
				"key": $(this).attr("option_key"),
				"value": $(this).val()
			}

			option.push(temp);
		} );


		var data = {
			'content': $('#question_content').val(),
			'option': option,
			'optionType': $("#question_type").html(),
			'remark': $('#question_commend').val(),
			'questionType':questionType,
			'rightAnswer':rightAnswer
			};
        var today = formatDate((new Date()),"yyyy-MM-dd");
        var currentDate = $("#question_date").text();
        if(currentDate<today)
        {
        	alert("过去的日期无法修改！");
        	return false;
        }
		$.post(
			'/cms/api/checkin?m=update',
			{
				'time': $("#question_date").text(),
				'data': JSON.stringify(data)
			} ,
			function(data) {
				var data = eval( '(' + data + ')');
				if (data.errno == 0) {
					var today = formatDate((new Date()),"yyyy-MM-dd");
					var currentDate = $("#question_date").text();

					if (currentDate == today) {
						alert("修改成功！（当日的问题有缓存，请联系开发者刷新缓存）");
					}
					else {
						alert("修改成功！");
					}
				}
				else {
					alert(data.errmsg);
				}
			}
		);
	}

	
	$("#question_type").css("background-color","#3498DB");
	
	
	$(".question_option_button").css("background-color","#7F8C8D");


	function question_type_change() {
		//改变问题类型按钮
		if($("#question_type").html()=="radio") {
			$("#question_type").html("checkbox");
			$("#question_type_button").html("多选");
			$("#question_type_button").css("background-color","#9B59B6");
		}
		else {
			$("#question_type").html("radio");
			$("#question_type_button").html("单选");
			$("#question_type_button").css("background-color","#3498DB");
		}
	}

    	function test_type_change() {
		//改变问题/问卷类型按钮
		if($("#test_type_button").html()=="问卷") {
			$("#test_type_button").html("问题");
			$("#test_type_button").css("background-color","#f13443");
		}
		else {
			$("#test_type_button").html("问卷");
			$("#test_type_button").css("background-color","#db3482");
		}
	}
	function question_option_mousemovein(id) {
		//删除选项按钮,移进														
			$(id).html("delete");
			$(id).css("background-color","#E74C3C");
		
	}
	
	function question_option_mousemoveout(id) {
		//删除选项按钮,移出
			$(id).html("选项"+(1+$(".question_option_button").index(id)));
			$(id).css("background-color","#7F8C8D");
	}						
	
	function question_option_click(id) {
		//删除							
		$(id).parents(".input-group").eq(0).remove();		
		var length = $(".question_option_button").size();
		var count=0;
		while(count<length) {
			$(".question_option_button").eq(count).html("选项"+(1+count));
			count++;
		}
	}

	function question_option_add() {
		var index=$(".question_option_button").size();
		var type=$("#question_type").html();
		if($("#test_type_button").html()=="问卷"){
		$("#question_option").append('\
		   <div class="input-group" style="margin-bottom:5px">\
			  <span class="input-group-btn">\
				<button onclick="question_option_click(this);" onmouseover="question_option_mousemovein(this);" onmouseout="question_option_mousemoveout(this);" class="btn btn-default question_option_button" type="button">\
				</button>\
			  </span>\
			  <input type="text" class="form-control question_option_input" option_key="' + letter(index) + '">\
			</div>\
		'
		);
	}
	else
	{
			$("#question_option").append('\
		   <div class="input-group" style="margin-bottom:5px">\
			  <span class="input-group-btn">\
				<button onclick="question_option_click(this);" onmouseover="question_option_mousemovein(this);" onmouseout="question_option_mousemoveout(this);" class="btn btn-default question_option_button" type="button">\
				</button>\
			  </span>\
			  <input type="text" style="width:70%;position:absolute;" class="form-control question_option_input" option_key="' + letter(index) + '">\
			  <input type="'+type+'" class="form-control" style="width:30px;position:absolute;bottom:3px;right:10px;" name="right" value="'+letter(index)+'">\
			</div>\
		'
		);

	}
		$(".question_option_button").eq(index).css("background-color","#7F8C8D");
		$(".question_option_button").eq(index).html("选项"+(1+index));
	}

	function letter(index) {
		var arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T','U', 'V', 'W', 'X', 'Y', 'Z'];
		return arr[index];
	}

	function deleteAll(){
		$("div#question_option").empty();
	}
</script> 	 
