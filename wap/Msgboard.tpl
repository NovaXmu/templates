<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>{$title}</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="{$base}wap/css/jquery.fullPage.css">
    <!-- <link rel="stylesheet" type="text/css" href="{$base}wap/css/style.css"> -->
    <link rel="stylesheet" type="text/css" href="{$base}wap/css/animate.css">

    <style type="text/css">
        body {
            text-align: center;
        }

        .vertical {
            width:1.5em;
            margin-top: 20px;
        }

        .title {
            color: #EEEEEE;
            font-size: 32px;
            text-shadow:2px 2px 1px #000;
        }

        .content {
            color: #EEEEEE;
            font-size: 14px;
            background-color: rgba(10, 10, 10, 0.5);
            border-radius: 20px;
        }

        .hidden {
            visibility: hidden;
        }

        /*style for section 0*/
        #section0 {
            background-image: url({$base}wap/img/xmu1.png);
            background-repeat: no-repeat;
            background-size:100% 100%;
        }

        #logo {
            width: 130px;
            height: auto;
            border-radius: 50% 50% 50% 50%;
        }

        #section0-title {
            color: #f58220;
            font-size: 32px;
            font-weight: bolder;
            margin-left: 30%;
            font-family: "黑体";
        }

        #section0-subtitle {
            color: #EEEEEE;
            font-size: 24px;
            border-left: 2px solid;
            margin-left: 20px;
        }

        #section0-content {
            color: #FFFFFF;
            margin-top: 10px;
        } 

        /*style for section 1*/
        #section1 {
            background-image: url({$base}wap/img/xmu2.jpg);
            background-repeat: no-repeat;
            background-size:100% 100%;
        }

        #section1-title {
            border-right: 1px solid;
        }

        #section1-content {
            margin-left: 20px;
            font-size: 14px;
        }

        /*style for section 2*/
        #section2 {
            background-image: url({$base}wap/img/geng.jpg);
            /*background-repeat: no-repeat;*/
            background-size: 130% 100%;
        }

        #section2-title {
            color: #FFFFFF;
        }

        #section2-content {
            width: 90%;
            margin-left: 5%;
            border-radius: 20px;
        }

        hr {
            width: 80%;
            margin-top: 10px;
            margin-bottom: 10px;
        }

        /*style for section 3*/
        #section3 {
            background-image: url({$base}wap/img/geng2.jpg);
            background-size: 130% 100%;
        }
        
        #section3-content {
            margin-top: 65%;
            margin-left: 5%;
            width: 90%;
        }    

        /*style for section 4*/
        #section4 {
            background-image: url({$base}wap/img/luo.jpg);
            background-size: 120% 100%;
        }

        #section4-title {
            margin-top: -10%;
        }

        #section4-content {
            margin-top: 65%;
        }
        /*style for section 5*/
        #section5 {
            background-image: url({$base}wap/img/luo2.jpg);
            background-size: 120% 100%;
        }

        #section5-content {
            margin-top: 65%;
        } 

        /*style for section 6*/
        #section6 {
            background-image: url({$base}wap/img/sa.jpg);
            background-size: 125% 100%;
        }

        #section6-title {
            background-color: rgba(10, 10, 10, 0.5);
            border-radius: 20px;
            width: 90%;
            margin-left: 5%;
        }


        #section6-content {
            width: 90%;
            margin-left: 5%;
        }

        /*style for section 7*/
        #section7 {
            background-image: url({$base}wap/img/sa2.jpg);
            background-size: 120% 100%;
        }

        #section7-content {
            width: 90%;
            margin-left: 5%;
        }

        /*style for section 8*/
        #section8 {
            background-image: url({$base}wap/img/wang.jpg);
            background-size: 120% 100%;
        }

        #section8-title {
            background-color: rgba(10, 10, 10, 0.5);
            border-radius: 20px;
            width: 90%;
            margin-left: 5%;
        }

        #section8-content {
            width: 90%;
            margin-left: 5%;
        }

        /*style for section 9*/
        #section9 {
            background-image: url({$base}wap/img/wang2.jpg);
            background-size: 120% 100%;
        }

        #section9-content {
            width: 90%;
            margin-left: 5%;
        }

        /*style for section 10*/
        #section10 {
            background-image: url({$base}wap/img/chen.jpg);
            background-size: 120% 100%;
        }

        #section10-title {
            background-color: rgba(10, 10, 10, 0.5);
            border-radius: 20px;
            width: 90%;
            margin-left: 5%;
        }

        #section10-content {
            width: 90%;
            margin-left: 5%;
        }

        /*style for section 11*/
        #section11 {
            background-image: url({$base}wap/img/xmu3.jpg);
            background-repeat: no-repeat;
            background-size:140% 100%;
        }

        #section11-title {
            border-right: 1px solid;
        }

        #section11-content {
            margin-left: 20px;
        }

        /*style for section 12*/
        #section12 {
            background-image: url({$base}wap/img/xmu4.jpg);
            background-repeat: no-repeat;
            background-size:120% 100%;
        }

        /*style for section 13*/
        #section13 {
            background-image: url({$base}wap/img/feng.jpg);
            background-repeat: no-repeat;
            background-size:100% 100%;
        }

        .scroll {
            width: 90%;
            margin-left: 5%;
            max-height: 500px;
            background-color: rgba(10, 10, 10, 0.5);
            border-radius: 20px;
            margin-top: 20px;
        }

        form {
            position:absolute;  
            bottom: 10px;  
        }

        form input{
            width: 200px;
            height: 30px;
            margin-left: 20px;
        }

        form button{
            margin-left: 20px;
            width: 60px;
            height: 30px; 
        }

        div p {
            color: #DDDDDD;
            font-size: 18px;
        }

        .scroll {
            overflow:hidden;
            margin-top: -50px;
        }

        .list{
            max-height: 400px;
        }

        .scroll p {
            overflow:hidden;
        }
        
        #play {
            height: 50px;
            width: 50px;
        }

    </style>
    
    <script src="{$base}wap/js/jquery.min.js"></script>
    <script src="{$base}wap/js/css3-animate-it.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="{$base}wap/js/jquery.fullPage.min.js"></script>
    <script type="text/javascript">

        function autoScroll(obj){
            $(obj).find(".list").animate({
                marginTop : "0px"
            },500,function(){
                $(this).css({ marginTop : "0px" }).find("p:first").appendTo(this);
            })
        }

        var audioElement = document.createElement('audio');
        $(document).ready(function() {
            
            audioElement.setAttribute('src', 'http://wechatyiban.xmu.edu.cn/wap/music.mp3');
            //audioElement.load()

            $.get();

            audioElement.addEventListener("load", function() {
                audioElement.play();
            }, true);

            

            $('#fullpage').fullpage({
                navigation: true,
                navigationPosition: 'right',
                css3: true,

                'afterLoad': function(anchorLink, index){
                    if(index == 1){
                        $('#logo').removeClass('hidden').addClass('animated rotateIn');
                        $('#section0-title').removeClass('hidden').addClass('animated slideInUp');
                        $('#section0-subtitle').removeClass('hidden').addClass('animated slideInDown');
                        $('#section0-content').removeClass('hidden').addClass('animated slideInUp');
                    }
                    if(index == 2){
                        $('#section1-title').removeClass('hidden').addClass('animated slideInUp');
                        $('#section1-content').removeClass('hidden').addClass('animated slideInDown');
                    }
                    if(index == 3){
                        $('#section2-title').removeClass('hidden').addClass('animated bounceIn');
                        $('#section2-content').removeClass('hidden').addClass('animated fadeInLeft');
                    }
                    if(index == 4){
                        $('#section3-content').removeClass('hidden').addClass('animated fadeInLeft');
                    }
                    if(index == 5){
                        $('#section4-title').removeClass('hidden').addClass('animated rotateInUpRight');
                        $('#section4-content').removeClass('hidden').addClass('animated rotateInDownLeft');
                    }
                    if(index == 6){
                        $('#section5-content').removeClass('hidden').addClass('animated fadeInLeft');
                    }
                    if(index == 7){
                        $('#section6-title').removeClass('hidden').addClass('animated slideInDown');
                        $('#section6-content').removeClass('hidden').addClass('animated zoomInLeft');
                    }
                    if(index == 8){
                        $('#section7-content').removeClass('hidden').addClass('animated fadeInLeft');
                    }
                    if(index == 9){
                        $('#section8-title').removeClass('hidden').addClass('animated lightSpeedIn');
                        $('#section8-content').removeClass('hidden').addClass('animated slideInUp');
                    }
                    if(index == 10){
                        $('#section9-content').removeClass('hidden').addClass('animated slideInUp');
                    }
                    if(index == 11){
                        $('#section10-title').removeClass('hidden').addClass('animated rollIn');
                        $('#section10-content').removeClass('hidden').addClass('animated slideInUp');
                    }
                    if(index == 12){
                        $('#section11-title').removeClass('hidden').addClass('animated slideInUp');
                        $('#section11-content').removeClass('hidden').addClass('animated slideInDown');
                    }
                    if(index == 13){
                        $('#section12-content').removeClass('hidden').addClass('animated fadeInLeft');
                    }
                },

                'onLeave': function(index, nextIndex, direction){
                    if(index == 1){
                        audioElement.play();
                        $('#logo').removeClass('animated rotateIn').addClass('');
                        $('#section0-title').removeClass('animated slideInUp').addClass('hidden');
                        $('#section0-subtitle').removeClass('animated slideInDown').addClass('hidden');
                        $('#section0-content').removeClass('animated slideInUp').addClass('hidden');
                    }
                    if(index == 2){
                        $('#section1-title').removeClass('animated slideInUp').addClass('hidden');
                        $('#section1-content').removeClass('animated slideInDown').addClass('hidden');
                    }
                    if(index == 3){
                        $('#section2-title').removeClass('animated bounceIn').addClass('hidden');
                        $('#section2-content').removeClass('animated fadeInLeft').addClass('hidden');
                    }
                    if(index == 4){
                        $('#section3-content').removeClass('animated fadeInLeft').addClass('hidden');
                    }
                    if(index == 5){
                        $('#section4-title').removeClass('animated rotateInUpRight').addClass('hidden');
                        $('#section4-content').removeClass('animated rotateInDownLeft').addClass('hidden');
                    }
                    if(index == 6){
                        $('#section5-content').removeClass('animated fadeInLeft').addClass('hidden');
                    }
                    if(index == 7){
                        $('#section6-title').removeClass('animated slideInDown').addClass('hidden');
                        $('#section6-content').removeClass('animated zoomInLeft').addClass('hidden');
                    }
                    if(index == 8){
                        $('#section7-content').removeClass('animated fadeInLeft').addClass('hidden');
                    }
                    if(index == 9){
                        $('#section8-title').removeClass('animated lightSpeedIn').addClass('hidden');
                        $('#section8-content').removeClass('animated slideInUp').addClass('hidden');
                    }
                    if(index == 10){
                        $('#section9-content').removeClass('animated slideInUp').addClass('hidden');
                    }
                    if(index == 11){
                        $('#section10-title').removeClass('animated rollIn').addClass('hidden');
                        $('#section10-content').removeClass('animated slideInUp').addClass('hidden');
                    }
                    if(index == 12){
                        $('#section11-title').removeClass('animated slideInUp').addClass('hidden');
                        $('#section11-content').removeClass('animated slideInDown').addClass('hidden');
                    }
                    if(index == 13){
                        $('#section12-content').removeClass('animated fadeInLeft').addClass('hidden');
                    }
                }
            });
            
            setInterval('autoScroll(".scroll")', 1000)
                $.get('/wap/api/msgboard',
                    {
                        m: 'get',
                        act: '0fc4e2591f81c3aacdae3b32c997d3b7'
                    }, function(data){
                        data = jQuery.parseJSON(data);
                        if (data.errno) {
                            alert(data.errmsg);
                            return;
                        };
                        data = data.data;
                        for (var i = data.length - 1; i >= 0; i--) {
                            $('.list').append('<p class="msg-item">'+data[i]+'</p>');
                        };
                });

                $('#submitMsg').on('click', function(){
                    var msg = $('#msg').val();
                    if (msg.length <= 0) {
                        alert('请输入留言内容');
                        return;
                    };
                    $.get('/wap/api/msgboard',
                        {
                            m: 'add',
                            content: msg,
                            act: '0fc4e2591f81c3aacdae3b32c997d3b7'
                        }, function(data){
                            data = jQuery.parseJSON(data);
                            if (data.errno) {
                                alert(data.errmsg);
                                return;
                            };
                            alert('提交成功');
                            $('.list').append('<p class="msg-item">'+msg+'</p>');
                            $('#msg').val('');
                    });
                })
        });
    </script>
