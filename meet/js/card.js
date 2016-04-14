var CONTENT_W = $("#list").innerWidth();
var LI_W = CONTENT_W * 0.6;
var OFFSET = (CONTENT_W - LI_W) / 2;

$(document).ready(function() {
    var slideShow = new SlideShow("#list ul", {
        itemWidth: LI_W,
        initOffset: OFFSET
    });
    slideShow.init();

    $(".ui-loader").remove();
});

//跳转到修改名片
$("#list ul li .bottom").click(function(){
    var type=$(this).parents(".act").data("type");
    window.location.href="/meet/person?m=label&type="+type;
});



