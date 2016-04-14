var time = 0;
var page = 1;
var hasMore = true;
$(document).ready(function(){
    loadProject(0);
});

function showAddProject(){
    changeColor(10);
    document.getElementById('addPanel').style.display='';
    document.getElementById('listPanel').style.display='none';
}

function addProject(){
    var name = $('#name').val();
    var start_time = $('#start_time').val();
    var end_time = $('#end_time').val();
    if(name == null){
        alert('项目名称不能为空');
        return false;
    }
    if(start_time == null){
        alert('项目开始时间不能为空');
        return false;
    }
    if(end_time == null){
        alert('项目结束时间不能为空');
        return false;
    }
    if(start_time >= end_time){
        alert('项目的开始时间不大于项目的结束时间');
        return false;
    }
    $.ajax({
        url:"/roster/api/admin/project?m=addProject",
        type:'POST',
        data:{
            'name':name,
            'start_time':start_time,
            'end_time':end_time
        },
        success:function(data){
            var data = jQuery.parseJSON(data);
            if(data.errno == 0){
                //window.load('/roster/admin?m=index');
                //loadProject(0);
            }else{
              alert(data.errmsg);
            }
        }
        });
}

function viewDetail(id){
    $('#right').load('/roster/project?m=project&id='+id);
}

function changeColor(t){
    document.getElementById("now").style.color="#869198";
    document.getElementById("future").style.color="#869198";
    document.getElementById("past").style.color="#869198";
    switch(t){
        case 0:
            document.getElementById("now").style.color="#1ABC9C";
            break;
        case 1:
            document.getElementById("future").style.color="#1ABC9C";
            break;
        case -1:
            document.getElementById("past").style.color="#1ABC9C";
            break;
    }
}

function loadProject(t){
    time = t;
    page = 1;
    hasMore = true;
    changeColor(time);
    document.getElementById('addPanel').style.display='none';
    document.getElementById('listPanel').style.display='';
    loadMoreProject();
}

function frontPage(){
    if(page-1 < 1){
        alert('不能往前了');
        return false;
    }
    page = paeg - 1;
    loadMoreProject();
}

function nextPage(){
    if(!hasMore){
        alert('没有更多了');
        return false;
    }
    page = page + 1;
    loadMoreProject();
}

function loadMoreProject(){
    document.getElementById('page').innerHTML=page;
    alert('loadProjectList');
    $.ajax({
        url:'/roster/api/admin/project?m=getList',
        type:'GET',
        data:{
            'page':page,
            'time':time
        },
        success:function(data){
            var data = jQuery.parseJSON(data);
            if(data.errno == 0){
                var arr = data.errmsg;
                var html = '';
                for(var i = 0; i<arr.length; i++){
                    html += "<tr class='active'>"+
                    "<td>"+arr[i]['name']+"</td>"+
                      "<td>"+arr[i]['start_time']+"</td>"+
                      "<td>"+arr[i]['end_time']+"</td>"+
                      "<td>"+arr[i]['time']+"</td>"+
                      "<td class='action'>"+
                          "<a>"+
                            "<button class='btn btn-success' onclick=viewDetail("+arr[i]['id']+")>"+
                            "<i class='icon-eye-open'>查看详情</i>"+
                            "</button>"+
                          "</a>"+
                      "</td>"+
                    "</tr>";
                }
                alert(html);
                document.getElementById('tbody').innerHTML=html;
                if(arr.length < 10)
                    hasMore = false;
            }else{
                alert(data.errmsg);
            }
        }
    });
}