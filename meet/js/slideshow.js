/**
 *
 * Created by zhanz on 2015/9/29.
 */
function SlideShow(elem, op) {
    var $ul = $(elem);
    var options = {
        itemWidth: 'auto',
        initOffset: 0
    };
    options = $.extend(options, arguments[1]);
    this.length = function() {
        return $ul.children("li").size();
    };

    this.currentIndex = function() {
        return $ul.children("li").index($ul.children(".current"));
    };

    this.init = function() {
        var w = 0;
        var _this = this;
        var hammer = new Hammer(document.querySelector(elem), {
            domEvents: true
        });
        hammer.get("swipe").set({
            velocity: 0.1,
            threshold: 1
        });

        hammer.on("swipeleft", function(e) {
            e.preventDefault();
            _this.slideNext();
        });
        hammer.on("swiperight", function(e) {
            e.preventDefault();
            _this.slidePrev();
        });
        $ul.css("left", options.initOffset);
        $ul.children("li").each(function() {
            var mLeft = $(this).css("marginLeft");
            var mRight = $(this).css("margin-right");
            $(this).width(Math.floor(options.itemWidth - parseInt(mLeft.slice(0,mLeft.indexOf("px"))) - parseInt(mRight.slice(0,mRight.indexOf("px")))));
            w += $(this).outerWidth(true);
            $(this).removeClass("current").on("click", function() {
                var target = $(this);
                _this.clickHandler(target);
            });
        });
        $ul.children("li").eq(0).click();
        $ul.width(w);
    };
    this.clickHandler = function(target) {
        target.addClass("current").siblings("li").removeClass("current");
        this.focusCurrent();
    };
    this.focusCurrent = function() {
        var offset = 0;
        var currentIndex = this.currentIndex();
        for ( var i = 0; i < currentIndex; i++ ) {
            offset += $ul.children("li").eq(i).outerWidth(true);
        }
        if ( !$ul.is(":animated") ) {
            $ul.animate({"left": options.initOffset-offset + "px"});
        }
    };
    this.slideNext = function() {
        if ( this.currentIndex() < this.length() - 1 ) {
            $ul.children("li").eq(this.currentIndex()).removeClass("current").next().addClass("current");
            this.focusCurrent();
        }
    };
    this.slidePrev = function() {
        if ( this.currentIndex() > 0 ) {
            $ul.children("li").eq(this.currentIndex()).removeClass("current").prev().addClass("current");
            this.focusCurrent();
        }
    }
}