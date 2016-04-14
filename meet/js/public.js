//底部菜单跳转
$(".bill").on("click", function() {
    var n = $(this).find(".n");
    var name = $(this).attr("id");
    var otherN = $(this).siblings(".bill").find(".n");
            switch(name) {
                case 'circle':
                    window.location.href="/meet/person?m=circle";
                    break;
                case 'topic':
                    window.location.href="/meet/topic?m=index";
                    break;
                case 'blog':
                    window.location.href="/meet/blog?m=blog";
                    break;
                case 'pageview':
                    window.location.href="/meet/person?m=index";
                    break;
                case 'history':
                    window.location.href="/meet/message?m=index";
                    break;
            }
        otherN.hide().parent().removeClass("clickable");
        otherN.hide().parent().removeClass('border');
        n.show().parent().addClass("clickable");
        n.show().parent().addClass('border');
});

//内部标签页按钮activate
function activateTab(tab) {
    tab.addClass("active").siblings().removeClass("active");
}


//查看消息 type=1(用户&user_ybid)|2(活动&activity_id)|3(部落&blog_id)|4(pk) 
function viewMessage(type,id)
{
	var idName;
	switch(type){
		case '1':idName="user_ybid";break;
		case '2':idName="activity_id";break;
		case '3':idName="blog_id";break;
	}
	window.location.href="/meet/message?m=readMessage&type="+type+"&"+idName+"="+id+"";
}

//阻止冒泡
function stopPropagation(e) {  
    e = e || window.event;  
    if(e.stopPropagation) { //W3C阻止冒泡方法  
        e.stopPropagation();  
    } else {  
        e.cancelBubble = true; //IE阻止冒泡方法  
    }  
}

function loading() {
    var loading = document.getElementById("loading");
    loading.style.display = "block";
}

function loaded() {
    var loading = document.getElementById("loading");
    loading.style.display = "none";
}

$(function () {
    var elem = document.createElement("img");
    elem.setAttribute("id", "loading");
    elem.src = BASE + "meet/img/loader.gif";
    elem.style.display = "none";
    document.body.appendChild(elem);
});