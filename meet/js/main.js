/**
 * Created by zhanz on 2015/7/10.
 */

var CONTENT_W = $("#content").innerWidth();
var WINDOW_H = $(window).height();
var TOP_H = $("#top").outerHeight();
var MENU_H = $("#footer").outerHeight();
//var menuBill = $(".bill");

$(document).ready(function() {
    $("#showcase")/*.width(CONTENT_W)*/.height(WINDOW_H-TOP_H-MENU_H);
    var sex=$("span.sex").text();
    if(sex=="F")
        $("#showcase img").attr("src","/templates/meet/img/f.png").show();
    else
        $("#showcase img").attr("src","/templates/meet/img/m.png").show();
});

//查看名片
$("#showcase button").click(function(){
    var user_ybid=$(this).attr("id");
    //alert(user_ybid);
    window.location.href="/meet/person?m=card&user_ybid="+user_ybid+" ";
});