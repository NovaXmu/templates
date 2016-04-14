<link rel="stylesheet" type="text/css" href="{$base}/roster/css/manage.css">

<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-table.css">
<link rel="stylesheet" type="text/css" href="{$base}/roster/css/bootstrap-switch.css">

<div class="content manage" style="display:table">
    <div class="col-sm-12 add_manager">
        <button type="button" data-toggle="modal" data-target="#CourseAddModal">
            <img src="{$base}/roster/img/icon_add.png">
            <span>新建课程</span>
        </button>
        <div class="col-sm-9 add_manager">
            <label for="dateTime">选择日期</label>
            <input type="date" class="btn-default" id="dateTime" style="color:#337ab7; background-color:rgba(255,255,255,.15); border:0px; border-color:rgba(0,0,0,.5; height:35px;" value="{$date}" onChange="searchCourseList()">
        </div>
    </div>
    <div class="col-sm-12 table-responsive">
        <table class="table table-hover" data-toggle="table" data-show-pagination-switch="true" data-page-number="{$page}" data-page-size="10">
            <thead>
                <tr>
                    <th>课程名</th>
                    <th>授课老师</th>
                    <th>授课地点</th>
                    <th>授课时间</th>
                    <th>课程类型</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            {foreach from=$list item=course}
                <tr id="{$course['id']}">
                    <td>{$course['name']}</td>
                    <td>{$course['teacherName']}</td>
                    <td>{$course['address']}</td>
                    <td>{$course['start']|cat:" ~ "|cat:$course['end']}</td>
                    <!-- <td>{$course['startTime']}</td> -->
                    <!-- <td>{$course['endTime']}</td> -->
                    {if $course['type'] == 1}
                        <td>普通课程</td>
                    {else}
                        <td>兴趣课程</td>
                    {/if}
                    <td>
                        <button class="btn-warning" onclick='deleteCourse({$course['id']})'>删除</button>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>

<!-- 增加班级 -->
<div class="modal fade" id="CourseAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新建课程</h4>
            </div>
            <div class="modal-body" id="loadDiv"></div>
            <div class="modal-body" id="addDiv">
            <form enctype="multipart/form-data" method="post" name="fileinfo">
                <div class="input-group">
                    <span class="input-group-addon" id="name">课程名称</span>
                    <input type="text" class="form-control" aria-describedby="name" name="name"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="teacherName">授课老师</span>
                    <input type="text" class="form-control" aria-describedby="teacherName" name="teacherName"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="address">授课地点</span>
                    <input type="text" class="form-control" aria-describedby="address" name="address"></div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="startTime" value="YYYY-MM-DD hh:mm:ss">授课开始时间</span>
                    <input type="datetime-local" class="form-control">
                </div>
                <div style="height:20px;width:100%"></div>
                 <div class="input-group">
                    <span class="input-group-addon" id="endTime">授课结束时间</span>
                    <input type="datetime-local" class="form-control" value="YYYY-MM-DD hh:mm:ss">
                </div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="type">课程类型</span>
                    <label><input type='radio' name='type' value='1'>普通课程</input></label>
                    <label><input type='radio' name='type' value='2'>兴趣课程</input></label>
                </div>
                <div style="height:20px;width:100%"></div>
                <div class="input-group">
                    <span class="input-group-addon" id="classes">上课班级</span>
                    {foreach from=$classList item=class}
                        <label class="checkbox-inline">
                            <input type="checkbox" name='classes' value="{$class['id']}">{$class['num']}</input>
                        </label>
                    {/foreach}
                </div>
                <div style="height:20px;width:100%"></div>
                </form>
            </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btn-add-class" onClick="addCourse()">提交</button>
                    <button type="button" class="btn btn-default" id="btn-close" data-dismiss="modal">取消</button>
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

 function addCourse(){
    var projectId = $(".title").attr("data");
    var name = $('#CourseAddModal').find('#name').next().val();
    var teacherName = $('#CourseAddModal').find('#teacherName').next().val();
    var address = $('#CourseAddModal').find('#address').next().val();
    var startTime = $('#CourseAddModal').find('#startTime').next().val();
    var endTime = $('#CourseAddModal').find('#endTime').next().val();
    var type = $('#CourseAddModal').find("input[name='type']:checked").val();
    var classes = '';
    if(projectId == null || name == null || teacherName == null || address == null || startTime == null || endTime == null || type == null){
        alert('信息不全');
        return false;
    }
    if(type == 1){
        var list = [];
        $("input[name='classes']:checked").each(function(){
            list.push($(this).val());
        });
        if(list.length == 0){
            alert('您还没有选择上课的班级');
            return false;
        }
        classes = list.join('-');
    }
    $('#loadDiv').css('display','');
    $('#addDiv').css('display', 'none');
    load($('#loadDiv'));
    $.ajax({
        url:"/roster/api/admin/project?m=addCourse",
        type:"POST",
        data:{
            'projectId':projectId,
            'name':name,
            'teacherName':teacherName,
            'address':address,
            'startTime':startTime,
            'endTime':endTime,
            'type':type,
            'classes':classes
        },
        success:function(data){
            var data=jQuery.parseJSON(data);
            if(data.errno == 0){
                alert('添加课程成功');
                $('#CourseAddModal').modal('hide');
                $(".modal-backdrop").remove();
                loadCourseList(0);
            }else{
                alert(data.errmsg);
                $('#loadDiv').css('display','none');
                $('#addDiv').css('display', '');
            }
        }

    });
 }


function searchCourseList(){
    var date = $('input#dateTime').val();
    loadCourseList(date);
}

function deleteCourse(courseId){
    $.ajax({
        url:"/roster/api/admin/project?m=deleteCourse",
        type:"POST",
        data:{
            'courseId':courseId
        },
        success:function(data){
            var data = jQuery.parseJSON(data);
            if(data.errno == 0){
                alert('删除成功'),
                searchCourseList();
            }
            else{
                alert(data.errmsg);
            }
        }
    });
}

</script>