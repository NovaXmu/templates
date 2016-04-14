<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>厦大易班公共平台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <!-- Loading Bootstrap -->
    <link href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Loading Flat UI -->
    <link href="{$base}cms/css/flat-ui.min.css" rel="stylesheet">
    <!-- Loading simditor CSS -->
    <link href="{$base}cms/css/simditor/font-awesome.css" rel="stylesheet">
    <link href="{$base}cms/css/simditor/simditor.css" rel="stylesheet">

    <!-- Loading Index CSS -->
    <link href="{$base}cms/css/index.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.6.2/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
<div class="container">
    <div class="header">
        <h1>厦大易班</h1>
        <h6 style="color: white;">抱歉，若页面无法正常显示和使用，请改用<a href="https://www.google.com/chrome/browser/desktop/index.html" title="Chrome大法好!">Chrome</a>浏览器。</h6>
        <button data-toggle="modal" data-target="#Login" style="float:right; " class="btn btn-info">Nova 运营中心>></button>
    </div>

    <div id="showcase">
        <ul>
            <li class="item">
                <div class="pic">
                    <img src="{$base}cms/img/ticket_cover.png" alt="抢票">
                </div>
                <div class="textbox">
                    <img src="{$base}cms/img/bubble_angle.png" class="bubble-angle" alt="">

                    <div class="content">
                        <h2>抢票平台</h2>

                        <p>在厦大易班发起抢票，将您的活动信息推送至万余名厦大师生。通过配置您的抢票规则，最大限度的增强您的影响力。</p>

                        <div class="row" style="margin-top: 20px">
                            <button type="button" class="btn btn-inverse index-btn" data-toggle="modal"
                                    data-target="#Ticket" data-backdrop="static" data-keyboard="false" id="launchBtn">
                                发起抢票
                            </button>
                            <button type="button" class="btn btn-inverse index-btn" data-toggle="modal"
                                    data-target="#ticket-manager" data-backdrop="static" data-keyboard="false"
                                    style="margin-left: 20px">
                                活动管理
                            </button>
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="pic">
                    <img src="{$base}cms/img/rollcall_cover.png" alt="">
                </div>
                <div class="textbox">
                    <img src="{$base}cms/img/bubble_angle.png" class="bubble-angle" alt="">

                    <div class="content">
                        <h2>扫码签到</h2>

                        <p>通过厦大易班扫码签到平台对您的活动、会议进行方便有效的出席检查。</p>

                        <div class="row" style="margin-top: 20px">
                            <button type="button" class="btn btn-inverse index-btn" data-toggle="modal"
                                    data-target="#rollcall" data-backdrop="static" data-keyboard="false" id="applyBtn">
                                活动申请
                            </button>
                            <button type="button" class="btn btn-inverse index-btn" data-toggle="modal"
                                    data-target="#rollcall-manager" data-backdrop="static" data-keyboard="false"
                                    style="margin-left: 20px">
                                活动管理
                            </button>
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="pic">
                    <img src="{$base}cms/img/exchange_cover.png" alt="">
                </div>
                <div class="textbox">
                    <img src="{$base}cms/img/bubble_angle.png" class="bubble-angle" alt="">

                    <div class="content">
                        <h2>网薪换实物</h2>

                        <p></p>
                        <div class="row" style="margin-top: 20px">
                            <button type="button" class="btn btn-inverse index-btn" data-toggle="modal" data-target="#exchangeModal" id="exchange">兑换商品</button>
                        </div>
                    </div>
                </div>
            </li>
            {* <li class="item">
                <div class="pic">
                    <img src="{$base}cms/img/exchange_cover.png" alt="">
                </div>
                <div class="textbox">
                    <img src="{$base}cms/img/bubble_angle.png" class="bubble-angle" alt="">

                    <div class="content">
                        <h2>大熊推荐</h2>

                        <p></p>
                    </div>
                </div>
            </li> *}
        </ul>
    </div>

    <div class="row text-center">
        <div class="col-lg-4 app">
            <img src="{$base}cms/img/ticket_cover.png" width="100%" alt="抢票平台" class="img-rounded">
        </div>
        <div class="col-lg-4 app">
            <img src="{$base}cms/img/rollcall_cover.png" width="100%" alt="签到平台" class="img-rounded">
        </div>
        <div class="col-lg-4 app">
            <img src="{$base}cms/img/exchange_cover.png" width="100%" alt="帐号绑定" class="img-rounded">
        </div>
    </div>
    <div id="footer" class="text-center">
        <hr>
        <div class="wrapper">
            <div class="credits">
                <p>Designed and built with all the love in the world by the Nova Studio.</p>

                <div class="crew"></div>
            </div>
            <div class="copyrights">
                <p>©<a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">Nova Studio</a>&nbsp;2015.All rights
                    reserved.</p>
            </div>
        </div>
    </div>
</div>

{* ====登录框========================================================================================= *}

