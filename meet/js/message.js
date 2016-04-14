var index;//记录‘查看更多消息’按钮的点击次数
$(document).ready(function(){
    location.hash = "#lastMsg";
    index=0;
});

//查看更多消息
function viewMore(type,id){
    index=index+1;
    var userid=$("#footer span.userid").text();
   $.post(
    "/meet/api/message?m=getMoreMessage",
    {
        'type':type,
        'to_id':id,
        'index':index
    },
    function(data)
    {
        data=jQuery.parseJSON(data);
        if ( !data || data.length == 0 ) {
            alert("没有更多消息");
            return;
        }
        for(var i in data)
        {
            if(data.hasOwnProperty(i) && data[i].from_user_ybid==userid)
                $(".messagelist ul").prepend('\
                <li style="text-align:right;">\
                <img src="http://img02.fs.yiban.cn/'+data[i].from_user_ybid+'/avatar/user/30" class="face popMask" id="'+data[i].from_user_ybid+'" onclick="popMask(event,this)">\
                <span style="font-size:10px;display:none;">'+data[i].time+'</span>\
                <p style="font-size:15px;">'+data[i].content+'</p>\
                </li>');
            else
                $(".messagelist ul").prepend('\
                <li style="text-align:left;">\
                <img src="http://img02.fs.yiban.cn/'+data[i].from_user_ybid+'/avatar/user/30" class="face popMask" id="'+data[i].from_user_ybid+'" onclick="popMask(event,this)">\
                <span style="font-size:10px;display:none;">'+data[i].time+'</span>\
                <p style="font-size:15px;">'+data[i].content+'</p>\
                </li>');
        }
    });
}

