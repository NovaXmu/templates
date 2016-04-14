<link rel="stylesheet" type="text/css" href="{$base}/roster/css/manage.css">

<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-table.css">
<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-switch.css">

<div class="title">
	<ul>
		<li class="li_selected">
			<button type="button">管理员</button>
		</li>
	</ul>
</div>
<div class="content manage" style="display:table">
	<div class="col-sm-12 add_manager">
		<button type="button" data-toggle="modal" data-target="#ManagerAddModal">
			<img src="{$base}/roster/img/icon_add.png">
			<span>新建管理员</span>
		</button>
	</div>
	<div class="col-sm-12 table-responsive">
		<table class="table table-hover" data-toggle="table" data-show-pagination-switch="true" data-page-number="{$page}" data-page-size="10">
			<thead>
				<tr>
					<th>账号</th>
					<th>昵称</th>
					<th>职称</th>
					<th>启用/禁用</th>
				</tr>
			</thead>
			<tbody>
			{foreach from=$list item=manager}
				<tr id="{$manager['id']}">
					<td>{$manager['account']}</td>
					<td>{$manager['nickname']}</td>
					<td>{$manager['privilege']}</td>
					<td>
						<div class="switch switch-small">
							<input type="checkbox" name="checkbox-my" checked></div>
					</td>
				</tr>
			{/foreach}
			</tbody>
		</table>
	</div>
</div>
<!-- 增加管理人员 -->
<div class="modal fade" id="ManagerAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">新建管理员</h4>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<span class="input-group-addon" id="account">账号</span>
					<input type="text" class="form-control" aria-describedby="account"></div>
				<div style="height:20px;width:100%"></div>
				<div class="input-group">
					<span class="input-group-addon" id="nickname">昵称</span>
					<input type="text" class="form-control" aria-describedby="nickname"></div>
				<div style="height:20px;width:100%"></div>
				<div class="input-group">
					<span class="input-group-addon" id="password">密码</span>
					<input type="text" class="form-control" aria-describedby="password"></div>
				<div style="height:20px;width:100%"></div>
				<div class="input-group">
					<span class="input-group-addon" id="privilege">职称</span>
					<select style="font-size:15px;padding:5px;">
						<option value="1">超级管理员</option>
						<option value="2">项目管理员</option>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="btn-add-manager" onClick="addManager()">提交</button>
					<button type="button" class="btn btn-default" id="btn-close" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="{$base}/roster/js/bootstrap-table.js"></script>
<script src="{$base}/roster/js/bootstrap-table-zh-CN.js"></script>
<script src="{$base}/roster/js/bootstrap-switch.js"></script>
<script>
$("button[name='paginationSwitch']").click();
$("button[name='paginationSwitch']").parent().hide();

$(".switch").children().css("width","100px");

//$('[name="checkbox-my"]').bootstrapSwitch();

// $('.table').bootstrapTable({
//     onPostBody: function () {
//     	alert("hi")
//         $('[name="checkbox-my"]').bootstrapSwitch();
//     }
// });
// $('.table').on('load-success.bs.table', function (e) {
// 	alert("hi")
//     $('[name="checkbox-my"]').bootstrapSwitch();
// });

$('.table').on('page-change.bs.table', function (e) {
    $('[name="checkbox-my"]').bootstrapSwitch();
});

 $('.table').bootstrapTable('selectPage', 1);	

function addManager(){
	var account=$("#ManagerAddModal").find("#account").next().val();
	var nickname=$("#ManagerAddModal").find("#nickname").next().val();
	var privilege=$("#ManagerAddModal").find("#privilege").next().find("option:selected").val();
	var password=$("#ManagerAddModal").find("#password").next().val();
	if(account==null||nickname==null||password==null){
		alert("信息不完整");
		return false;
	}
	$.ajax({
		url:"/roster/api/admin/super?m=addManager",
		type:"POST",
		data:{
			'account':account,
			'nickname':nickname,
			'privilege':privilege,
			'password':password
		},
		success:function(data){
			var data=jQuery.parseJSON(data);
			if(data.errno==0){
				alert("添加成功");
				location.reload();
			}
			else
				alert(data.errmsg);
		}
	});
}
</script>