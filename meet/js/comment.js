
/**
 * 文本框根据输入内容自适应高度
 * @param                {HTMLElement}        输入框元素
 * @param                {Number}             设置光标与输入框保持的距离(默认0)
 * @param                {Number}             设置最大高度(可选)
 */
var autoTextarea = function (elem, extra, maxHeight) {
        extra = extra || 0;
        var isFirefox = !!document.getBoxObjectFor || 'mozInnerScreenX' in window,
        isOpera = !!window.opera && !!window.opera.toString().indexOf('Opera'),
                addEvent = function (type, callback) {
                        elem.addEventListener ?
                                elem.addEventListener(type, callback, false) :
                                elem.attachEvent('on' + type, callback);
                },
                getStyle = elem.currentStyle ? function (name) {
                        var val = elem.currentStyle[name];
 
                        if (name === 'height' && val.search(/px/i) !== 1) {
                                var rect = elem.getBoundingClientRect();
                                return rect.bottom - rect.top -
                                        parseFloat(getStyle('paddingTop')) -
                                        parseFloat(getStyle('paddingBottom')) + 'px';        
                        };
 
                        return val;
                } : function (name) {
                                return getComputedStyle(elem, null)[name];
                },
                minHeight = parseFloat(getStyle('height'));
 
        elem.style.resize = 'none';
 
        var change = function () {
                var scrollTop, height,
                        padding = 0,
                        style = elem.style;
 
                if (elem._length === elem.value.length) return;
                elem._length = elem.value.length;
 
                if (!isFirefox && !isOpera) {
                        padding = parseInt(getStyle('paddingTop')) + parseInt(getStyle('paddingBottom'));
                };
                scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
 
                elem.style.height = minHeight + 'px';
                if (elem.scrollHeight > minHeight) {
                        if (maxHeight && elem.scrollHeight > maxHeight) {
                                height = maxHeight - padding;
                                style.overflowY = 'auto';
                        } else {
                                height = elem.scrollHeight - padding;
                                style.overflowY = 'hidden';
                        };
                        style.height = height + extra + 'px';
                        scrollTop += parseInt(style.height) - elem.currHeight;
                        document.body.scrollTop = scrollTop;
                        document.documentElement.scrollTop = scrollTop;
                        elem.currHeight = parseInt(style.height);
                };
        };
 
        addEvent('propertychange', change);
        addEvent('input', change);
        addEvent('focus', change);
        change();
};
function focusTextarea(e){
        $(e).next().show();
        autoTextarea(e);
}
function blurTextarea(e){
        if($(e).attr('id')=="COMMENT"){
                $(e).next().hide();
                $(e).val('');
                $(e).css("height","25");
        }
        else{
                $(e).val('');
                $(e).parent().hide();
        }
}


//点赞&取消赞 type=1(话题)|2(评论);
function praise(e,type,to_id){
        //alert(to_id);
        if(type==1){
                if($(e).hasClass("great")){
                        var count=parseInt($(e).next().text())-1;
                        $(e).removeClass("great");
                        $(e).attr("src","/templates/meet/img/dianzan.png");
                        $(e).next().text(count);
                }
                else{
                        var count=parseInt($(e).next().text())+1; 
                        $(e).addClass("great");
                        $(e).attr("src","/templates/meet/img/quxiaozan.png");
                        $(e).next().text(count);
                }

        }
        if(type==2){
                if($(e).hasClass("great")){
                        var count=parseInt($(e).next().text())-1;
                        $(e).removeClass("great");
                        $(e).text("点赞");
                        $(e).next().text(count);
                }
                else{
                        var count=parseInt($(e).next().text())+1;
                        $(e).addClass("great");
                        $(e).text("取消赞");
                        $(e).next().text(count);
                }
        }
        $.post(
                "/meet/api/topic?m=addPraise",
                {
                        'type':type,
                        'to_id':to_id
                },
                function(data){
                        data=jQuery.parseJSON(data);
                        if(data.errno!=0)
                                alert(data.errmsg);
                });
}

//点击评论符号
function pinglunClick(e){
        $(e).parents(".topic").find("#COMMENT").focus();
        
}

//评论
function comment(e,topic_id,to_id,comment_id){
        var content=$(e).prev().val();
        $.post(
                "/meet/api/topic?m=addComment",
                {
                        'topic_id':topic_id,
                        'content':content,
                        'to_id':to_id,
                        'comment_id':comment_id
                },
                function(data){
                        data=jQuery.parseJSON(data);
                        if(data.errno!=0)
                                alert(data.errmsg);
                        else{
                                //alert("发送成功");
                                location.reload();
                        }
                });
}