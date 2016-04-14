function loadProjectList(e){
	$(e).siblings().children().removeClass('selected');
	$(e).siblings().find('.left').removeClass("left_selected");
	$(e).find(".menu_project").addClass('selected');
	$(e).find(".left").addClass('left_selected');
	$('#right').load('/roster/project?m=projectList');
    $.ajax({
        url:"/roster/api/admin/project?m=getProjectPage",
        data:{
            'time':0
        },
        success:function(data){
            var data=jQuery.parseJSON(data);
            if(data.errno==0){
                if(data.errmsg<=1)
                    $("#page").hide();
                else{
                    $("#page").show();
                    $("#page nav ul li#prevPage").nextUntil("nav ul li#nextPage").remove();
                    for(var i=1;i<=data.errmsg;i++){
                        $("#page nav ul li#nextPage").before('<li>\
                            <a>'+i+'</a>\
                            </li>');
                    }
                }
            }
            else
                alert(data.errmsg);
        }
    });
	$.ajax({
        url:"/roster/api/admin/project?m=getProjectList",
        type:'GET',
        data:{
            'page':1,
            'time':0
        },
        success:function(data){
            var data = jQuery.parseJSON(data);
            if(data.errno == 0){
            	$("#projectAdd").prevAll().remove();
            	for(var i in data.errmsg){
            		$("#projectAdd").before('<div class="col-sm-3 project" id="'+data.errmsg[i].id+'">\
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
                
                //window.load('/roster/admin?m=index');
                //loadProject(0);
            }else{
              alert(data.errmsg);
            }
        }
        });
}
