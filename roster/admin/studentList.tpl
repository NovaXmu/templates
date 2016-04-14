<link rel="stylesheet" type="text/css" href="{$base}/roster/css/manage.css">

<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-table.css">
<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-switch.css">

<div class="content manage" style="display:table">
    <div class="col-sm-12 add_manager">
        <button type="button" data-toggle="modal" data-target="#StudentAddModal">
            <img src="{$base}/roster/img/icon_add.png">
            <span>添加学生</span>
        </button>
        <div class="col-sm-9 add_manager">
            <select class='btn-info' id='classNum' style="height:34px;" onChange="searchStudentList()">
                {if $classId == 0}
                    <option value="0" selected="selected">按班级筛选</option>
                {else}
                    <option value="0">按班级筛选</option>
                {/if}
                {foreach from=$classList item=class}
                    {if $classId == $class['id']}
                        <option value="{$class['id']}" selected='selected'>{$class['num']}</option>
                    {else}
                        <option value="{$class['id']}">{$class['num']}</option>
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    <div class="col-sm-12 table-responsive">
        <table class="table table-hover" data-toggle="table" data-show-pagination-switch="true" data-page-number="{$page}" data-page-size="10">
            <thead>
                <tr>
                    <th>班级编号</th>
                    <th>学生姓名</th>
                    <th>学生手机号</th>
                    <th>学生邮箱</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            {foreach from=$list item=student}
                <tr id="{$student['id']}">
                    <td>{$classList[$student['classId']]['num']}</td>
                    <td>{$student['user']['name']}</td>
                    <td>{$student['user']['telephone']}</td>
                    <td>{$student['user']['email']}</td>
                    <td>
                        <button class="btn-warning" onclick='deleteStudent({$student['id']})'>删除</button>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>

<!-- 添加学生 -->
<div class="modal fade" id="StudentAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <!-- <span aria-hidden="true">&times;</span> -->
                    <span>&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加学生</h4>
            </div>
            <div class="modal-body" id='loadDiv' style="display:none;"></div>
            <div class="modal-body" id='addDiv'>
                <!-- <select class="selectpicker">
                        {foreach from=$list item=class}
                            <option>{$class['num']}</option>
                        {/foreach}
                </select> -->
                <div class="input-group">
                    <select class='btn-info' id='classNum' style="height:34px;">
                        <option value=0>请选择班级</option>
                        {foreach from=$classList item=class}
                                <option value="{$class['id']}">{$class['num']}</option>
                        {/foreach}
                    </select>
                </div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="name">学生姓名</span>
                    <input type="text" class="form-control" aria-describedby="name"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="telephone">学生手机</span>
                    <input type="text" class="form-control" aria-describedby="telephone"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="email">学生邮箱</span>
                    <input type="text" class="form-control" aria-describedby="email"></div>
                <div style="height:20px;width:100%"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btn-add-student" onClick="addStudent()">提交</button>
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

 function searchStudentList(){
    loadStudentList($('#classNum option:selected').val());
 }

 function addStudent(){
    var classNum = $('#StudentAddModal').find('#classNum option:selected').val();
    var name = $('#StudentAddModal').find('#name').next().val();
    var telephone = $('#StudentAddModal').find('#telephone').next().val();
    var email = $('#StudentAddModal').find('#email').next().val();
    if(classNum == null || name == null || telephone == null || email == null){
        alert('信息不全');
        return false;
    }
    $('#loadDiv').css('display','');
    $('#addDiv').css('display', 'none');
    load($('#loadDiv'));
    $.ajax({
        url:"/roster/api/admin/project?m=addStudent",
        type:"POST",
        data:{
            'classId':classNum,
            'name':name,
            'telephone':telephone,
            'email':email
        },
        success:function(data){
            var data=jQuery.parseJSON(data);
            if(data.errno == 0){
                alert('添加学生成功');
                $('#StudentAddModal').modal('hide');
                $(".modal-backdrop").remove();
                loadStudentList(classNum);
            }else{
                alert(data.errmsg);
                $('#loadDiv').css('display','none');
                $('#addDiv').css('display', '');
            }
        }
    })
 }

 function deleteStudent(studentId){
    $.ajax({
        url:"/roster/api/admin/project?m=deleteStudent",
        type:"POST",
        data:{
            'studentId':studentId,
             'projectId':$(".title").attr("data")
        },
        success:function(data){
            var data = jQuery.parseJSON(data);
            if(data.errno == 0){
                alert('删除成功'),
                searchStudentList();
            }
            else{
                alert(data.errmsg);
            }
        }
    });
 }



</script>