<!DOCTYPE html>
<html lang=zh>
<head>
    <meta charset="utf-8">
    <title>游戏列表</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="{$base}mall/css/public.css">
    <link rel="stylesheet" href="{$base}mall/css/gamelist.css?v=1.01">
    {include file="mall/styleTag.tpl"}
</head>
<body class="game">

<div class="row">
    <div class="col-sm-8 col-sm-offset-2 centered" id="main">
        {include file="mall/Header.tpl"}
        <div id="content">
            <div class="bg">
                <div class="row" style="width:100%;margin-left:0;margin-right:0;">
                    <div class="col-xs-6" align="center">
                        {* 左边图标 *}
                        <a href="/mall/earn?m=bobing"><img src="{$base}mall/img/bobing-logo.png" alt="博饼图标" width="80%"></a>
                    </div>
                    <div class="col-xs-6">
                        {* 右边文字 *}
                        <h3 class="gamename">博饼赚网薪</h3>
                        <a href="" class="show-rules">
                            积分规则&gt;&gt;
                        </a>
                        <br>
                        <a href="http://mp.weixin.qq.com/s?__biz=MjM5OTQ3MzgzMw==&mid=200888426&idx=4&sn=40431990b25f3509ad996bff09b68f60#rd">
                            博饼民俗简介&gt;&gt;
                        </a>
                        <br>
                        <a href="" class="show-chart">
                            今日排行榜&gt;&gt;
                        </a>
                        <br>
                        <!-- <a href="" class="show-other-accesses">
                            其他赚网薪方式&gt;&gt;
                        </a>
                        <br> -->
                        <a href="" class="show-extra">
                            领取额外博饼机会&gt;&gt;
                        </a>

                    </div>
                    <div class="more">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="rules" style="display:none;"><img src="{$base}mall/img/bobing-rules.png"
                                                                              alt="博饼积分规则表"></div>
                                <div class="chart bobing" style="display:none">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>易班昵称</th>
                                            <th>网薪</th>
                                            <th>等级</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                                <div class="other-accesses" style="display:none;">

                                    <ol style="line-height:1;">
                                        <li>
                                            <h4>1.手机版：</h4>

                                            <p>“点赞、同情、回复”各+2，一天3次；</p>

                                            <p>“发动态” +2，一天1次；</p>

                                            <p>“发轻博客”+10，一天1次；</p>

                                            <p>“取消同情、赞”-1；</p>

                                            <p>“删除动态”-2；</p>

                                            <p>“删除博客”-5。</p>
                                        </li>
                                        <li>
                                            <h4>2.网页版：</h4>

                                            <p>“上传资料至资料库”+2，一天5次；</p>

                                            <p>“发布话题”+5，一天2次；</p>

                                            <p>“发布投票”+5，一天2次；</p>

                                            <p>“删除资料”-2。</p>
                                        </li>
                                        <li>
                                            <h4>3.转赠网薪：</h4>

                                            <p>
                                                登陆网页版易班www.yiban.cn，点击右上角的小人--跳转到个人页面--送网薪--输入对方手机号赠送，或直接点击对方主页，选择送TA网薪，网薪转赠最少500，系统扣除百分之十手续费。</p>
                                        </li>
                                        <li><h4>4.参加易班的其他线上线下活动。</h4></li>
                                    </ol>
                                </div>

                                <div class="extra" style="display:none;">
                                    <p>
                                        1. 使用厦大邮箱奖励博饼机会！
                                        <button class="email">点我</button>
                                    </p>
                                    <p>
                                        2. 易班网活跃用户/集体奖励博饼机会！
                                    </p>
                                    <div class="tabs">
                                        <li class="active">班级EGPA榜</li><li>个人榜</li>
                                    </div>
                                    <ul class="list egpa-list">
                                        
                                    </ul>
                                    <ul class="list person-list" style="display:none;">
                                       
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg">
                <div class="row" style="width:100%;margin-left:0;margin-right:0;">
                    <div class="col-xs-6" align="center">
                        {* 左边图标 *}
                        <a href="/mall/earn?m=game2048"><img src="{$base}mall/img/95.png" alt="2048图标"
                                                             width="80%"></a>
                    </div>
                    <div class="col-xs-6">
                        {* 右边文字 *}
                        <h3 class="gamename">2048</h3>
                        <a href="" class="show-rules">
                            积分规则&gt;&gt;
                        </a>
                        <br>
                        <a href="" class="show-chart">
                            排行榜&gt;&gt;
                        </a>
                        <br>
                        <a href="" class="show-other-accesses">
                            其他赚网薪方式&gt;&gt;
                        </a>
                    </div>

                    <div class="more">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="rules" style="display:none;">
                                    <h3>积分规则</h3>
                                    <h4>&nbsp;&nbsp;&nbsp;&nbsp;以当日最高分多少为获取网薪标准，分数越多获取网薪越多。</h4>
                                    <h4>&nbsp;&nbsp;&nbsp;&nbsp;少年郎，加油吧~~~</h4>

                                    <div style="width:100%;text-align:center;">
                                        <img style="width:80%;" src="{$base}mall/img/rules-2048.png" alt="2048积分规则表">
                                    </div>

                                </div>
                                <div class="chart game2048" style="display:none">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>易班昵称</th>
                                            <th>得分</th>
                                            <th>获得网薪</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>

                                <div class="other-accesses" style="display:none;">

                                    <ol style="line-height:1;">
                                        <li>
                                            <h4>1.手机版：</h4>

                                            <p>“点赞、同情、回复”各+2，一天3次；</p>

                                            <p>“发动态” +2，一天1次；</p>

                                            <p>“发轻博客”+10，一天1次；</p>

                                            <p>“取消同情、赞”-1；</p>

                                            <p>“删除动态”-2；</p>

                                            <p>“删除博客”-5。</p>
                                        </li>
                                        <li>
                                            <h4>2.网页版：</h4>

                                            <p>“上传资料至资料库”+2，一天5次；</p>

                                            <p>“发布话题”+5，一天2次；</p>

                                            <p>“发布投票”+5，一天2次；</p>

                                            <p>“删除资料”-2。</p>
                                        </li>
                                        <li>
                                            <h4>3.转赠网薪：</h4>
        
                                            <p>
                                                登陆网页版易班www.yiban.cn，点击右上角的小人--跳转到个人页面--送网薪--输入对方手机号赠送，或直接点击对方主页，选择送TA网薪，网薪转赠最少500，系统扣除百分之十手续费。</p>
                                        </li>
                                        <li><h4>4.参加易班的其他线上线下活动。</h4></li>
                                    </ol>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {include file="mall/Footer.tpl"}
    </div>
