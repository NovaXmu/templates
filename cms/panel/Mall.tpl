<div class="row">
	<h4>礼品管理
	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#addModal" id="add" style="margin-left:10px;">新增礼品</button>
	<button type="button" class="btn btn-success" data-toggle="modal" data-target="#exchangeModal" id="exchange">兑换商品</button>
	<button type="button" class="btn btn-default" data-toggle="modal" data-target="#configModal" id="config">设置</button>
	</h4>
</div>
<div class="row" style="margin-bottom: 20px;">
	<ul class="nav nav-tabs nav-justified" role="tablist" id="mallNav">
		<li role="presentation" class="active" data-id="new"><a role="tab" class="text-muted" data-toggle="tab" aria-expanded="true">新礼品</a></li>
		<li role="presentation" data-id="onSell"><a role="tab" class="text-succes" data-toggle="tab" aria-expanded="false">已上架</a>
	</li>
	<li role="presentation" data-id="offSell"><a role="tab" class="text-warning" data-toggle="tab"
	aria-expanded="false">已下架</a></li>
</ul>
</div>
<div class="row" id="mallContent">
{if is_array($newItems)}
{foreach $newItems as $item}
<div class="panel panel-default" id="p{$it888em.id}">
	<div class="panel-heading" data-id="">新礼品</div>
	<div class="row">
		<div class="col-xs-2">
			<img src="{$item.pic}" alt="商品图片" style="width:100%;">
		</div>
		<div class="col-xs-10">
			<table class="table table-hover table-condensed">
				<tbody>
					<tr>
						<td class="id" style="display:none;">{$item.id}</td>
						<td>名称</td>
						<td>{$item.name}</td>
						<td>限制条件</td>
						<td>
							经验：
							{if array_key_exists("jy",$item.limitConds)}
								{if $item.limitConds["jy"] > 0}
								大于{$item.limitConds["jy"]}
								{elseif $item.limitConds["jy"] < 0}
								小于{-$item.limitConds["jy"]}
								{elseif $item.limitConds["jy"] == "" ||  $item.limitConds["jy"] == 0}
								无限制
								{/if}
							{else}
								无限制
							{/if}
							<br>
							性别：
							{if array_key_exists("sex",$item.limitConds)}
								{if $item.limitConds["sex"] == "M"}
								男
								{elseif $item.limitConds["sex"] == "F"}
								女
								{else}
								无限制
								{/if}
							{else}
								无限制
							{/if}
							<br>
							注册时间：
							{if array_key_exists("registTime",$item.limitConds)}
								{if $item.limitConds["registTime"] > 0}
								晚于{$item.limitConds["registTime"]|date_format:'%Y-%m-%d %H:%M'}
								{elseif $item.limitConds["registTime"] < 0}
								早于{abs($item.limitConds["registTime"])|date_format:'%Y-%m-%d %H:%M'}
								
								{elseif $item.limitConds["registTime"] == "" ||  $item.limitConds["registTime"] == 0}
								无限制
								{/if}
							{else}
								无限制
							{/if}
							<br>
							每人限购：
							{if array_key_exists("amountLimit",$item.limitConds)}
								{if $item.limitConds["amountLimit"] == ""||$item.limitConds["amountLimit"] == 0}
								无限制
								{else}
								{$item.limitConds["amountLimit"]}
								{/if}
							{else}
								无限制
							{/if}
						</td>
						
					</tr>
					<tr>
						<td>价格</td>
						<td>{$item.price}</td>
					</tr>
					<tr>
						<td>开始时间</td>
						<td>{$item.startTime}</td>
						<td>结束时间</td>
						<td>{$item.endTime}</td>
					</tr>
					<tr>
						<td>所属商城</td>
						<td>{if $item.type == 1}兑换商城{else}竞价商城{/if}</td>
						<td>本次上架数量</td>
						<td>{$item.amount}</td>
					</tr>
					<tr>
						<td>已购买数</td>
						<td class="boughtAmount">0</td>
						<td>已兑换数</td>
						<td class="usedAmount">0</td>
					</tr>
					<tr>
						<td>浏览量</td>
						<td class="itemViewed">0</td>
						<td>商品详情</td>
						<td colspan="" class="description">{$item.description}</td>
					</tr>
					
				</tbody>
			</table>
		</div> 
	</div>
	<div class="panel-footer text-right">
		<button type="button" class="btn btn-sm btn-info" onclick="operateItem({$item.id},'setOn')">上架</button>
		<button type="button" class="btn btn-sm btn-warning" onclick="modifyBtnCallback(this)">修改</button>
		<button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#delConfirmModal">删除</button>
	</div>
	