<div class="modal fade" id="Login" tabindex="-1" role="dialog" aria-labelledby="LoginLabel" aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title" id="LoginLabel">后台登录</h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" id="loginForm">
                    <div class="form-group">
                        <label class="sr-only" for="username">用户名</label>
                        <input type="text" class="form-control" id="username" placeholder="用户名">
                    </div>
                    <div class="form-group">
                        <label class="sr-only" for="password">密码</label>
                        <input type="password" class="form-control" id="password" placeholder="密码">
                    </div>
                    <button type="button" id="loginButton" data-loading-text="Loading..." data-success-text="登录成功"
                            class="btn btn-primary index-btn" style="float: right;">
                        登录
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

{* ====抢票活动发起框====================================================================================== *}

<div class="modal fade" id="Ticket" tabindex="-1" role="dialog" aria-labelledby="TicketLabel" aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title" id="TicketLabel">抢票活动申请单</h4>
            </div>
            <div class="modal-body">

                <form id="ticketForm" class="form-horizontal" role="form">

                    {*<!-- 名称与联系方式 -->*}
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">活动名称</label>

                        <div class="col-sm-10">
                            <input maxlength="20" type="text" class="form-control" id="name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="telephone" class="col-sm-2 control-label">联系电话</label>

                        <div class="col-sm-4">
                            <input maxlength="11" type="text" class="form-control" id="telephone">
                        </div>
                    </div>
                    {*<!-- 活动详情 -->*}
                    <div class="form-group">
                        <label for="content" class="col-sm-2 control-label">活动详情</label>
                        <textarea class="content"></textarea>
                    </div>
                    {*<!-- 抢票方式 -->*}
                    <div class="form-group">
                        <div class="col-sm-2 col-sm-offset-3">
                            <div class="btn-group" id="ticketStyle">
                                <button type="button" id="chance" class="btn btn-primary dropdown-toggle"
                                        data-toggle="dropdown" data-chance="0">
                                    抢票方式<span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <a id="rule1">先到先得</a>
                                    </li>
                                    <li>
                                        <a id="rule2">随机抢票</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div id="chanceContainer" style="display: none;">
                            <label for="chance" class="col-sm-2 control-label">概率</label>

                            <div class="input-group col-sm-2">
                                <input type="number" class="form-control" min="1" max="99">
                                <div class="input-group-addon">%</div>
                            </div>
                        </div>
                    </div>
                    {*<!-- 票数与次数 -->*}
                    <div class="form-group">
                        <label for="total" class="col-sm-2 control-label">总票数</label>

                        <div class="col-sm-4">
                            <input type="number" class="form-control" id="total">
                        </div>
                        <div id="timesContainer" style="display: none;">
                            <label for="times" class="col-sm-3 control-label">每人可抢次数</label>

                            <div class="col-sm-3">
                                <input type="number" class="form-control" id="times">
                            </div>
                        </div>
                    </div>
                    {*<!-- 起止时间 -->*}
                    <div class="form-group">
                        <label for="startTime" class="col-sm-2 control-label">开始时间</label>

                        <div class="col-sm-10">
                            <input type="datetime-local" class="form-control" id="startTime">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">结束时间</label>

                        <div class="col-sm-10">
                            <input type="datetime-local" class="form-control" id="endTime">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
                <button id="ticketSubmit" type="button" class="btn btn-info">提交申请</button>
            </div>
        </div>
    </div>
</div>

{* ====抢票活动管理框========================================================================================= *}

<div class="modal fade" id="ticket-manager" tabindex="-1" role="dialog" aria-labelledby="ManagerLabel" aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button id="CloseForManager" type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title" id="ManagerLabel">活动管理</h4>
            </div>
            <div class="modal-body">
                <div id="ActSearch">
                    <form class="form-inline">
                        <div class="form-group">
                            <label for="telephone" class="control-label">联系电话</label>
                            <input maxlength="11" type="text" class="form-control" id="tele">
                        </div>
                        <button type="button" id="ManagerLoadBtn" class="btn btn-primary index-btn" style="float: right;"
                                autocomplete="off">
                            点击查看
                        </button>
                    </form>
                </div>
                <div id="Exchange" style="display: none;">
                    <form class="form-inline">
                        <div class="form-group">
                            <label for="voucher" class="control-label">票据凭证</label>
                            <input maxlength="12" type="text" class="form-control" id="voucher">
                        </div>
                        <button type="button" id="ExchangeBtn" class="btn btn-primary index-btn" style="float: right;"
                                autocomplete="off">
                            点击兑换
                        </button>
                        <select class="form-control" id="actID" style="width: 160px">
                        </select>
                    </form>
                    <p class="text-center" id="ExchangeInfo" style="margin-top: 10px">
                    <span id="infoText"></span>
                    <button id="AssignSeatBtn" type="button" class="btn btn-xs btn-info" style="display:none" onclick="assignSeat(this)">选择座位</button>
                    </p>
                </div>
                <hr>
                <div class="content" style="display: none;">
                </div>
            </div>
        </div>
    </div>
</div>

