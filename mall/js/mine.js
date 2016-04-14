var contentInnerWidth = $("#content").innerWidth();
var itemWidth = contentInnerWidth - 20;

$(document).ready(function() {
	fixLayout();

    $("#nav div").each(function (i) {
        $(this).click(function () {
            showcaseSwipe(i);
            return false;
        });
    });

    $("#nav").find("div").bind("click", function() {
    	$(this).siblings('div').removeClass('active');
    	$(this).addClass('active');
    	return false;
    });

    $(".showLogBtn").bind("click", function() {
        $(this).parent().siblings('table').fadeToggle('slow');
        return false;
    })
});

$(window).resize(function(event) {
	fixLayout();
});

function fixLayout() {
	$("#main ul").css("width", itemWidth * 3);
	$("#main ul li.part").css("width", itemWidth);
    
}

function showcaseSwipe(index) {
    var tl = new TimelineLite();
    tl.to($('#main ul'), 0.8, {left: -(itemWidth * index) + "px", ease: Back.easeOut});
}