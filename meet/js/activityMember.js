/*var canvas=document.getElementById("returnLine");
var ctx=document.getElementById("returnLine").getContext("2d");
var x1=canvas.offsetLeft;
var y1=canvas.offsetTop;
var x2=x1+50;
var y2=y1+50;
var x3=x1+100;
var y3=y1+100;
ctx.strokeStyle="#999";
ctx.beginPath();
ctx.moveTo(0,0);
ctx.lineTo(50,10);
ctx.lineTo(100,0);
ctx.stroke();
ctx.closePath();*/

$(document).ready(function(){
	$("#nameList div p").each(function(i){
		$(this).find("span.index").text(i+1);
	});
});
var activity_id=$(".activity").attr('id');

//发送消息
function send(e)
{
	var type=$("#messageBlock").attr("id");
	var id=$("#messageBlock .enter").attr("id");
	sendMessage(type,id,e);
}