{* ====扫码签到活动申请框==================================================================================== *}
<div class="modal fade" id="rollcall" tabindex="-1" role="dialog" aria-labelledby="RollcallLabel" aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title" id="RollcallLabel">扫码签到 活动申请单</h4>
            </div>
            <div class="modal-body">

                <form id="RollcallForm" class="form-horizontal" role="form" data-actid="">

                    {*<!-- 名称与学号 -->*}
                    <div class="form-group">
                        <label for="name2" class="col-sm-2 control-label">活动名称</label>

                        <div class="col-sm-10">
                            <input maxlength="20" type="text" class="form-control" id="name2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="student-id" class="col-sm-2 control-label">学(工)号</label>

                        <div class="col-sm-6">
                            <input maxlength="" type="text" class="form-control" id="student-id">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="award" class="col-sm-2 control-label">申请网薪</label>

                        <div class="col-sm-6">
                            <input maxlength="" type="text" class="form-control" id="award">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="grade" class="col-sm-2 control-label">年级限制</label>

                        <div class="col-sm-3">
                            <select class="form-control" id="grade-limit-type">
                                <option value=""></option>
                                <option value="<">小于</option>
                                <option value=">">大于</option>
                                <option value="=">等于</option>
                                <option value="!=">不等于</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <select class="form-control" id="grade-limit-val">
                                <option value=""></option>
                                <option value="2011">2011</option>
                                <option value="2012">2012</option>
                                <option value="2013">2013</option>
                                <option value="2014">2014</option>
                                <option value="2015">2015</option>
                            </select>
                        </div>
                    </div>
                    {*<!-- 活动详情 -->*}
                    <div class="form-group">
                        <label for="content" class="col-sm-2 control-label">活动详情</label>
                        <textarea id="act-content"></textarea>
                    </div>
                    {*<!-- 起止时间 -->*}
                    <div class="form-group">
                        <label for="startTime2" class="col-sm-2 control-label">开始时间</label>

                        <div class="col-sm-10">
                            <input type="datetime-local" class="form-control" id="startTime2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="endTime2" class="col-sm-2 control-label">结束时间</label>

                        <div class="col-sm-10">
                            <input type="datetime-local" class="form-control" id="endTime2">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
                <button id="rollcallSubmit" type="button" class="btn btn-info">提交申请</button>
            </div>
        </div>
    </div>
</div>

{* ====扫码签到活动管理框==================================================================================== *}
<div class="modal fade" id="rollcall-manager" tabindex="-1" role="dialog" aria-labelledby="RCManagerLabel"
     aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title" id="ManagerLabel">活动管理</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal login-form" role="form">
                    {*<!-- 身份认证 -->*}
                    <div class="form-group">
                        <label for="student-id2" class="col-sm-2 control-label">学(工)号</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="student-id2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password2" class="col-sm-2 control-label">密码</label>

                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="password2">
                        </div>
                    </div>
                    <p>*学工号及密码与厦大学工系统一致</p>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" id="ManagerLoadBtn2" class="btn btn-primary index-btn" style="float: right;"
                        autocomplete="off">
                    点击查看
                </button>
            </div>
        </div>
    </div>
</div>


{* 商品兑换模态框 *}
<div class="modal fade" id="exchangeModal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">商品兑换</h4>
        </div>
        <div class="modal-body" style="text-align:center;">
            <form>
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" id="exg-token" class="form-control input-lg" placeholder="输入兑换密钥" style="height:60px;font-size:30px;margin-bottom:10px;">
                        <div id="exg-response"></div>
                    </div>
                </div>
                <div class="row">
                    <button type="button" class="btn btn-info btn-lg" id="queryBtn" onclick="query()">查询</button>
                    <button type="button" class="btn btn-info btn-lg" id="exchangeBtn" onclick="exchange(this)" style="display:none;">兑换</button>
                    <button type="button" class="btn btn-info btn-lg" id="closeBtn" data-dismiss="modal" aria-label="Close" style="display:none;">关闭</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>

<script src="{$base}cms/js/vendor/jquery.min.js"></script>
<script src="{$base}cms/js/flat-ui.min.js"></script>

<!-- Loading Simditor JS -->
<script type="text/javascript" src="{$base}cms/js/simditor/module.min.js"></script>
<script type="text/javascript" src="{$base}cms/js/simditor/hotkeys.min.js"></script>
<script type="text/javascript" src="{$base}cms/js/simditor/uploader.min.js"></script>
<script type="text/javascript" src="{$base}cms/js/simditor/simditor.min.js"></script>

<!-- Loading GreenSock JS -->
<script type="text/javascript" src="{$base}cms/js/greensock/TweenMax.min.js"></script>
<script type="text/javascript" src="{$base}cms/js/greensock/TweenLite.min.js"></script>
<script type="text/javascript" src="{$base}cms/js/greensock/TimelineLite.min.js"></script>
<script type="text/javascript" src="{$base}cms/js/greensock/Draggable.min.js"></script>
<script type="text/javascript" src="{$base}cms/js/greensock/plugins/CSSPlugin.min.js"></script>

<script src="{$base}cms/js/index.js?v=0.3"></script>
</body>
</html>