</div>
{/foreach}
{/if}
</div>
{* ajax填充模板 *}
<div style="display: none;" id="mallPanel">
<div class="panel panel-default" id="">
	<div class="panel-heading" data-id="">新礼品</div>
	<div class="row">
		<div class="col-xs-2">
			<img src="" alt="商品图片" class="item-pic" style="width:100%;">
		</div>
		<div class="col-xs-10">
			<table class="table table-hover table-condensed">
				<tbody>
					<tr>
						<td class="id" style="display:none;"></td>
						<td>名称</td>
						<td class="item-name"></td>
						<td>限制条件</td>
						<td class="item-limitconds">
							<span class="limit"></span>
							<span class="limit-value"></span>
							<br>
						</td>
						
					</tr>
					<tr>
						<td>价格</td>
						<td class="item-price"></td>
					</tr>
					<tr>
						<td>开始时间</td>
						<td class="startTime"></td>
						<td>结束时间</td>
						<td class="endTime"></td>
					</tr>
					<tr>
						<td>所属商城</td>
						<td class="type"></td>
						<td>本次上架数量</td>
						<td class="item-amount"></td>
					</tr>
					<tr>
						<td>已购买数</td>
						<td class="boughtAmount"></td>
						<td>已兑换数</td>
						<td class="usedAmount"></td>
					</tr>
					<tr>
						<td>浏览量</td>
						<td class="itemViewed"></td>
						<td>商品详情</td>
						<td colspan="" class="description"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="panel-footer text-right">
		<button type="button" class="btn btn-sm operation"></button>
	</div>
</div>
</div>
{* 新增礼品模态框 *}
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel">新增礼品</h4>
		</div>
		<div class="modal-body">
			<div class="row">
				{* 表单左（上传图片） *}
				{* <iframe src="" name="myframe" id="myframe" style="display:none;" onload="getData()"></iframe> *}
				<div class="col-xs-3">
					<form action="http://wechatyiban.xmu.edu.cn/uploadFile.php" enctype="multipart/form-data" method="post" target="myframe">
						<input type="file" name="file" id="file" class="form-control" style="height:127px;">
						<input type="hidden" name="name" id="picName">
						<input type="hidden" name="dir" value="mall">
						<input type="submit" id="upload" style="display:none;">
					</form>
				</div>
				{* 表单右 *}
				<div class="col-xs-9">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="name" class="col-xs-3">名称</label>
							<div class="col-xs-9">
								<input type="text" class="form-control" name="name" id="name">
							</div>
						</div>
						<div class="form-group">
							<label for="price" class="col-xs-3">价格</label>
							<div class="col-xs-9">
								<input type="text" class="form-control" name="price" id="price">
							</div>
						</div>
						<div class="form-group">
							<label for="type" class="col-xs-3">所属商城</label>
							<div class="col-xs-9">
								<select name="type" id="type" class="form-control">
									<option value="1">兑换商城</option>
									<option value="0">竞价商城</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="amount" class="col-xs-3">本次上架数量</label>
							<div class="col-xs-9">
								<input type="text" class="form-control" name="amount" id="amount">
							</div>
						</div>
						<div class="form-group">
							<label for="condition" class="col-xs-3">限制条件（可选）</label>
							<div class="col-xs-9">
								经验：
								<div class="row">
									<div class="col-xs-4">
										<select name="limit1" id="limit1" class="form-control">
											<option value="gt">大于</option>
											<option value="lt">小于</option>
										</select>
									</div>
									<div class="col-xs-8">
										<input type="text" name="conditionVal" id="conditionVal" class="form-control">
									</div>
								</div>

								{* 性别 *}
								性别：
								<div class="row">
									<div class="col-xs-4">
										<select name="limit2" id="limit2" class="form-control">
											<option value="">不限</option>
											<option value="m">男</option>
											<option value="f">女</option>
										</select>
									</div>
								</div>

								{* 每人限购 *}
								每人限购：
								<div class="row">
									<div class="col-xs-4">
										<input type="text" name="amountLimit" id="amountLimit" class="form-control">
									</div>
								</div>
								
								{* 注册时间 *}
								注册时间：
								<div class="row">
									<div class="col-xs-4">
										<select name="limit4" id="limit4" class="form-control">
											<option value="gt">晚于</option>
											<option value="lt">早于</option>
										</select>
									</div>
									<div class="col-xs-8">
										<input type="datetime-local" class="form-control" id="regTime" name="regTime">
									</div>
								</div>
							</div>
						</div>
						<div class="form-group setTime" style="display:none;">
							<label for="startTime" class="col-xs-3">竞价开始时间</label>
							<div class="col-xs-9">
								<input type="datetime-local" class="form-control" id="startTime" name="startTime">
							</div>
						</div>
						<div class="form-group setTime" style="display:none;">
							<label for="endTime" class="col-xs-3">竞价结束时间</label>
							<div class="col-xs-9">
								<input type="datetime-local" class="form-control" id="endTime" name="endTime">
							</div>
						</div>
						<div class="form-group">
							<label for="detail" class="col-xs-3">商品详情</label>
							<div class="col-xs-9">
								<textarea class="form-control" id="detail"></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" id="addP">保存</button>
		</div>
	</div>
