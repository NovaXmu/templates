var CONTENT_W = $("#content").innerWidth();
var CONTENT_H = $("#content").innerHeight();
var TOP_H = $("#top").outerHeight();

var CIR_LINE_W = 6;
var INTERVAL_W = 4;
var CANVAS_W = CONTENT_W / 3;
var FULL_CIR_R = CANVAS_W / 2 - CIR_LINE_W / 2;
var BASIC_R = FULL_CIR_R * 0.5;
var VAR_R = FULL_CIR_R * 0.5;

//var modal = $('[data-remodal-id=modal]').remodal();

$(document).ready(function() {
	$(".stamp").each(function() {
		var id = $(this).attr("id");
		var rate = $(this).data("rate");
		if ( rate ) {
			rate = parseInt(rate) / 100;
		}
		var imgSrc = $(this).find("img").attr("src");
		var name = $(this).find(".name").text();
		if(id != "me") {
			makeAvatarStamp(id, rate);
		} else {
			makeAvatarStamp("me", rate);
		}
		$(this).find("img").show();
		$(this).find("img").click(function() {
			//$(".remodal #avatar").find("img").attr("src", imgSrc).end().find("p").text(name);
			//modal.open();
			popMask(event,this);
		});
	});

	//$("#board").height(CONTENT_W * (16/9) - TOP_H);
	
});

function makeAvatarStamp(id, ratio) {
	var $stamp = $(".stamp#" + id);
	var stampWidth = $stamp.innerWidth();
	var canvas = $stamp.find(".canvas")[0];
	canvas.setAttribute("width", stampWidth);
	canvas.setAttribute("height", stampWidth);
	var ctx = canvas.getContext("2d");

	var cirRadius = /*VAR_R * ratio + BASIC_R*/ VAR_R + BASIC_R;
	ctx.lineWidth = CIR_LINE_W;	
	var centerX = CANVAS_W / 2, centerY = CANVAS_W / 2;

	ctx.beginPath();
	var gradiant = ctx.createLinearGradient(0, cirRadius, 2 * cirRadius, cirRadius);
	gradiant.addColorStop(0, "#8acae5");
	gradiant.addColorStop(1, "#c9a3e2");
	ctx.strokeStyle = gradiant;
	ctx.arc(centerX, centerY, cirRadius, 0, ratio * 2 * Math.PI);
	ctx.stroke();
	
	var $img = $stamp.find("img");
	var imgWidth = (cirRadius - INTERVAL_W - CIR_LINE_W/2 ) * 2;
	var imgPosX = (CANVAS_W - imgWidth) / 2;
	var imgPosY = (CANVAS_W - imgWidth) / 2;
	$img.width(imgWidth);
	$img.css({"position":"absolute", "top":imgPosY, "left": imgPosX, "border-radius":"50%"});
}