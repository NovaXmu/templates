$(function(){

		$("#message").keydown(function(){
			var code = window.event.keyCode;
			if(code == 13)

			{
				var text=$(".s_txt").val();
				$("#barrage-container").append("<div>"+text+"</div>");
				init_screen();
			}
		});
		
	});
	
	//初始化弹幕
	function init_screen(){
		var _top=0;

		$("#barrage-container").find("div").show().each(function(){
			var _left=($("#barrage-container").width()-$(this).width())*($(this).index()+1);
			var _height=$("#barrage-container").height();
			_top=Math.random()*(_height-70);

			var time=10000;
			//alert($(this).index());
			if($(this).index()>0){
				time=10000+5000*$(this).index();
			}
			//设定文字的初始化位置
			$(this).css({left:_left,top:_top,color:getRandomColor()});
			$(this).animate({left:"-"+_left+"px"},time,function(){
				
			});


		});
	}

	//随机获取颜色值
	function getRandomColor(){
		return '#'+(function(h){
			return new Array(7-h.length).join("0")+h
		})((Math.random()*0x1000000<<0).toString(16))
	}