</div>

{include file="mall/scriptTag.tpl"}
</body>
<script>
    $(".show-rules").click(function () {
        $(this).parents(".bg").find(".rules").fadeToggle("fast").siblings(":visible").fadeOut();
        return false;
    });

    $(".show-chart").click(function (event) {
        $(this).parents(".bg").find(".chart").fadeToggle("fast").siblings(":visible").fadeOut();
        return false;
    });

    $(".show-other-accesses").click(function () {
        $(this).parents(".bg").find(".other-accesses").fadeToggle("fast").siblings(":visible").fadeOut();
        return false;
    });

    $(".show-extra").click(function (event) {
        $(this).parents(".bg").find(".extra").fadeToggle("fast").siblings(":visible").fadeOut();
        return false;
    });

    $(".extra").find(".tabs").find("li").click(function (event) {
        $(this).siblings("li").removeClass("active");
        if (!$(this).hasClass("active")) {
            $(this).addClass("active");
        }

        if ($(this).is(":first-child")) {
            $(".extra").find("ul.egpa-list").show().end().find("ul.person-list").hide();
        } else {
            $(".extra").find("ul.person-list").show().end().find("ul.egpa-list").hide();
        }
    })

    $(".extra button.email").click(function (event) {
        $.get(
            '/mall/api/xmuMail?m=getCode',
            function (resp) {
                var data = $.parseJSON(resp);
                if (data.errno == 0) {
                    alert("一封邮件已发送至您的厦大邮箱：" + data.data + ", 请按邮件内指示领取奖励");
                } else {
                    alert(data.errmsg);
                }
            }
        )
    })

    $(document).ready(function () {
        

        //活跃度排行榜
        $.get(
            '/mall/api/yibanRank?m=medal',
            function(resp) {
                var data = $.parseJSON(resp);

                if (data.errno == 0) {
                    var list = data.data;
                    for ( var i = 0; i < list.length; i++ ) {
                        $(".extra").find(".egpa-list").append('<li data-id="' + list[i]["group_id"] + '">\
                                            <span class="avatar">\
                                                <img src="' + list[i]["img"] + '" alt="">\
                                            </span>\
                                            <div class="info">\
                                                <h3 class="clz">' + list[i]["name"] + '</h3>\
                                                <span>学校：<span class="schl">' + list[i]["school"] + '</span></span>\
                                                <br>\
                                                <span>EGPA: <span class="egpa">' + list[i]["egpa"] + '</span></span>\
                                            </div>\
                                            <div class="btn">\
                                                <div class="wrapper">\
                                                    <button ' + ( list[i]["award"]==1 ? "" : "disabled" ) + '>' + ( list[i]["award"]==0 ? "已" : "" ) + '领取</button>\
                                                </div>\
                                            </div>\
                                        </li>')
                    }
                } else {
                    alert(data.errmsg)
                }
            }
        )

        $.get(
            '/mall/api/yibanRank',
            function(resp) {
                var data = $.parseJSON(resp);

                if (data.errno == 0) {
                    var list = data.data;
                    for ( var i = 0; i < list.length; i++ ) {
                        $(".extra").find(".person-list").append('<li data-id="' + list[i]["yb_userid"] + '">\
                                            <span class="avatar">\
                                                <img src="'+ list[i]["img"] +'" alt="">\
                                            </span>\
                                            <div class="info">\
                                                <h3 class="name">'+ list[i]["name"] +'</h3>\
                                                <br>\
                                                <span>日活跃度: '+ list[i]["active"] +'</span>\
                                            </div>\
                                            <div class="btn">\
                                                <div class="wrapper">\
                                                    <button ' + ( list[i]["award"]==1 ? "" : "disabled" ) + '>' + ( list[i]["award"]==0 ? "已" : "" ) + '领取</button>\
                                                </div>\
                                            </div>\
                                        </li>')
                    }
                } else {
                    alert(data.errmsg)
                }
            }
        )

        //领取
        $(document).on("click", ".egpa-list li button", function (event) {
            var id = $(this).parents("li").data("id");
            $.get(
                '/mall/api/bobing?m=medal&groupId=' + id,
                function (resp) {
                    var data = $.parseJSON(resp);
                    if (data.errno == 0) {
                        alert("领取成功！");
                    } else alert(data.errmsg);
                }
            )
        })

        $(document).on("click", ".person-list li button", function (event) {
            //var id = $(this).parents("li").data("id");
            $.get(
                '/mall/api/bobing?m=star',
                function (resp) {
                    var data = $.parseJSON(resp);
                    if (data.errno == 0) {
                        alert("领取成功！");
                    } else alert(data.errmsg);
                }
            )
        })

        //博饼，今日排行榜
        $.get(
                '/mall/api/bobing?m=rank',
                function (data) {
                    var data = $.parseJSON(data);

                    for (var i = 0; i < data.data.length; i++) {
                        var userid = data.data[i].yb_uid;
                        var award = data.data[i].award;
                        var bobingLevel = data.data[i].bobingLeval;
                        $(".bobing").find("table").find('tbody').append('<tr>\
												<th scope="row">' + (i + 1) + '</th>\
												<td>' + userid + '</td>\
												<td>' + award + '</td>\
												<td>' + bobingLevel + '</td>\
											</tr>');
                    }

                }
        );

        //2048，今日排行榜
        $.get(
                '/mall/api/game2048?m=rank',//此处该成game2048
                function (data) {
                    var data = $.parseJSON(data);
                    // var data = JSON.stringify(data);//很有用的json串行化函数，可以直接输出全部json数据
                    for (var i = 0; i < data.data.length; i++) {
                        var userid = data.data[i].yb_usernick;
                        var score = data.data[i].randNum;
                        var award = data.data[i].award;
                        //var bobingLevel = data.data[i].bobingLeval;
                        $(".game2048").find("table").find('tbody').append('<tr>\
												<th scope="row">' + (i + 1) + '</th>\
												<td>' + userid + '</td>\
												<td>' + score + '</td>\
												<td>' + award + '</td>\
											</tr>');
                    }

                }
        );

    });
</script>
</html>