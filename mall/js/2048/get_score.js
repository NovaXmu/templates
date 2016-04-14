var get_code=0;
var best_score_today=0;

//覆盖原有setup方法，把setup过程放到ajax回调函数中，保证
GameManager.prototype.setup = function() {
	var self = this;
	window.localStorage.clear(); //清除游戏默认留下的缓存
	$.get("/mall/api/game2048",  //进入页面是发起请求
		{m:"start"},
		function(data){
			var obj = eval("("+data+")");
			if(obj["errno"]==0){
				get_code = obj["data"]["code"];
				best_score_today=obj["data"]["highestScore"];

				//以下部分为原方法内容
				var previousState = self.storageManager.getGameState();

				// Reload the game from a previous game if present
				if (previousState) {
					self.grid        = new Grid(previousState.grid.size,
						previousState.grid.cells); // Reload grid
					self.score       = previousState.score;
					self.over        = previousState.over;
					self.won         = previousState.won;
					self.keepPlaying = previousState.keepPlaying;
				} else {
					self.grid        = new Grid(self.size);
					self.score       = 0;
					self.over        = false;
					self.won         = false;
					self.keepPlaying = false;

					// Add the initial tiles
					self.addStartTiles();
				}

				// Update the actuator
				self.actuate();
			}else{
				alert(obj["errmsg"]);
			}
		}
	);
};

//覆盖原有actuate方法，加入自定义的send_score函数
HTMLActuator.prototype.actuate = function (grid, metadata) {
	var self = this;

	window.requestAnimationFrame(function () {
		self.clearContainer(self.tileContainer);

		grid.cells.forEach(function (column) {
			column.forEach(function (cell) {
				if (cell) {
					self.addTile(cell);
				}
			});
		});

		self.updateScore(metadata.score);
		self.updateBestScore(/*metadata.bestScore*/ best_score_today); //詹子洋修改

		if (metadata.terminated) {
			if (metadata.over) {
				self.message(false); // You lose
				/////////////////////////此处为南洋修改内容，20150630///////
				send_score(get_code);//游戏结束后反馈分数到后端
				/////////////////////////此处为南洋修改内容，20150630///////
			} else if (metadata.won) {
				self.message(true); // You win!
				/////////////////////////此处为南洋修改内容，20150630///////
				send_score(get_code);//游戏结束后反馈分数
				/////////////////////////此处为南洋修改内容，20150630///////
			}
		}

	});
};

window.requestAnimationFrame(function () {
	new GameManager(4, KeyboardInputManager, HTMLActuator, LocalStorageManager);
});

function send_score(get_code){//调用部分在html_actuator.js
    var score = $(".score-container").text();//获取分数，得到的是  分数+加分，应该把+加分去掉。
    var pos_add =score.indexOf("+");    //获取“+”的位置，下面在将加号后的去除
    var final_score =0;

    if(pos_add==-1){    
      final_score = score;
    }else{
       final_score =score.substring(0,pos_add);
    }


    $.post("/mall/api/game2048",  //第二次
        {m:"saveScore",
    	 score:final_score,
    	 code:get_code},
        function(data){
        	var obj = eval("("+data+")"); 
        	if(obj["errno"]==0){
				alert("少年郎~"+obj.errmsg+"。可获得网薪数为："+obj["award"]);
        	}else{
        		alert(obj["errmsg"]);
        	} 
        }

    );
}

$(document).ready(function(){
	var gameContainer = $(".game-container");
	var gameInnerH = gameContainer.innerHeight();
	if ( gameInnerH > 500 ) {
		gameContainer.innerHeight(500).css("paddingBottom",0);
	}
	$(".restart-button").click();
});


