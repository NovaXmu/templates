//创建部落
function create() {
    $(".bloglist").hide();
    $(".establish").show();
}
$("button.submit").click(function () {
    var name = $("input#name").val();
    var introduction = $("input#introduction").val();
    if (!name) {
        alert("名称不能空");
        return;
    }
    var info = {
        'name': name,
        'introduction': introduction
    };
    $.post(
        "/meet/api/blog?m=addBlog",
        {
            'data': JSON.stringify(info)
        },
        function(response) {
            var data = JSON.parse(response);
            if (data.errno != 0) {
                alert(data.errmsg);                              
            }
            else {
                location.reload();
            }
        });
});

//加入部落
function joinHandler(e) {
    stopPropagation(e);
    var blog_id = $(e.target).parents(".blog").attr('id');
    if ( confirm("确认加入此部落？") ) {
        add(blog_id, $(e.target));
    }
}
function add(id, btnImg) {
    $.post(
        "/meet/api/blog?m=joinBlog",
        {
            'blog_id': id
        },
        function(data) {
            data = jQuery.parseJSON(data);
            if (data.errno == 0) {
                btnImg.replaceWith('<img src="' + BASE + 'meet/img/pink.png" class="Added">');
            }
            else {
                alert(data.errmsg);
            }
        }
    );
}

//退出部落
function quitHandler(e) {
    stopPropagation(e);
    var blog_id = $(e.target).parents(".blog").attr('id');
    if ( confirm("确认退出此部落？") ) {
        quit(blog_id, $(e.target));
    }
}
function quit(id, btnImg) {
    $.post(
        "/meet/api/blog?m=quitBlog",
        {
            'blog_id': id
        },
        function (data) {
            data = jQuery.parseJSON(data);
            if (data.errno == 0) {
                btnImg.replaceWith('<img src="'+ BASE +'meet/img/grey.png" class="noAdded">');
            } else {
                alert(data.errmsg);
            }
        }
    );
}

//查看成员
function viewMember(e) {
    var id = $(e).parent().parent().attr('id');
    window.location.href = "/meet/blog?m=blogMember&blog_id=" + id;
}

//我加入的
$(".tab-right").click(function () {
    window.location.href = "/meet/blog?m=blog&isMine=1";
});
//部落列表
$(".tab-left").click(function () {
    window.location.href = "/meet/blog?m=blog";
});

//进入部落
$("div.info").click(function (e) {
    var target = $(e.target);
    if ( target.is("img.noAdded") ) {
        joinHandler(e);
        return;
    }
    if ( target.is("img.Added") ) {
        quitHandler(e);
        return;
    }
    var blog_id = $(this).parent().attr('id');
    window.location.href = "/meet/blog?m=activity&blog_id=" + blog_id;
});