</div>
</div>

{* 兑换名单模态框 *}
<div class="modal fade" id="purchaseLogModal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog modal-lg">
	<div class="modal-content">
		
		<div class="modal-body">
			<div class="row">
				<table class="table table-striped">
  					<tbody>
  						
  					</tbody>
				</table>
			</div>	
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	</div>
</div>
</div>
</div>

{* 设置模态框 *}
<div class="modal fade" id="configModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">设置</h4>
			</div>
			<div class="modal-body" style="text-align:center;">
				<div class="row">
						<select name="config" id="configOption">
							<option value="">请选择设置类型</option>
							<option value="bobingDailyTimes">每日博饼次数</option>
							<option value="itemEffectiveDay">token有效时间（天）</option>
							<option value="availableKinds">可兑换种类</option>
							<option value="awardTimes">博饼奖励倍数</option>
						</select>
					<input type="text" pattern="" title="只能输入数字" class="configVal"/>
					<span class="msg"></span>
				</div>
				{*<div class="row">
					<div class="col-xs-3"><span>每日博饼次数</span></div>
					<div class="col-xs-5"><input type="text" pattern="^[0-9]*$" title="只能输入数字"/></div>
				</div>
				<div class="row">
					<div class="col-xs-3"><span>token有效时间</span></div>
					<div class="col-xs-5"><input type="datetime-local"/></div>
				</div>
				<div class="row">
					<div class="col-xs-3"><span>每日博饼次数</span></div>
					<div class="col-xs-5"><input type="text" pattern="^[0-9]*$" title="只能输入数字"/></div>
				</div>*}
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="saveConfig">保存</button>
			</div>
		</div>
	</div>
</div>

{* 商品兑换模态框 *}
<div class="modal fade" id="exchangeModal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel">商品兑换</h4>
		</div>
		<div class="modal-body" style="text-align:center;">
			<form>
				<div class="row">
					<div class="col-xs-8 col-xs-offset-2">
						<input type="text" id="exg-token" class="form-control input-lg" placeholder="输入兑换密钥" style="height:60px;font-size:30px;margin-bottom:10px;">
						<div id="exg-response"></div>
					</div>
				</div>
				<div class="row">
					<button type="button" class="btn btn-info btn-lg" id="queryBtn" onclick="query()">查询</button>
					<button type="button" class="btn btn-info btn-lg" id="exchangeBtn" onclick="exchange(this)" style="display:none;">兑换</button>
					<button type="button" class="btn btn-info btn-lg" id="closeBtn" data-dismiss="modal" aria-label="Close" style="display:none;">关闭</button>
				</div>
			</form>
		</div>
	</div>
