/**
 * Created by zhanz on 2015/10/26.
 */
var pgUpBtn = document.getElementById("pgUp");
var pgDnBtn = document.getElementById("pgDn");
var pageWrapper = document.getElementById("main-pages");

pgUpBtn.addEventListener("click", function() {
    var current =  pgUpBtn.className.indexOf("current") !== -1;
    if (!current) {
        pageWrapper.style.left = "0";
        addClass(pgUpBtn, "current");
    } else {
        pageWrapper.style.left = "-100%";
        removeClass(pgUpBtn, "current");
    }
});

pgDnBtn.addEventListener("click", function() {
    var current =  pgDnBtn.className.indexOf("current") !== -1;
    if (!current) {
        pageWrapper.style.left = "-200%";
        addClass(pgDnBtn, "current");
    } else {
        pageWrapper.style.left = "-100%";
        removeClass(pgDnBtn, "current");
    }
});

document.querySelector("section#times").addEventListener("click", function(e) {
    var _self = e.currentTarget;
    var board = _self.querySelector("#times-bg");
    board.style.transform = "rotate(2deg)";
    setTimeout(function() {
        board.style.transform = "rotate(-3deg)";
    }, 300);
});

var game = document.getElementById("game");

new Game(game, 0.6, 15, 3, 1);

function Game(gameElem, chance, length, amount, millis) {
    var self = this;
    var screen = gameElem.querySelector("#screen");
    var btn = gameElem.querySelector("#game-btn");
    var rolling = false;
    var success = false;
    var disabled = gameElem.className.indexOf("disabled") != -1;

    btn.addEventListener("click", function() {
        /*需要在这里AJAX获取success, setSuccess后再startRolling*/
        this.setSuccess(Math.random()>0.5?true:false);
        if ( !rolling && !disabled ) {
            this.startRolling();
        }
    }.bind(this));

    this.setSuccess = function(bool) {
        success = bool;
    };

    this.startRolling = function() {
        screen.innerHTML = "";
        this.reset();
        rolling = true;
        addClass(gameElem, "rolling");
        var generator = new GameItemGenerator(screen);
        var item;
        for (var i = 0; i < length; i++) {
            if ( i == length - 1 ) {
                if ( success ) {
                    item = generator.newItem("img/ticket.jpg", 200, i * 200);
                } else {
                    item = generator.newItem("img/bomb_icon.jpg", 200, i * 200);
                }
                item.isFinal = true;
            } else {
                item = generator.newItem(null, 200, i * 200);
            }
            item.go(amount, millis);
        }
    };

    this.reset = function() {
        rolling = false;
        gameElem.className = "";
    };

    function onEnd() {
        var notice;
        if ( success ) {
            removeClass(gameElem, "faild");
            addClass(gameElem, "success");
            document.getElementById("ticketLeft").style.display = "none";
            document.getElementById("chanceLeft").style.display = "none";
            document.getElementById("token").style.display = "block";

            notice = new Notice(document.getElementById("notice"), "恭喜你，抢到票了！");
            notice.setResult("good");
            notice.show();
            setTimeout(function() {
                notice.hide();
                dispatchEvent(document.getElementById("pgDn"), "click");
                self.reset();
            }, 1500);
        } else {
            removeClass(gameElem, "success");
            addClass(gameElem, "failed");
            notice = new Notice(document.getElementById("notice"), "很遗憾，这次没抢到...");
            notice.setResult("bad");
            notice.show();
            setTimeout(function() {
                notice.hide();
            }, 1500);
        }
    }

    function GameItem(elem) {
        var interval;
        this.elem = elem;
        this.isFinal = false;
        this.getPosY = function() {
            return +this.elem.style.top.slice(0,-2);
        };
        this.getSize = function() {
            return +this.elem.style.height.slice(0,-2);
        };
        this.go = function(amount,perSecond) {
            var self = this;
            interval = setInterval(function() {
                if (self.isFinal && self.getPosY() < 0) {
                    self.elem.style.top = self.getPosY() + 1 + "px";
                } else {
                    self.elem.style.top = self.getPosY() - amount + "px";
                }

                if (self.isFinal && self.getPosY() == 0) {
                    self.stop();
                    rolling = false;
                    removeClass(gameElem, "rolling");
                    onEnd();
                }

                if (self.getPosY() < -self.getSize()) {
                    self.stop();
                    self.die();
                }
            }, perSecond);
        };

        this.stop = function() {
            clearInterval(interval);
        };

        this.die = function() {
            this.elem.parentNode.removeChild(this.elem);
            return elem;
        }
    }

    function GameItemGenerator(wrapper) {
        this.newItem = function(url, size, initPosY) {
            var img = document.createElement("img");
            img.src = url || (Math.random()<chance? "img/ticket.jpg" : "img/bomb_icon.jpg");
            img.style.width = size + "px";
            img.style.height = size + "px";
            img.style.top = initPosY + "px";
            wrapper.appendChild(img);
            return new GameItem(img);
        }
    }
}

function Notice(elem, msg) {
    elem.innerHTML = msg;
    this.setResult = function(str) {
        removeClass(elem, "good");
        removeClass(elem, "bad");
        addClass(elem, str);
    };
    this.show = function() {
        addClass(elem, "show");
    };
    this.hide = function() {
        removeClass(elem, "show");
        elem.className = "";
    };
}

function removeClass(elem, classN) {
    elem.className = elem.className.replace(new RegExp("(?:^|\\s)"+ classN +"(?!\\S)"), '' );
}

function addClass(elem, classN) {
    elem.className = elem.className.concat(" " + classN);
}

function preload(url) {
    var preloadImg = document.createElement("img");
    preloadImg.src = url;
    preloadImg.style.display = "none";
    document.body.appendChild(preloadImg);
}

function dispatchEvent(elem, type) {
    if (typeof Event == "undefined") {
        var event = document.createEvent("Event");
        event.initEvent(type, true, true)
    } else {
        event = new Event(type);
    }
    elem.dispatchEvent(event);

}

preload("img/ticket.jpg");
preload("img/bomb_icon.jpg");

var n = 1;
setInterval(function() {
    document.querySelector("#token span:nth-child(" + n + ")").style.fontSize = "130%";
    setTimeout(function() {
        document.querySelector("#token span:nth-child(" + n + ")").style.fontSize = "inherit";
        if (n == 16) {
            n = 1;
        } else {
            n++;
        }
    }, 500);
}, 1300);