</head>
<body>
<div id="fullpage">
    <div class="section" id="section0">
        <img class="animated rotateIn" id="logo" src="{$base}wap/img/logo.jpg">
        
        <div class="row">
            <p class="vertical col-xs-4 animated slideInUp" id="section0-title">厦门大学</p>
            <p class="vertical col-xs-4 animated slideInDown" id="section0-subtitle">94周年校庆</p>
        </div>
        <p class="animated slideInUp" id="section0-content">厦门大学党委宣传部新媒体中心<br>厦门大学i厦大•易班发展中心<br>厦门大学Nova工作室<br>出品<br>配乐：曲奇人声 原创音乐社 厦大电台</p>
    </div>

    <div class="section" id="section1">
        <div class="row">
            <p class="title vertical col-xs-2 col-xs-offset-1 hidden" id="section1-title">厦门大学</p>
            <p class="content col-xs-8 hidden" id="section1-content">从1921走到2015，<br>开基立业，与党同龄；<br>国难当头，勇于担当；<br>抗战内迁，艰苦办学；<br>改革开放，重振雄风。<br>多少仁人志士前仆后继，炼就了今日的厦大？<br>多少学者能人开荒拓路，铸造了今昔的辉煌？<br> 学子情怀，以学问见识为根基，<br>师者担当，以百年树人为能事!<br>爱国、革命、自强、科学，<br>四种精神，砥砺前行<br>风雨94载，激流勇进<br>群贤毕至，成就“南方之强”</p>
        </div>
    </div>

    <div class="section" id="section2">
        <p class="title hidden" id="section2-title">陈嘉庚<br>（1874-1961）</p>
        <hr>
        <p class="content hidden" id="section2-content">他白手起家，一诺万金；<br>他秉持“教育救国”、“教育强国”之念，<br>他倾资兴办教育，先后创办<br>集美学村、厦门大学；<br>他遭遇经济危机，<br>“宁可变卖大厦，也要支持厦大”<br><br>他反对卖国；“敌未出国土前，言和即汉奸”提案振聋发聩；<br>他支援抗战；成立“南洋华侨筹赈祖国难民总会”带头捐款购债献物<br></p>
    </div>

    <div class="section" id="section3">
        <p class="content hidden" id="section3-content">他抗日筹赈，开辟滇缅公路，抢运战略物资。<br>他尽国民天职，报效祖国；<br>他逝世前夕，念念不忘祖国统一。<br><br>“华侨旗帜，民族光辉”<br><br>铭记陈嘉庚先生的爱国精神，致敬我们永远的校主！</p>
    </div>

    <div class="section" id="section4">
        <p class="content col-xs-10 hidden" id="section4-content">出身贫寒的他，<br>考入厦大后挑起学生会的大梁，<br>五卅惨案后，<br>领导厦门工人罢工游行，<br>大革命时期，加入中国共产党，<br>在厦大成立福建第一个党支部。<br>他带领的工人运动风生水起，<br>“罢山罢海”，声援北伐，<br>成为厦门革命时期的中间力量。</p>
        <p class="vertical title col-xs-2 hidden" id="section4-title">罗扬才</p>
    </div>

    <div class="section" id="section5">
        <p class="content col-xs-10 hidden" id="section5-content">1927年不幸被俘，<br>众人请愿援救失败，<br>他高唱《国际歌》走上刑场，<br>从容就义。<br>那一年，他22岁。<br>而后，厦大革命运动风起云涌，<br>“东南民主堡垒”茁壮成长。<br><br>铭记罗扬才烈士的革命精神，致敬我们永远的学长！</p>
    </div>

    <div class="section" id="section6">
        <p class="title hidden" id="section6-title">萨本栋<br>（1902-1949）</p>
        <p class="content hidden" id="section6-content">名家之后，年少有成。<br>学术大家，载誉归来。<br><br>为发扬嘉庚先生毁家兴学精神<br>毅然就任国立厦门大学第一任校长。<br>就任翌日，七七事变爆发，<br>他周密筹划，内迁长汀，<br>在战火的后方全面复课，<br>他亲自擘划，建校舍、修防空洞；<br>他改装发动机，为全校送去光明。</p>
    </div>

    <div class="section" id="section7">
        <p class="content hidden" id="section7-content">他不辞辛苦力肩教学重担，<br>因陋就简增设土木、机电、航空三系。<br>他悉心治校，严于律己，<br>勤政之余，继以力学；<br>他忠于事业，言传身教，<br>患病期间，不忘教学；<br>他呕心沥血，廉洁奉公，<br>食少事繁，积劳成疾。<br>因了他的苦心经营，<br>“加尔各答以东最完善的大学”迅速崛起。 <br><br>铭记抗战期间内迁闽西艰苦办学的自强精神，致敬我们永远的校长——萨本栋！</p>
    </div>

    <div class="section" id="section8">
        <p class="title hidden" id="section8-title">王亚南<br>（1901-1969）</p>
        <p class="content hidden" id="section8-content">早年英武，投笔从戎。<br>为寻变革社会的救国之道，<br>刻苦钻研马克思主义政治经济学，<br>开启与友首译《资本论》的序章。<br><br>“九一八事变”后，留学日本的他愤然回国，<br>以翻译和教书为业，在学术界崭露头角；</p>
    </div>

    <div class="section" id="section9">
        <p class="content hidden" id="section9-content">十年心血，重重困难，<br>在“文化围剿”的白色恐怖下，<br>无所畏惧，勇往直前，<br>开拓中国马克思主义经济学史，<br>首倡“中国经济学”。<br><br>解放后，他奉命执掌厦大，<br>他锐意改革，率先倡议成立经济学院。<br>他以民卞战士的姿态站在教育战线的最前列，<br>倡导学术自由、研究自由，<br>敢于坚持真理，勇于修正错误。<br>他说：“从反对者获取自由，<br>予反对者以自由。”</p>
    </div>
        
    <div class="section" id="section10">
        <p class="title hidden" id="section10-title">陈景润<br>（1901-1969）</p>
        <p class="content hidden" id="section10-content">&nbsp;少年景润，勤奋刻苦。毕业后，因口齿不清被勒令“停职回乡养病”。<br>摆摊卖书，偶遇王亚南校长，<br>举荐回校，醉心钻研。<br>他用最原始的计算手段，<br>以超人的毅力，克服世界难题，<br>摘取了“哥德巴赫猜想”<br>这一数学皇冠上的明珠。<br>“1+2”奠定了“陈氏定理”的根基。<br>为科研一生简朴，<br>最后捐献遗体，为科学献身。<br>铭记王亚南校长、陈景润教授为代表的科学精神，致敬我们永远的师长！</p>
    </div>

    <div class="section" id="section11">
        <div class="row">
            <p class="title col-xs-2 col-xs-offset-1 hidden" id="section11-title">94周年</p>
            <p class="content col-xs-8 hidden" id="section11-content">在厦大灿若星河的历史长河中，<br>能仁志士数不胜数，<br>鲁迅、林语堂、谢希德、卢嘉锡、林惠祥……<br>他们谱写成了一段段恢弘的乐曲，<br>而爱国、革命、自强、科学这四种精神，<br>一脉相承，贯穿始终，<br>成为厦大乐曲中最有力的叩响。</p>
        </div>
    </div>

    <div class="section" id="section12">
        <div class="row">
            <p class="content col-xs-8 hidden" id="section12-content">时值厦大94周年校庆，<br>让我们一起献礼厦大诞辰，<br>让我们一起致敬，<br>这些“自强不息、止于至善”的，<br>永远的厦大人。</p>
        </div>
    </div> 

    <div class="section" id="section13">
        <div class="scroll"><div class="list"></div></div>
        <form>
            <input type="text" id="msg" placeholder="想要说的话">
            <button type="button" class="btn btn-primary" id="submitMsg">留言</button>
        </form>
    </div>
</div>
</body>
</html>