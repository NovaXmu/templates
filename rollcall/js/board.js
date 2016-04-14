//解决二维码中中文乱码问题（这次基本用不到，token不会是中文）
function toUtf8(str) {
    var out, i, len, c;
    out = "";
    len = str.length;
    for (i = 0; i < len; i++) {
        c = str.charCodeAt(i);
        if ((c >= 0x0001) && (c <= 0x007F)) {
            out += str.charAt(i);
        } else if (c > 0x07FF) {
            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
            out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
        } else {
            out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
        }
    }
    return out;
}

var act = $('#page #act').text();
// var refreshDelayTime = parseInt($("#info p").eq(4).text()) * 1000;

function refreshQRcode() {
    $.get(
        '/rollcall/api/token?m=refresh&act=' + act,
        function (data, status) {
            $('#page #QRcode').html('');
            if (status == "success") {
                data = jQuery.parseJSON(data);
                if (data.errno == '0') {
                    token = data.data.token;
                    // http://www.helloweba.com/view-blog-226.html
                    $('#page #QRcode').qrcode({
                        width: 430,
                        height: 430,
                        text: token
                    });
                    refreshQRcode();
                }
            }
            else {
                alert("网络中断，请检查网络连接");
            }

        }
    );
}

function switchContent() {
    $("#process").animate({
            "opacity": 0,
        },
        1000, function () {
        }).delay(8000);
    $("#text").animate({
            "opacity": 1,
        },
        1000, function () {
        }).delay(8000);
    $("#process").animate({
            "opacity": 1,
        },
        1000, function () {
        }).delay(8000);
    $("#text").animate({
            "opacity": 0,
        },
        1000, function () {
        }).delay(8000);
    var switchLoop = setTimeout("switchContent()", 0);
}

String.prototype.len = function ()           // 给string增加个len ()方法，计算string的字节数
{
    return this.replace(/[^\x00-\xff]/g, "xx").length;
}

function fixTitle() {
    //$("#act-name").text("厦门市弘语言隐喻");
    var title = $("#act-name").text();
    var titleLength = title.len();
    if (titleLength <= 22) {
        $("#act-name").css({"font-size": "38px"});
    }
    else if (titleLength > 22 && titleLength <= 44) {
        $("#act-name").css({"font-size": "30px"});
    }
    else if (titleLength > 44 && titleLength <= 66) {
        $("#act-name").css({"font-size": "25px"});
    }
    else $("#act-name").css({"font-size": "20px"});
}

$(document).ready(function () {
    refreshQRcode();
    //setTimeout("switchContent()",6000);
    fixTitle();

    Offline.options = {
        reconnect: {
            // How many seconds should we wait before rechecking.
            initialDelay: 15
        }
    }
    Offline.on('confirmed-down',function() {
        alert("网络中断，请检查网络连接");
        $('#page #QRcode').html('');
    });

    Offline.on('confirmed-up', function(){
       alert("您已重新连上网络");
    });
});



