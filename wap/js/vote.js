$(document).ready(function() {
    showPage(1);
});

$(".avatar").on("click", function() {
    var modal = $("#teacher-modal");
    var thisCard = $(this).parent(".card");
    var src = $(this).find("img").attr("src");
    var name = thisCard.find(".name").text();
    var institute = thisCard.find(".institute").text();
    var introduction = thisCard.find(".introduction").html();
    var vote = thisCard.find(".vote").text();
    modal.find(".avatar").find("img").attr("src",src).end().end()
        .find(".name").text(name).end()
        .find(".institute").find(".right").text(institute).end().end()
        .find(".introduction").find(".right").html(introduction).end().end()
        .find(".num").text(vote);
    modal.modal("toggle");
});

function showPage(num) {
    $(".page").hide().filter("#page" + num).show();
    $("#currentPage").text(num);
}

$("button.next-page").on("click", nextP);

function nextP() {
    var page = parseInt($("#currentPage").text()) + 1;
    if (page <= 3) {
        showPage(page);
    }
}

$("button.prev-page").on("click", prevP);

function prevP() {
    var page = parseInt($("#currentPage").text()) - 1;
    if (page >= 1) {
        showPage(page);
    }
}

$(".nav").find("li").on("click",function() {
    var target = $(this).attr("data-target");
    $(".my-panel").hide().filter(target).show();
    $(this).addClass("active").siblings("li").removeClass("active");
});

$(".vote-btn").on("click",function() {
    $(this).toggleClass("success").toggleClass("iconfont");
    /*var id = $(this).parents(".card").attr("data-id");
    var origVote = parseInt($(this).parents(".card").find(".vote").text());*/

    /*$.get(
        '/wap/api/teacher',
        {
            id: id
        },
        function(response) {
            if(response.errno == 0) {
                $(this).addClass("success").addClass("iconfont").text(String.fromCharCode(0xe601));
                $(this).parents(".card").find(".vote").text(origVote + 1);
            } else {
                alert(response.errmsg);
            }
        }.bind(this),'json'
    );*/
});

$("button#submit[disabled!=disabled]").on("click", vote);

function vote() {
    var ids = [];
    $(".vote-btn").filter(".success").each(function() {
        var id = $(this).parents(".card").attr("data-id");
        id = parseInt(id);
        ids.push(id);
    });

    if(ids.length > 10) {
        alert("只能选择10位老师，你已选择" + ids.length + "位老师");
        return;
    } else if(ids.length < 10) {
        alert("你只选了" + ids.length + "位老师，必须投满10个");
        return;
    }

    $.get(
        '/wap/api/teacher',
        {
            id: JSON.stringify(ids)
        },
        function(response) {
            if(response.errno == 0) {
                alert("投票成功，300网薪已到帐！");
                $("button#submit").attr("disabled","disabled").text("已投票,获得300网薪！").off("click");
            } else {
                alert(response.errmsg);
            }
        }.bind(this),'json'
    );
}