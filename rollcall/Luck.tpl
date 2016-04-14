<html>
<head>
    <meta charset="UTF-8" />
    <title>网络文化节 | 现场抽奖</title>

    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">

    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <style type="text/css">
        body {
            color: #333;
            background-image: url("{$base}rollcall/temp/img/background.png");
            background-size: 100% 100%;
        }

        .page {
            width: 1000px;
            margin: 30px auto 0;
        }

        h1 {
            font-size: 43px;
            margin-left: 44%;
            color: #EEEEEE;
            text-shadow: rgb(0, 0, 0), 0.1;
            font-family: "微软雅黑", "黑体";
        }

        .displays {
            border: 10px solid #ccc;
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 30px;
            box-shadow: 0 0 12px 4px #000 inset;
            width: 720px;
            padding-bottom: 10px;
            margin-left: 25%;
            margin-top: 70px;
        }

        .flapper {
            margin-bottom: 2px;
            text-align: center;
        }

        .inputarea {
            margin: 24px 0;
        }

        div.inline {
            display: inline-block;
            vertical-align: bottom;
        }

        div.activity {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background-color: #15FA80;
            position: relative;
            top: 36px;
            left: 8px;
        }

        div.activity.active {
            background-color: #f00;
        }

        #showme {
            margin-left: 60%;
            margin-top: 20px;
        }

        table {
            background-color: rgba(0, 51, 51, 0.8);
            border-radius: 20px;
            width: 600px;
            height: 300px;
            overflow-y: scroll;
            text-align: center;
        }

        th {
            color: #EEEEEE;
            text-align: center;
        }
        td {
            color: #BBBBBB;
        }
        div.numScreen{
            height: 114px;
            width: 660px;
            color: white;
            margin-right: 40px;
            font-size: 80px;
        }
    </style>
</head>
<body>
    <div class="page">
        <h1>厦门大学首届校园网络文化节</h1>
        <div class="displays">
            <div class="activity"></div>
            <div class="numScreen text-right"></div>
        </div>
        <div class="pull-right" style="margin-top: 20px;">
            <button id="tryLuck" type="button" class="btn btn-lg btn-success" data-trying-text="停止" style="width: 250px;margin-right: 100px;">开始</button>
        </div>
        <h2 style="margin-top: 30%;color: white;">全场技术支持   Nova工作室</h2>
    </div>
<textarea class="hidden">{$list}</textarea>
<script type="text/javascript">
var g_Interval = 1;
var g_Timer;
var running = false;
var luckList = [];

var lines = $('textarea.hidden').val().split('\n');
var nums = lines.map(function(each){
    return each.split('|')[1];
})

$('button#tryLuck').on('click', function(){
    $('div.activity').toggleClass('active');
    if(running){
        //stop
        running = false;
        $('button#tryLuck').button('reset');
        clearTimeout(g_Timer);
    }
    else{
        //run
        running = true;
        $('button#tryLuck').button('trying');
        beginTimer();
    }
});

$(document).keypress(function(e){
    if (e.which == 32) {
        $('button#tryLuck').click();
    };
})

function updateRndNum(){
    var rand = Math.floor(Math.random()*lines.length);
    $('div.numScreen').html(nums[rand]);
}

function beginTimer(){
    g_Timer = setTimeout(beat, g_Interval);
}

function beat() {
    g_Timer = setTimeout(beat, g_Interval);
    updateRndNum();
}

</script>
</body>
</html>