</div>
</div>

{* 删除确认 *} 
<div class="modal fade" id="delConfirmModal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
	<div class="modal-content">
		<!-- <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel">确认</h4>
		</div> -->
		<div class="modal-body" style="text-align:center;">
			删除后将不可恢复，确认删除吗？
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			<button type="button" class="btn btn-primary" id="del-btn">确认</button>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
	//# sourceURL=dynamicScript.js
	jQuery(document).ready(function($) {
		fixStyle();
		$("select#type").change(function(event) {
			if($(this).val()=="0"){
				$(".setTime").show();
			}
			if($(this).val()!="0"){
				$(".setTime").hide();
			}
		});
	});
	function fixStyle() {
		$(".panel table").css("table-layout","fixed");
		$(".panel td").css({
			'border-top': '0',
			'word-break': 'break-word'
		});
	}
/***************************添加礼品******************************************/
	// 检查输入是否合法
	function txtFieldReadyForAdd() {
		if(!$("#name").val() || $("#name").val()=="") {
			alert("请输入商品名");
			return false;
		}
		if(!$("#price").val() || $("#price").val()=="") {
			alert("请输入商品价格");
			return false;
		} else if(!/^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$/.test($.trim($("#price").val())) && !/^[1-9]\d*$/.test($("#price").val())) {
			alert("价格必须是数字");
			return false;
		}
		if(!$("#type").val() || $("#type").val()=="") {
			alert("请选择所属商城");
			return false;
		}
		if(!$("#amount").val() || $("#amount").val()=="") {
			alert("请输入本次上架数量");
			return false;
		} else if(!/^[1-9]\d*$/.test($.trim($("#amount").val()))){
			alert("上架数量必须是大于0的整数");
			return false;
		}
		if($("#conditionVal").val()!="") {
			if(!/^([1-9]\d*(\.\d+)?|0)$/.test($.trim($("#conditionVal").val())) && !/^[1-9]\d*$/.test($("#conditionVal").val())) {
				alert("条件值必须是大于或等于0的数字，也可不填，表示无限制");
				return false;
			}
		}
		return true;
	}
	//“保存”按钮动态触发隐藏的文件上传按钮
	$("#addP").unbind("click").bind("click", addP);
	function addP(event) {
		event.stopPropagation();
		if(txtFieldReadyForAdd()) {
			if($("input[name=file]").val()=="") {
				alert("你是不是忘了上传商品图片？");
				return;
			}
			$("#addP").attr("disabled","true");
			//动态生成iframe，等待接收跨域请求的返回值
			$("body").append('<iframe src="" name="myframe" id="myframe" style="display:none;"></iframe>');
			var iframe = document.getElementById("myframe");
			$("#myframe").attr("src","http://wechatyiban.xmu.edu.cn/uploadFile.php");
			if(iframe.attachEvent){
				iframe.attachEvent("onload", getData);
			} else {
				iframe.onload = getData;
			}
			$("#picName").val($("#name").val());
			$("input[name=dir]").val("mall");
			$("#upload").click();
			//以上代码将触发iframe元素的onload事件，onload事件将执行getData()函数
		}
	}
	//获取跨域传输的返回数据
	function getData() {
		var iframe = document.getElementById("myframe");
		iframe.onload = function() {
			var data = iframe.contentWindow.name;
			var json = $.parseJSON(data);
			if(json.errno != 0) { //文件上传出错，提示并销毁这次请求
				alert(json.errmsg);
				destroyIframe();
				$("#addP").removeAttr('disabled');
				return;
			}
			//上传成功，带着返回值去提交第二个表单
			add(data,"add",null);
		}
		iframe.src = document.domain + '/cms/board/a.html';
	}
	//提交表单数据，添加商品
	//参数pic为跨域传输后获取到的返回值，将再次发送给后端
	function add(msg, t, id) {
		$("#addP").attr("disabled","true");
		var regTime = $("#regTime").val();
		if (regTime != "") {
			var regTimeInMillis = parseDate(regTime);
		} else var regTimeInMillis = "";
		if(txtFieldReadyForAdd()) {
			
			$.get(
				'/cms/api/mall',
				{
					m: t,
					id: id,
					name: $("#name").val(),
					price: $.trim($("#price").val()),
					amount: $.trim($("#amount").val()),
					type: $("#type").val(),
					limitConds: 
						{
							"jy": $("#limit1").val()=="gt"? $("#conditionVal").val():-(parseInt($("#conditionVal").val())),
							"sex": $("#limit2").val()!="m"&&$("#limit2").val()!="f"? "":($("#limit2").val()=="m"? "M":"F"),
							"amountLimit": $("input#amountLimit").val(),
							"registTime": $("#limit4").val()=="lt"? -regTimeInMillis : regTimeInMillis
						},
					pic: msg,
					endTime: $("#endTime").val(),
					startTime: $("#startTime").val(),
					description: $("#detail").val()
				},
				function(data) {
					var data = $.parseJSON(data);
					if(data.errno == 0) {
						$("#addModal").find('button.close').click();
					}
					else {
						alert(data.errmsg);
						$("#addP").removeAttr('disabled')
						//添加失败后带着已获取的返回值msg修改按钮的click事件，使之不再发送上传请求
						$("#addP").unbind('click');
						var json = $.parseJSON(msg);
						if(json.errno != 0) { //文件上传出错，提示并销毁这次请求
							alert(json.errmsg);
							destroyIframe();
							return;
						}
						//图片上传没问题，直接传另一个表单
						$("#addP").unbind("click").click(function(event) {
							add(msg,"add", null);
						});
					}	
				}
			);
		}
	}
	function destroyIframe() {
		var iframe = document.getElementById("myframe");
		iframe.contentWindow.document.write('');
		iframe.contentWindow.close();
		document.body.removeChild(iframe);
	}
	function resetAddModal() {
		if(document.getElementById("myframe")) {
			destroyIframe();
		}
		$("#addP").unbind('click');
		$("#addP").bind('click', addP);
		$("#mallNav").find('li:first()').tab("show");
		$("#addP").removeAttr('disabled');
		$("#addModal").find('form').find('input,textarea').val("").removeAttr('disabled');
		$("#addModal").find('form').find('textarea').html("");
	}
	$('#addModal').on('hidden.bs.modal', function (e) {
		resetAddModal();
	});

	function parseDate(str) {
		var dateStr = str.split("T")[0];
		var timeStr = str.split("T")[1];
		var year = dateStr.split("-")[0];
		var month = dateStr.split("-")[1];
		var day = dateStr.split("-")[2];
		var hour = timeStr.split(":")[0];
		var minute = timeStr.split(":")[1];
		var date = new Date();
		date.setFullYear(year, month, day);
		date.setHours(hour, minute);
		return Math.round(date.getTime()/1000);
	}

	function timeMillis2DateStr(timeMillis) {
		var date = new Date(timeMillis);
		var year = date.getFullYear();
		var month = date.getMonth();
		var day = date.getDate();
		var hour = date.getHours();
		var minute = date.getMinutes();
		return year + "-" + fixSingleNum(month) + "-" + fixSingleNum(day) + "T" + fixSingleNum(hour) + ":" + fixSingleNum(minute);
	}


