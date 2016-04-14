<link rel="stylesheet" type="text/css" href="{$base}/roster/css/manage.css">

<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-table.css">
<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-switch.css">

<div class="content manage" style="display:table">
    <div class="col-sm-12 add_manager">
        <button type="button" data-toggle="modal" data-target="#ClassAddModal">
            <img src="{$base}/roster/img/icon_add.png">
            <span>新建班级</span>
        </button>
    </div>
    <div class="col-sm-12 table-responsive">
        <table class="table table-hover" data-toggle="table" data-show-pagination-switch="true" data-page-number="{$page}" data-page-size="10">
            <thead>
                <tr>
                    <th>班级编号</th>
                    <th>班主任姓名</th>
                    <th>班主任手机</th>
                    <th>班主任邮箱</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            {foreach from=$list item=class}
                <tr id="{$class['id']}">
                    <td>{$class['num']}</td>
                    <td>{$class['teacher']['name']}</td>
                    <td>{$class['teacher']['telephone']}</td>
                    <td>{$class['teacher']['email']}</td>
                    <td>
                        <button class="btn-warning" onclick='deleteClass({$class['id']})'>删除</button>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
<!-- 增加班级 -->
<div class="modal fade" id="ClassAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新建班级</h4>
            </div>
            <div class="modal-body" id='loadDiv' style="display:none;"></div>
            <div class="modal-body" id="addDiv">
            <form enctype="multipart/form-data" method="post" name="fileinfo">
                <div class="input-group">
                    <span class="input-group-addon" id="num">项目班级号</span>
                    <input type="text" class="form-control" aria-describedby="num" name="num"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="name">班主任姓名</span>
                    <input type="text" class="form-control" aria-describedby="name" name="name"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="telephone">班主任手机</span>
                    <input type="text" class="form-control" aria-describedby="telephone" name="telephone"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="email">班主任邮箱</span>
                    <input type="text" class="form-control" aria-describedby="email" name="email"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="file_stu">学生xls文件</span>
                    <input type="file" class="form-control" aria-describedby="file_stu" name="file_stu">
                </div>
                <div style="height:20px;width:100%"></div>
            </form>
        </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btn-add-class" onClick="addClass()" data-dismiss="modal">提交</button>
                    <button type="button" class="btn btn-default" id="btn-close" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>

<!-- 修改班级 -->
<div class="modal fade" id="ClassModifyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改班级信息</h4>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <span class="input-group-addon" id="num">项目班级号</span>
                    <input type="text" class="form-control" aria-describedby="num"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="name">班主任姓名</span>
                    <input type="text" class="form-control" aria-describedby="name"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="telephone">班主任手机</span>
                    <input type="text" class="form-control" aria-describedby="telephone"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="email">班主任邮箱</span>
                    <input type="text" class="form-control" aria-describedby="email"></div>
                <div style="height:20px;width:100%"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btn-add-class" onClick="modifyClass()" data-dismiss="modal">修改</button>
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

$('.table').on('page-change.bs.table', function (e) {
    $('[name="checkbox-my"]').bootstrapSwitch();
});

 $('.table').bootstrapTable('selectPage', 1);   

function addClass(){
var fd = new FormData(document.forms.namedItem("fileinfo"));
fd.append("projectId", $(".title").attr("data"));
$('#loadDiv').css('display','');
$('#addDiv').css('display', 'none');
load($('#loadDiv'));
$.ajax({
  url: "/roster/api/admin/project?m=addClass",
  type: "POST",
  data: fd,
  processData: false,  // 告诉jQuery不要去处理发送的数据
  contentType: false,  // 告诉jQuery不要去设置Content-Type请求头
  success:function(data){
    var data=jQuery.parseJSON(data);
    if(data.errno == 0){
        alert('添加成功');
        $('#ClassAddModal').modal('hide');
        $(".modal-backdrop").remove();
        loadTeacherList();
    }else{
        alert(data.errmsg);
        $('#loadDiv').css('display','none');
        $('#addDiv').css('display', '');
    }
  }
});
}

function deleteClass(classId){
    $.ajax({
        url:"/roster/api/admin/project?m=deleteClass",
        type:"POST",
        data:{
            'classId':classId,
            'projectId':$(".title").attr("data")
        },
        success:function(data){
            var data = jQuery.parseJSON(data);
            if(data.errno == 0){
                alert('删除成功'),
                loadTeacherList();
            }
            else{
                alert(data.errmsg);
            }
        }
    });
}
</script>