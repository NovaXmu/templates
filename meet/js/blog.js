/**
 * Created by zhanz on 2015/7/9.
 */
var CONTENT_W = $("#list").innerWidth();
var LI_W = CONTENT_W * 0.7;
var OFFSET = (CONTENT_W - LI_W) / 2;

$(document).ready(function () {
    new SlideShow("#list ul", {
        itemWidth: LI_W,
        initOffset: OFFSET
    }).init();
    $("#list ul").css({visibility: "visible"});
    $(".ui-loader").remove();
});

//获取url参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
}

var blog_id = getQueryString("blog_id");
//发起活动
$("button#new").click(function () {
    window.location.href = "/meet/blog?m=addActivity&blog_id=" + blog_id;
});

//我发起的
$("button.tab-left").click(function () {
    window.location.href = "/meet/blog?m=activity&blog_id=" + blog_id + "&isHost=true";
});

//活动列表
$("button.tab-middle").click(function () {
    window.location.href = "/meet/blog?m=activity&blog_id=" + blog_id;
});

//我加入的
$("button.tab-right").click(function () {
    window.location.href = "/meet/blog?m=activity&blog_id=" + blog_id + "&isJoined=true";
});

//加入活动
function joinAct(e) {
    var actId = $(e).parents("li").attr("id");
    $.post(
        "/meet/api/activity?m=joinActivity",
        {
            'activity_id': actId
        },
        function (data) {
            data = jQuery.parseJSON(data);
            if (data.errno == 0) {
                alert("您已成功加入此活动！");
                location.reload();
            }
            else
                alert(data.errmsg);
        });
}

//退出活动
function quitAct(e) {
    var actId = $(e).parents("li").attr("id");
    $.post(
        "/meet/api/activity?m=quitActivity",
        {
            'activity_id': actId
        },
        function (data) {
            data = jQuery.parseJSON(data);
            if (data.errno == 0) {
                alert("您已成功退出此活动！");
                location.reload();
            }
            else
                alert(data.errmsg);
        });
}

//取消活动
function deleteAct(e) {
    var actId = $(e).parents("li").attr("id");
    $.post(
        "/meet/api/activity?m=deleteActivity",
        {
            'activity_id': actId
        },
        function (data) {
            data = jQuery.parseJSON(data);
            if (data.errno == 0) {
                alert("您已成功取消此活动！");
                location.reload();
            }
            else
                alert(data.errmsg);
        });
}

//查看参与名单
function viewMember(e) {
    var actId = $(e).parents("li").attr('id');
    window.location.href = "/meet/blog?m=activityMember&activity_id=" + actId + "";
}

//修改活动弹框
function updateModal(e) {
    var act = $(e).parents("li");
    var actId = act.attr('id');
    var name = act.find(".activityName").text();
    var content = act.find(".activityContent").text();
    var deadline = act.find(".activityDeadline").text();
    var limitNum = act.find(".activityLimitNum").text();

    $("#update .modal-footer").attr("id", actId);
    $("#update input[name='actName']").val(name);
    $("#update textarea").val(content);
    $("#update input[name='deadline']").val(deadline);
    $("#update input[name='limitNum']").val(parseInt(limitNum));
    $("#update").modal();
}

//更新活动
function update() {
    var limitNum = $("#update input[name='limitNum']").val();
    if (limitNum == "")
        limitNum = -1;
    var data = {
        'blog_id': blog_id,
        'activity_id': $("#update .modal-footer").attr("id"),
        'title': $("#update input[name='actName']").val(),
        'content': $("#update textarea").val(),
        'deadline': $("#update input[name='deadline']").val(),
        'limitNum': limitNum
    };
    $.post(
        "/meet/api/activity?m=updateActivity",
        {
            'data': JSON.stringify(data)
        },
        function (data) {
            data = jQuery.parseJSON(data);
            if (data.errno == 0) {
                alert("修改成功");
                location.reload();
            }
            else
                alert(data.errmsg);
        });
}