/***************************标签页切换******************************************/
	jQuery(document).ready(function($) {
	//新导航标签被点击未显示时触发
		$('#mallNav').children('li').on('show.bs.tab', function (e) {
			e.stopPropagation();
			showList($(this));
		});
	});

	function showList(e) {
		var tabid = e.attr('data-id');
			if(tabid=="new"){
				var state = 0;
			} else if(tabid=="onSell") {
				var state = 1;
			} else {
				var state = -1;
			}
			$.get(
				'/cms/api/mall',
				{
					m: 'list',
					state: state
				},
				function (data) {
					var data = jQuery.parseJSON(data);
					var content = data.data;
					if (data.errno == 0) {
						var panels = '';
						
						for (var i = 0; i < content.length; i++) {
							var panel = $('#mallPanel').clone();
							//填充
							panel.find('.panel').attr("id","p" + content[i].id);
							panel.find('.id').text(content[i].id);
							panel.find('.item-pic').attr("src", content[i].pic);
							panel.find('.item-name').text(content[i].name);
							panel.find('.item-price').text(content[i].price);
							panel.find('.item-amount').text(content[i].amount);
							panel.find('.itemViewed').text(state==0? 0 : content[i].itemViewed);
							panel.find('.boughtAmount').text(state==0? 0 : content[i].amount - content[i].remainAmount);
							panel.find('.usedAmount').text(state==0? 0 : content[i].usedAmount);
							panel.find('.endTime').text(content[i].endTime);
							panel.find('.startTime').text(content[i].startTime);
							panel.find('.description').text(content[i].description);
							panel.find('.type').text(content[i].type==1? "兑换商城":"竞价商城");

							if(content[i].limitConds) {
								if(content[i].limitConds.jy) {
									panel.find('.limit').text("经验：");
									panel.find('.limit-value').text(content[i].limitConds.jy==0||content[i].limitConds.jy==""? "无限制":(content[i].limitConds.jy>0? "大于"+content[i].limitConds.jy : "小于" + (-content[i].limitConds.jy)));
								} else{
									panel.find('.limit').text("经验：");
									panel.find('.limit-value').text("无限制");
								}

								if(content[i].limitConds.sex) {
									panel.find(".item-limitconds").append('\
										<span class="limit">性别：</span>\
										<span class="limit-value">'+ (content[i].limitConds.sex!="M"&&content[i].limitConds.sex!="F"? "无限制":(content[i].limitConds.sex!="M"? "男": "女")) +'</span></br>');
								} else{
									panel.find(".item-limitconds").append('\
										<span class="limit">性别：</span>\
										<span class="limit-value">无限制</span></br>');
								}

								if(content[i].limitConds.registTime) {
									var date = new Date(Math.abs(content[i].limitConds.registTime) * 1000);
									var dateFormat = date.getFullYear() + "-" + fixSingleNum(date.getMonth()) + "-" + fixSingleNum(date.getDate()) + " " + fixSingleNum(date.getHours()) + ":" + fixSingleNum(date.getMinutes()); 
									panel.find(".item-limitconds").append('\
										<span class="limit">注册时间：</span>\
										<span class="limit-value">'+ (content[i].limitConds.registTime==""||content[i].limitConds.registTime==0? "无限制":(content[i].limitConds.registTime>0? ("晚于" + dateFormat): ("早于" + dateFormat))) +'</span></br>');
								} else{
									panel.find(".item-limitconds").append('\
										<span class="limit">注册时间：</span>\
										<span class="limit-value">无限制</span></br>');
								} 

								if(content[i].limitConds.amountLimit) {
									panel.find(".item-limitconds").append('\
										<span class="limit">每人限购：</span>\
										<span class="limit-value">'+ (content[i].limitConds.amountLimit==""||content[i].limitConds.amountLimit==0? "无限制":content[i].limitConds.amountLimit) +'</span></br>');
								} else{
									panel.find(".item-limitconds").append('\
										<span class="limit">每人限购：</span>\
										<span class="limit-value">无限制</span></br>');
								}
							}
							if(tabid=="new") {
								panel.find('button.operation').text("上架").addClass('btn-info').attr("onclick","operateItem("+ content[i].id +",'setOn')");
								panel.find('button.operation').after('<button type="button" class="btn btn-sm btn-warning" style="margin-left:5px;" onclick="modifyBtnCallback(this)">修改</button>' + '<button type="button" class="btn btn-sm btn-danger del-confirm-btn" style="margin-left:5px;" data-toggle="modal" data-target="#delConfirmModal">删除</button>');
								
							} else if(tabid=="onSell") {
								panel.find('button.operation').text("下架").addClass('btn-warning').attr("onclick","operateItem("+ content[i].id +",'setOff')");
								panel.find('button.operation').before('<button type="button" class="btn btn-sm btn-info" style="margin-right:5px;" onclick="showPurchaseLog(this)">兑换名单</button>');	
							} else {
								panel.find('button.operation').remove();
							}
							panels += panel.html();
						}
						$('#mallContent').html(panels);
						$('#mallContent').show();
					}
					else {
						alert(content.errmsg);
					}
				}
			);
	}

	function fixSingleNum(num) {
		return num<10? ("0" + Math.round(num)) : num;
	}
