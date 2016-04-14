var WINDOW_W = $(window).width();
var CONTENT_W = $("#content").innerWidth();
var BOARD_W = CONTENT_W;
var OUTER_R = (5/6) * (BOARD_W / 2);
var INNER_R = 0.29 * OUTER_R;
var CENTER_X = BOARD_W / 2;
var CENTER_Y = BOARD_W / 2;
var FULL_SCORE = 100;
var PI = Math.PI;

var size = $(".board").size();
var ulWidth = size * BOARD_W;
//var ul =  $(".boards").find("ul");
/*var canvas=$(".board").find(".canvas")[0];
var myPoint=parseInt($("#er1").find(".value").text());
var hePoint=parseInt($("#er2").find(".value").text());
if(myPoint>hePoint){
            hePoint=hePoint/myPoint;
            myPoint=1;
        }
        else{
            myPoint=myPoint/hePoint;
            hePoint=1;
        }
*/
$(document).ready(function() {

    var meColor=$("#meColor").get(0).getContext("2d");
    meColor.fillStyle="#63d69e";
    meColor.fillRect(0,0,20,5);
    meColor.fillStyle="#f9f9f6";
    meColor.fillRect(0,5,20,5);

    var heColor=$("#heColor").get(0).getContext("2d");
    heColor.fillStyle="#9192e8";
    heColor.fillRect(0,0,20,5);
    heColor.fillStyle="#f9f9f6";
    heColor.fillRect(0,5,20,5);

    //ul.width(ulWidth).find("li").width(BOARD_W);
    //$(".board").each(function() {
        var canvas = $(".canvas")[0];
        var ctx = canvas.getContext("2d");
        canvas.setAttribute("width", BOARD_W);
        canvas.setAttribute("height", BOARD_W);
        //var name = canvas.getAttribute("data");
        var myPoint=parseInt($("#er1").find(".value").text());
        var hePoint=parseInt($("#er2").find(".value").text());
        //if(myPoint>hePoint){
        //    hePoint=hePoint/myPoint;
        //    myPoint=1;
        //}
        //else{
            var myRate=myPoint/ (myPoint + hePoint);
            var heRate=hePoint / (myPoint + hePoint);
        //}
        //var a = new Board(0,0);
        var i = 0, j=0;
            var interval = setInterval(function() {
                var b = new Board(ctx, i,j);
                b.clear(canvas);
                b.draw();
                if (i>=myRate && j>=heRate) clearInterval(interval);
                if (i < myRate) i+=0.005;
                if (j < heRate) j+=0.005;
            }, 6);
        //var b = new Board(ctx, myRate,heRate);
        //b.draw();
    });

    //$(".ui-loader").remove();
//});

/*function point(){
    var b=new Board(myPoint,hePoint);
    b.draw(canvas);
}*/
/*
$(ul).on("swiperight",function() {
    //ul右移
    if(($(this).position().left) < 0 && ! $(this).is(":animated")) {
        $(this).stop(false,true).animate({"left":"+=" + BOARD_W + "px"});
    }

}).on("swipeleft",function() {
    //ul左移
    if(($(this).position().left) > -ulWidth + BOARD_W && ! $(this).is(":animated")) {
        $(this).stop(false,true).animate({"left": "-=" + BOARD_W + "px"});
    }
});*/

function Board(ctx, ratio1, ratio2) {
    //this.name = name;
    this.ctx = ctx;
    this.p1 = new Pointer(ratio1, this);
    this.p2 = new Pointer(ratio2, this);
}

Board.prototype = {
    draw: function() {
        this.ctx.save();
        this.ctx.translate(CENTER_X,CENTER_Y);
        //画外圆边
        this.ctx.beginPath();
        this.ctx.strokeStyle = "#dcdddd";
        this.ctx.lineWidth = 3;
        this.ctx.arc(0, 0, OUTER_R, 0, 2*PI);
        this.ctx.fillStyle = "white";
        this.ctx.fill();
        this.ctx.stroke();

        //画渐变圈
        this.ctx.beginPath();
        var gradient = this.ctx.createLinearGradient(-OUTER_R, 0, OUTER_R, 0);
        gradient.addColorStop(0, "#63d69e");
        gradient.addColorStop(1, "#9192e8");
        this.ctx.strokeStyle = gradient;
        this.ctx.lineWidth = 10;
        this.ctx.lineCap = "round";
        this.ctx.arc(0, 0, 0.89 * OUTER_R, 13 / 6 * PI, 17 / 6 * PI, true);
        this.ctx.stroke();

        //画小刻度
        var outMarkR = 0.8 * OUTER_R;
        var inMarkR = 0.77 * OUTER_R;
        var changeRate = PI/30;
        this.ctx.beginPath();
        this.ctx.strokeStyle = "#dcdddd";
        this.ctx.lineWidth = 2;
        drawTickMark(outMarkR, inMarkR, changeRate, this.ctx);
        //画大刻度
        inMarkR = 0.7 * OUTER_R;
        changeRate = PI/6;
        this.ctx.beginPath();
        this.ctx.strokeStyle = "#dcdddd";
        this.ctx.lineWidth = 4;
        drawTickMark(outMarkR, inMarkR, changeRate, this.ctx);

        //画内蓝圈
        this.ctx.beginPath();
        this.ctx.arc(0, 0, INNER_R, 0, 2*PI);
        this.ctx.fillStyle = "#5d66eb";
        this.ctx.fill();

        //画内圆
        this.ctx.beginPath();
        var INNER_R2 = 0.58 * INNER_R;
        this.ctx.arc(0,0,INNER_R2,0,2*PI);
        this.ctx.lineWidth = 3;
        this.ctx.strokeStyle = "#d2d2d2";
        gradient = this.ctx.createLinearGradient(-INNER_R2, 0, INNER_R2, 0);
        gradient.addColorStop(0,"#bcbbb6");
        gradient.addColorStop(1,"#838080");
        this.ctx.fillStyle = gradient;
        this.ctx.fill();
        this.ctx.stroke();

        //写字2
        this.ctx.beginPath();
        this.ctx.font="20px 华文细黑";
        this.ctx.textAlign = "center";
        this.ctx.textBaseline = "center";
        this.ctx.fillStyle = "#8093e8";
        this.ctx.fillText("0", -OUTER_R*(3/4), OUTER_R * (5/8));
        this.ctx.fillText("1",OUTER_R*(3/4),OUTER_R*(5/8));
        //this.ctx.fillText("0", 0, OUTER_R * (3/4));

        //画指针
        this.p1.draw(this.ctx,"me");
        this.p2.draw(this.ctx,"he");
        //this.p1.draw(canvas);
        //this.p2.draw(canvas);
    },
    
    clear: function(canvas) {
        this.ctx.restore();
        this.ctx.clearRect(0,0,canvas.width, canvas.height);
    }
};

