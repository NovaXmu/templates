<!--项目列表-->
<link rel="stylesheet" type="text/css" href="{$base}/roster/css/project.css">

<div class="title">
    <ul>
        <li class="li_selected" id="0">
            <button type="button">正在进行</button>
        </li>
        <li class="li_unselected" id="1">
            <button type="button">即将开始</button>
        </li>
        <li class="li_unselected" id="-1">
            <button type="button">已经结束</button>
        </li>
    </ul>
</div>
<div class="content" id="load" style="display:none;"></div>
<div class="content" id="content" style="display:'';">
  {foreach from=$list item=project}
    <div class="col-sm-3 project" id="{$project['id']}" onclick="toProjectDetail(this)">
      <button type="button">
        <div class="project_name">
          <span>{$project['name']}</span>
        </div>
        <div class="project_brief">
          <p>{$project['introduction']}</p>
        </div>
        <div class="project_start" style="font-size:15px;">
          <span>开始时间:</span>
          <span>{$project['startTime']}</span>
        </div>
        <div class="project_end" style="font-size:15px;">
          <span>结束时间:</span>
          <span>{$project['endTime']}</span>
        </div>
      </button>
    </div>
  {/foreach}
    <div class="col-sm-3 project" id="projectAdd">
        <button type="button" data-toggle="modal" data-target="#ProjectAddModal" class="btn_add_project" style="width:100%;margin-top:5%">
            <img src="{$base}/roster/img/icon_add.png"></button>
    </div>
    <div class="col-sm-12" id="page" style="{if $page eq 1}display:none;{/if}">
      <nav style="text-align:center;">
        <ul class="pagination" data='{$page}'>
          <li id="prevPage" onclick="prevPage()">
            <a aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
          </li>
          {foreach from=$list item=project name=foo}
          {if $smarty.foreach.foo.iteration lte $page}
          <li class="{if $smarty.foreach.foo.iteration eq 1}active{/if}" onclick="toPage(this)"><a>{$smarty.foreach.foo.iteration}</a></li>
          {/if}
          {/foreach}
          <li id="nextPage" onclick="nextPage()">
            <a aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>

</div>

<!-- 增加项目 -->
<div class="modal fade" id="ProjectAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">增加项目</h4>
      </div>
      <div class="modal-body" id='loadDiv' style="display:none;"></div>
      <div class="modal-body" id='addDiv'>
          <div class="input-group">
              <span class="input-group-addon" id="project-name">项目名称</span>
              <input type="text" class="form-control" aria-describedby="project-name"></div>
          <div style="height:20px;width:100%"></div>
          <div class="input-group">
              <span class="input-group-addon" id="project-introduction">项目简介</span>
              <input type="text" class="form-control" aria-describedby="project-introduction"></div>
          <div style="height:20px;width:100%"></div>
          <div class="input-group">
              <span class="input-group-addon" id="project-start">开始时间</span>
              <input type="date" class="form-control" aria-describedby="project-name"></div>
          <div style="height:20px;width:100%"></div>
          <div class="input-group">
              <span class="input-group-addon" id="project-end">结束时间</span>
              <input type="date" class="form-control" aria-describedby="project-name"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="btn-add-project" data-dismiss="modal">提交</button>
        <button type="button" class="btn btn-default" id="btn-close" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<script src="{$base}/roster/js/jquery-1.12.0.min.js"></script>
<script src="{$base}/roster/js/bootstrap.min.js"></script>
<script type="text/javascript">

//标题切换

    $(".title ul li").click(function(){
      $(this).siblings().removeClass("li_selected").addClass("li_unselected");
      $(this).removeClass("li_unselected").addClass("li_selected");
      $.ajax({
        url:"/roster/api/admin/project?m=getProjectPage",
        data:{
            'time':$(this).attr("id")
        },
        success:function(data){
            var data=jQuery.parseJSON(data);
            if(data.errno==0){
                if(data.errmsg<=1)
                    $("#page").hide();
                else{
                    $("#page ul.pagination").attr("data",''+data.errmsg+'');
                    $("#page").show();
                    $("#page nav ul li#prevPage").nextUntil("nav ul li#nextPage").remove();
                    for(var i=1;i<=data.errmsg;i++){
                        if(i==1)
                          $("#page nav ul li#nextPage").before('<li class="active" onClick="toPage(this)">\
                            <a>'+i+'</a>\
                            </li>');
                        else
                          $("#page nav ul li#nextPage").before('<li onClick="toPage(this)">\
                            <a>'+i+'</a>\
                            </li>');
                    }

                }
            }
            else
                alert(data.errmsg);
        }
    });
    
    getPage(1,$(this).attr("id"));
  });

//添加项目
    $("#btn-add-project").click(function(){
        var name=$("#ProjectAddModal").find("#project-name").next().val();
        var introduction=$("#ProjectAddModal").find("#project-introduction").next().val();
        var startTime=$("#ProjectAddModal").find("#project-start").next().val();
        var endTime=$("#ProjectAddModal").find("#project-end").next().val();
        if(name == null){
            alert("项目名称不能为空");
            return false;
        }
        if(startTime == null){
            alert('项目开始时间不能为空');
            return false;
        }
        if(endTime == null){
            alert('项目结束时间不能为空');
            return false;
        }
        if(startTime >= endTime){
           alert('项目的开始时间不大于项目的结束时间');
           return false;
        }
        $('#loadDiv').css('display','');
        $('#addDiv').css('display', 'none');
        load($('#loadDiv'));
        $.ajax({
            url:"/roster/api/admin/project?m=addProject",
            type:'POST',
            data:{
               'name':name,
               'introduction':introduction,
               'startTime':startTime,
               'endTime':endTime
            },
            success:function(data){
               var data = jQuery.parseJSON(data);
               if(data.errno == 0){
                alert("添加成功");
                $('#right').load('/roster/project?m=projectList&page=1&time=0');
               }else{
                alert(data.errmsg);
               }
           }
        });
    });

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
  // $('#load').style.display = "";
  // $('#content').style.display = "none";
  $('#load').css('display', '');
  $('#content').css('display','none');
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
              $('#content').css('display','');
            }else{
              alert(data.errmsg);
            }
        }
        });
}
</script>