/***************************上下架、删除******************************************/
	
	$("#delConfirmModal").on("shown.bs.modal", function(e) {
		var btn = e.relatedTarget;
		var id = $(btn).parents(".panel").attr("id").substr(1);
		$("button#del-btn").unbind("click").click(function(event) {
			operateItem(id, 'delete');
			$("#delConfirmModal").modal("hide"); 
		});	
	});

	$("#delConfirmModal").on("hidden.bs.modal", function(e) {
		$("button#del-btn").unbind('click');
	});

	function operateItem(id, operation) {
		if(operation == "setOn") {
			var mVal = "setState";
			var state = 1;
		} else if(operation == "setOff") {
			var mVal = "setState";
			var state = -1;
		} else if(operation == "delete") {
			var mVal = "delete";
			var state = null;
		}
		$.get(
			'/cms/api/mall',
			{
				m: mVal,
				id: id,
				state: state
			},
			function(data) {
				var data = $.parseJSON(data);
				if(data.errno == 0) {
					$(".panel#p"+id).remove();
				} else {
					alert(data.errmsg);
				}
			}
		);
	}

	//修改信息
	function modifyBtnCallback(e) {
		var id = $(e).parents(".panel").find('.id').text();
		$.get(
			'/cms/api/mall',
			{
				m: "modify",
				id: id
			},
			function(data) {
				var data = $.parseJSON(data);
				if(data.errno == 0) {
					var pic = data.data.pic;
					$("#addModal").find('#name').val(data.data.name).attr("disabled","disabled");
					$("#addModal").find('#file').attr("disabled","disabled");
					$("#addModal").find('#price').val(data.data.price);
					$("#addModal").find('#amount').val(data.data.amount);
					$("#addModal").find('#type').val(data.data.type);
					$("#addModal").find('#endTime').val(data.data.endTime);
					$("#addModal").find('#startTime').val(data.data.startTime);
					$("#addModal").find('#detail').val(data.data.detail);
					if(data.data.type == 0) {
						$("#addModal").find('.setTime').show();
					}
					if(data.data.limitConds["jy"]>0) {
						$("#addModal").find('#limit1').val("gt");
						$("#addModal").find('#conditionVal').val(data.data.limitConds["jy"]);
					} else if(data.data.limitConds["jy"]<0) {
						$("#addModal").find('#limit1').val("lt");
						$("#addModal").find('#conditionVal').val(-data.data.limitConds["jy"]);
					} else {
						$("#addModal").find('#limit1').val("gt");
						$("#addModal").find('#conditionVal').val("");
					}

					if(data.data.limitConds["sex"]=="M") {
						$("#addModal").find("#limit2").val("m");
					} else if(data.data.limitConds["sex"]=="F") {
						$("#addModal").find("#limit2").val("f");
					}
					$("#addModal").find("input#amountLimit").val(data.data.limitConds["amountLimit"]);
					
					if(data.data.limitConds["registTime"]>=0) {
						var timeStr = timeMillis2DateStr(data.data.limitConds["registTime"] * 1000);
						$("#addModal").find('#limit4').val("gt");
						$("#addModal").find("#regTime").val(timeStr);
					} else {
						var timeStr = timeMillis2DateStr(-(data.data.limitConds["registTime"]) * 1000);
						$("#addModal").find('#limit4').val("lt");
						$("#addModal").find("#regTime").val(timeStr);
					}
					var endTime = data.data.endTime;
					var startTime = data.data.startTime;
					if(endTime) {
						endTime = endTime.split(" ").join("T");
						$("#addModal").find('#endTime').val(endTime);
					}
					if(startTime) {
						startTime = startTime.split(" ").join("T");
						$("#addModal").find('#startTime').val(startTime);
					}
					$("#addModal").find('#detail').val(data.data.description);
					$("#addP").unbind('click').click(function(event) {
						add(pic,"modify2",id);
					});
					$("#addModal").modal("show");
				} else {
					alert(data.errmsg);
				}
			}
		);
	}

	function showPurchaseLog(e) {
		var id = $(e).parents(".panel").find('.id').text();
		$.get(
			'/cms/api/mall',
			{
				m: "purchaseLog",
				id: id
			},
			function(data) {
				var data = $.parseJSON(data);
				if(data.errno == 0) {
					var logs = data.data; //数组
					$("#purchaseLogModal").find("tbody").empty().append('<tr>\
  							<th>学号</th>\
  							<th>姓名</th>\
  							<th>商品名称</th>\
  							<th>领取凭证</th>\
  							<th>申请时间</th>\
  							<th>是否已兑换</th>\
  						</tr>');
					for(var i=0; i<logs.length; i++) {
						var log = logs[i];
						var isUsed = log["isUsed"]==1? "否":"是";
						$("#purchaseLogModal").find("tbody").append('<tr>\
  							<td>'+ log["stuNum"] +'</td>\
  							<td>'+ log["userName"] +'</td>\
  							<td>'+ log["itemName"] +'</td>\
  							<td>'+ log["token"] +'</td>\
  							<td>'+ log["time"] +'</td>\
  							<td>'+ isUsed +'</td>\
  						</tr>');
					}

					$("#purchaseLogModal").modal('show');
				} else {
					alert(data.errmsg);
				}
			}
		);
	}