function Pointer(ratio) {
    this.ratio = ratio;
    this.context = null;
}

Pointer.prototype = {
    draw: function(ctx,type) {
        var r1 = 0.25 * INNER_R;
        var r2 = 0.19 * INNER_R;
        var r3 = 0.08 * INNER_R;
        var RANGE = 240 * PI / 180;
        var ZERO = 210 * PI /180;
        var ADD = RANGE * this.ratio;

        //画针
        if(type=="me"){
        ctx.beginPath();
        ctx.save();
        ctx.rotate(-ZERO + ADD);
        ctx.moveTo(0, -r1 - 0.5);
        var l = 0.85 * OUTER_R;
        ctx.lineTo(l, 0);
        ctx.lineTo(0, 0);
        ctx.closePath();
        //ctx.fillStyle = "#bcbbb6";
        ctx.fillStyle="#63d69e";
        ctx.fill();
        ctx.lineTo(0, r1 + 0.5);
        ctx.lineTo(l, 0);
        ctx.fillStyle = "#f9f9f6";
        ctx.fill();
        }
        if(type=="he"){
        ctx.beginPath();
        ctx.save();
        ctx.rotate(-ZERO + ADD);
        ctx.moveTo(0, -r1 - 0.5);
        l = 0.85 * OUTER_R;
        ctx.lineTo(l, 0);
        ctx.lineTo(0, 0);
        ctx.closePath();
        //ctx.fillStyle = "#bcbbb6";
        ctx.fillStyle="#9192e8";
        ctx.fill();
        ctx.lineTo(0, r1 + 0.5);
        ctx.lineTo(l, 0);
        ctx.fillStyle = "#f9f9f6";
        ctx.fill();
        }
        

        //画三个圆 
        //第一个圆分两部分填色，上半圆为灰色，下半圆较白
        ctx.beginPath();
        ctx.arc(0,0,r1,0,PI);
        ctx.fillStyle = "#f9f9f6";
        ctx.fill();

        ctx.beginPath();
        ctx.arc(0,0,r1,PI,2*PI);
        ctx.fillStyle = "#bcbbb6";
        ctx.fill();

        ctx.beginPath();
        ctx.arc(0,0,r2,0,2*PI);
        ctx.fillStyle = "#898989";
        ctx.fill();

        ctx.beginPath();
        ctx.arc(0,0,r3,0,2*PI);
        ctx.fillStyle = "#dcdddd";
        ctx.fill();
        ctx.restore();

        this.context = ctx;
    }
};

function Segment(startX, startY, endX, endY) {
    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;
}

Segment.prototype = {
    //变换前原点位于变换后坐标系中的位置：(x,y)
    switchCoordinate4Canvas: function(x,y) {
        this.startX+=x;
        this.startY = -(this.startY+=y);
        this.endX+=x;
        this.endY = -(this.endY+=y);
    }
};

function drawSegment(seg, ctx) {
    ctx.beginPath();
    ctx.moveTo(seg.startX,seg.startY);
    ctx.lineTo(seg.endX,seg.endY);
    ctx.stroke();
}

function drawTickMark(outR,inR,rate,ctx) {
    for(var angle=0; angle<PI; angle+=rate) {
        var startX = Math.cos(angle) * outR;
        var startY = -Math.sin(angle) * outR;
        var endX = -startX;
        var endY = -startY;
        var halfLineStartAngle = round(PI/6,10);
        var halfLineEndAngle = round(PI * (5/6),10);
        angle = round(angle,10);
        if(angle > halfLineStartAngle && angle < halfLineEndAngle) {
            endX = 0;
            endY = 0;
        }
        var seg = new Segment(startX, startY, endX, endY);
        //seg.switchCoordinate4Canvas(BOARD_W / 2,-(BOARD_W / 2));
        drawSegment(seg,ctx);
    }
    ctx.closePath();

    ctx.arc(0, 0, inR, 0, 2*PI);
    ctx.fillStyle = "#fff";
    ctx.fill();
    ctx.closePath();
}

//v数保留小数点后e位数
function round(v,e){
    var t=1;
    for(;e>0;t*=10,e--);
    for(;e<0;t/=10,e++);
    return Math.round(v*t)/t;
}
