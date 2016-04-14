<!-- 绑定页 -->
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
    <meta name="format-detection" content="telephone=no" />
    {include file="common/CommonHead.tpl"}
        <link rel="stylesheet" href="{$base}wap/css/linkin.css">
        <link rel="stylesheet" href="{$base}wap/css/linkin_mobile.css">
    </head>
    <body>
        <div id="openid" style="display:none">{$openid}</div>
        {include file="common/Header.tpl"}
        <div id="content">
            <div class="wrapper menu">
                <h2 class="title">账号绑定</h2>
                <div class="bind">
                    {if $xmu == 0}
                    <div class="option xmu-bind">
                        <div class="logo"><img src="{$base}wap/img/iconfont-homefill.png" alt="icon"></div>
                        <div class="name">厦大绑定</div>
                    </div>
                    {/if}
                   {if $yiban == 0}
                    <div class="option yiban-bind">
                        <div class="logo"><img src="{$base}wap/img/iconfont-evaluate.png" alt="icon"></div>
                        <div class="name">易班绑定</div>
                    </div> 
                    {/if}
                    {if $xmu == 1 }
                    <div class="option xmu-unbind">
                        <div class="logo"><img src="{$base}wap/img/iconfont-unlock.png" alt="icon"></div>
                        <div class="name">解除厦大绑定</div>
                    </div>
                    {/if}
                    {if $yiban == 1 }
                    <div class="option yiban-unbind">
                        <div class="logo"><img src="{$base}wap/img/iconfont-unlock.png" alt="icon"></div>
                        <div class="name">解除易班绑定</div>
                    </div>
                    {/if}
                </div>
            </div>
            <div class="wrapper bindXmu" style="display:none">
                <form id="xmu-form" method="post" action="">
                    <h2 class="title">厦大账号绑定</h2>
                    <input type="text" name="stdNum" id="stdNum" placeholder="学号">
                    <input type="password" name="password" id="password" placeholder="密码">
                    <div class="buttons">
                        <div class="button submit">绑定</div>
                        <div class="button return">返回</div>
                    </div>
                </form>
            </div>
        </div>
        {include file="common/Footer.tpl"}
        <script type="text/javascript" src="{$base}common/js/WeixinApi.js?v=1.1"></script>
        <script type="text/javascript" src="{$base}wap/js/linkin.js?v=1.1"></script>
    </body>
</html>