/***************************查询与兑换******************************************/
	function query() {
		$.get(
			'/cms/api/mall?m=exchange1&token=' + $("input#exg-token").val(),
			function(data) {
				$("input#exg-token").hide();
				$("#queryBtn").hide();

				var data = $.parseJSON(data);
				if(data.errno==0) {
					$("div#exg-response").empty()
						.append('<p style="text-align:left;">学号：' + data.data.xmu_num + '</p>'
							+ '<p style="text-align:left;">ID号：' + data.data.name + '</p>'
							+ '<p style="text-align:left;">商品名称：' + data.data.itemsName + '</p>'
							+ '<p class="logID" style="display:none;">' + data.data.logID + '</p>').show();
					$("#exchangeBtn").show();
				}
				else {
					$("div#exg-response").empty().append('<p class="warning" style="color:red; font-size:300%;">' + data.errmsg + '</p>').show();
					$("#closeBtn").show();
				}
				
				
			}
		);
	}

	function exchange(e) {
		$("#exchangeBtn").hide();
		$.get(
			'/cms/api/mall?m=exchange2&logID=' + $(e).parents("#exchangeModal").find('p.logID').text(),
			function(data) {
				var data = $.parseJSON(data);
				if(data.errno==0) {
					$("div#exg-response").empty().append('<p class="warning" style="color:red; font-size:300%;">' + "兑换成功！" + '</p>').show();
					$("#closeBtn").show();
				}
				else {
					$("div#exg-response").empty().append('<p class="warning" style="color:red; font-size:300%;">' + data.errmsg + '</p>').show();
					$("#closeBtn").show();
				}
			}
		);
	}

	$('#exchangeModal').on('hidden.bs.modal', function (e) {
		$("input#exg-token").val("").show();
		$("#exg-response").empty().hide();
		$("#queryBtn").show().siblings('button').hide();
	});

/*************************设置*****************************/
	$("#configOption").on("change", function() {
		var msgElem = $(this).parents("#configModal").find(".msg");
		msgElem.text("")
		var key = $(this).val();
		$.get(
			'/cms/api/mall?m=getCache',
			{
				key: key
			},
			function(response) {
				$(this).siblings(".configVal").val(response);
			}.bind(this)
		);
	});

	$("#saveConfig").on("click",function() {
		var type = $(this).parents("#configModal").find("#configOption").val();
		var value = $(this).parents("#configModal").find(".configVal").val();
		var msgElem = $(this).parents("#configModal").find(".msg");
		if (!type || !value) {
			return;
		}
		var reg = new RegExp("^[0-9]*$")
		if (!reg.test(value)) {
			msgElem.text("请输入整数");
			setTimeout(function(){
				msgElem.text("");
			},1500);
			return;
		}
		$.get(
			'/cms/api/mall?m=setCache&' + type + "=" + value,
			function(response) {
				if(response.errno == 0) {
					msgElem.text("已保存");
				} else {
					msgElem.text(response.errmsg);
				}
				setTimeout(function(){
					msgElem.text("");
				},1500);
			}.bind(this),"json"
		);
	})
</script>