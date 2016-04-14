//获取url参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
}

var blog_id = getQueryString("blog_id");
//发布活动
$("#launch").click(function () {
    var title = $("input[name='actName']").val();
    var limit_num = $("input[name='limit_num']").val();
    if (limit_num == "")
        limit_num = -1;
    var deadline = $("input[name='deadline']").val();
    var content = $("#actContent").val();
    var data = {
        'blog_id': blog_id,
        'title': title,
        'limitNum': limit_num,
        'deadline': deadline,
        'content': content
    };

    $.ajax({
        url:"/meet/api/activity?m=addActivity",
        type: "POST",
        data: {
            'data': JSON.stringify(data)
        },
        dataType: "JSON",
        beforeSend: loading,
        complete: loaded,
        success: function (data) {
            if (data.errno == 0) {
                alert("发布成功！");
                window.history.go(-1);
            }
            else
                alert(data.errmsg);
        }
    });
});
