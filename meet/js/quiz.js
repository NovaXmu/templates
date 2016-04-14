/**
 * Created by zhanz on 2015/7/10.
 */

var CONTENT_W = $("#content").innerWidth();
var TOP_H = $("#top").outerHeight();
var LI_W = CONTENT_W;
var quizLi = $("li.quiz");
var ul = $("#list").find("ul").eq(0);
var LI_OUTER_W = quizLi.outerWidth();
var UL_W = LI_OUTER_W * quizLi.size();

var AVATAR_R = $("#avatar").find(".wrap").width() / 2;
var AVATAR_POS = $("#avatar").position();

var option = $(".options").find("li.option");
var OPTION_DEFAULT_W = 0.6 *  LI_W;
var OPTION_CHOSEN_W = 0.8 * LI_W;

var barCanvas = document.getElementById("canvas");
var CANVAS_W = CONTENT_W * 0.8;
var LINE_L = CANVAS_W * 0.8;
var pointX1 = (CANVAS_W - LINE_L) / 2;
var pointX2 = pointX1 +　LINE_L;

var CURRENT_Q_INDEX = 1;

$(document).ready(function () {
    $("#ceiling").height(AVATAR_POS.top - TOP_H + AVATAR_R);

    quizLi.width(LI_W);
    LI_OUTER_W = quizLi.outerWidth();
    UL_W = (LI_OUTER_W + 20) * quizLi.size();
    ul.width(UL_W);
    OPTION_DEFAULT_W = 0.6 *  LI_W;
    option.width(OPTION_DEFAULT_W);

    $(".ui-loader").remove();


    updateBar(1);
});



function updateBar(index) {

    var quizE = $(".quiz");
    var numOfQuiz = quizE.size();
    var per = index / numOfQuiz;
    if(per > 1 || per < 0) {
        alert("出了点意外状况");
    } else {
        var CANVAS_W = CONTENT_W * 0.8;
        barCanvas.setAttribute("width", CANVAS_W);
        barCanvas.setAttribute("height", 20);
        var context = barCanvas.getContext("2d");
        context.clearRect(0,0,CANVAS_W,0);

        context.beginPath();
        context.moveTo(pointX1 + LINE_L * per, 5);
        context.lineTo(pointX2, 5);
        context.strokeStyle = "#d2d2d2";
        context.lineWidth = 6;
        context.lineCap = "round";
        context.stroke();

        context.beginPath();
        context.moveTo(pointX1, 5);
        context.lineTo(pointX1 + LINE_L * per, 5);
        var gradient = context.createLinearGradient(0,0,CANVAS_W,0);
        gradient.addColorStop(0,"#74abc9");
        gradient.addColorStop(1,"#ae88c7");
        context.strokeStyle = gradient;
        context.lineWidth = 6;
        context.lineCap = "round";
        context.stroke();


    }
}

option.on("click",function() {
    if($(this).hasClass("chosen")) {
        $(this).removeClass("chosen").width(OPTION_DEFAULT_W);
    } else {
        $(this).siblings("li.option").removeClass("chosen").width(OPTION_DEFAULT_W).end().addClass("chosen").width(OPTION_CHOSEN_W);
    }
});

ul.on("swiperight",function() {
    //ul右移
    if(($(this).position().left) < 0 && ! $(this).is(":animated")) {
        $(this).stop(false,true).animate({"left":"+=" + (LI_OUTER_W + 20) + "px"},function() {
            CURRENT_Q_INDEX--;
            updateBar(CURRENT_Q_INDEX)
        });
    }

}).on("swipeleft",function() {
    //ul左移
    //alert(-UL_W + LI_OUTER_W );
    if(($(this).position().left) > -UL_W + LI_OUTER_W + 20 && ! $(this).is(":animated")) {
        $(this).stop(false,true).animate({"left": "-=" + (LI_OUTER_W + 20) + "px"},function() {
            CURRENT_Q_INDEX++;
            updateBar(CURRENT_Q_INDEX);
        });
    }
});
