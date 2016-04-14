<style type="text/css">
	.project_line{
		margin-bottom:10px;
	}
</style>
<div class="title" data="{$project['id']}" time="{$project['startTIme']}">
	<ul>
		<li class="li_selected">
			<button type="button" onClick='loadProject()'>项目详情</button>
		</li>
		<li class="li_unselected">
			<button type="button" onClick='loadCourseList(0)'>课程</button>
		</li>
		<li class="li_unselected">
			<button type="button" onClick='loadStudentList(0)'>学生</button>
		</li>
		<li class="li_unselected">
			<button type="button" onClick='loadTeacherList()'>班主任</button>
		</li>
	</ul>
</div>
<div class="content project_detail" id="project_detail" style="padding-top:20px; display='';">
	<div class="col-sm-12 project_line">
		<div class="col-sm-2">项目名称:</div>
		<div class="col-sm-10">{$project['name']}</div>
	</div>
	<div class="col-sm-12 project_line">
		<div class="col-sm-2">项目简介:</div>
		<div class="col-sm-10">{$project['introduction']}</div>
	</div>
	<div class="col-sm-12 project_line">
		<div class="col-sm-2">开始时间:</div>
		<div class="col-sm-10">{$project['startTime']}</div>
	</div>
	<div class="col-sm-12 project_line">
		<div class="col-sm-2">结束时间:</div>
		<div class="col-sm-10">{$project['endTime']}</div>
	</div>
</div>
<div class="content" id="load" style="display:none;"></div>
<div class="content some_list" id='some_list' style="padding-top:20px; display=none; ">
</div>


<script src="{$base}/roster/js/jquery-1.12.0.min.js"></script>
<script src="{$base}/roster/js/bootstrap.min.js"></script>
<script type="text/javascript">

//标题切换

$(".title ul li").click(function(){
		$(this).siblings().removeClass("li_selected").addClass("li_unselected");
		$(this).removeClass("li_unselected").addClass("li_selected");
	});

function loadProject(){
	$('#some_list').css('display', 'none');
	$('#project_detail').css('display', '');
}

function loadCourseList(date){
	$('#project_detail').css('display', 'none');
	load($('#some_list'));
  if(date == 0){
    $('#some_list').load('/roster/project?m=courseList&projectId='+{$project['id']});
  }else{
    $('#some_list').load('/roster/project?m=courseList&projectId='+{$project['id']}+'&date='+date);
  }
}

function loadStudentList(classId){
	$('#project_detail').css('display', 'none');
	load($('#some_list'));
	$('#some_list').load('/roster/project?m=studentList&projectId='+{$project['id']}+'&classId='+classId);
}

function loadTeacherList(){
	$('#project_detail').css('display', 'none');
	load($('#some_list'));
	$('#some_list').load('/roster/project?m=teacherList&projectId='+{$project['id']});
}


//项目详情
function toProjectDetail(e){
  var id=$(e).attr("id");
  var name=$(e).find("div.project_name span").text();
  $(".btn-first").after('<span>>></span>\
    <button type="button" class="btn-second" id="'+id+'">'+name+'</button>');
  load($('#right'));
  $("#right").load("/roster/project?m=project&id="+id+"");
}

//上一页
function prevPage(){
  var page=parseInt($("ul.pagination li.active a").html())-1;
  if(page<=0){
    alert("没有上一页了");
    return false;
  }
  //alert(page);
  getPage(page,$(".title ul li.li_selected").attr("id"));
  $("ul.pagination li.active").prev().addClass("active");
  $("ul.pagination li.active:last").removeClass("active");
}

//下一页
function nextPage(){
  var page=parseInt($("ul.pagination li.active a").html())+1;
  if(page>parseInt($("ul.pagination").attr("data"))){
    alert("没有更多了");
    return false;
  }
  //alert(page);
  getPage(page,$(".title ul li.li_selected").attr("id"));
  $("ul.pagination li.active").next().addClass("active");
  $("ul.pagination li.active:first").removeClass("active");
}

//翻页
function toPage(e){
  var page=parseInt($(e).find("a").html());
  getPage(page,$(".title ul li.li_selected").attr("id"));
  $("ul.pagination li.active").removeClass("active");
  $(e).addClass("active");
}

//ajax获取对应参数的项目列表
function getPage(page,time){
  $('#load').css('display', '');
  $('#some_list').css('display','none');
  load($('#load'));
  $.ajax({
        url:"/roster/api/admin/project?m=getProjectList",
        type:'GET',
        data:{
            'page':page,
            'time':time
        },
        success:function(data){
            var data = jQuery.parseJSON(data);
            if(data.errno == 0){
              $("#projectAdd").prevAll().remove();
              for(var i in data.errmsg){
                $("#projectAdd").before('<div class="col-sm-3 project" id="'+data.errmsg[i].id+'" onClick="toProjectDetail(this)">\
                  <button type="button">\
                  <div class="project_name">\
                  <span>'+data.errmsg[i].name+'</span>\
                  </div>\
                  <div class="project_brief">\
                  <p>'+data.errmsg[i].introduction+'</p>\
                  </div>\
                  <div class="project_start" style="font-size:15px;">\
                  <span>开始时间:</span>\
                  <span>'+data.errmsg[i].startTime+'</span>\
                  </div>\
                  <div class="project_end" style="font-size:15px;">\
                  <span>结束时间:</span>\
                  <span>'+data.errmsg[i].endTime+'</span>\
                  </div>\
                  </button>\
                  </div>');
              }
              $('#load').css('display', 'none');
              $('#some_list').css('display','');
            }else{
              alert(data.errmsg);
            }
        }
        });
}
</script>