<div class="row">
    <h4>扫码签到</h4>
</div>

<div class="row" style="margin-bottom: 20px;">
    <ul class="nav nav-tabs nav-justified" role="tablist" id="rollcallNav">
        <li role="presentation" class="active" data-id="needReview"><a role="tab" class="text-muted" data-toggle="tab"
                                                                       aria-expanded="true">待审核</a></li>
        <li role="presentation" data-id="ready"><a role="tab" class="text-info" data-toggle="tab" aria-expanded="false">即将开始</a>
        </li>
        <li role="presentation" data-id="onGoing"><a role="tab" class="text-success" data-toggle="tab"
                                                     aria-expanded="false">正在进行</a></li>
        <li role="presentation" data-id="end"><a role="tab" class="text-warning" data-toggle="tab"
                                                 aria-expanded="false">已结束</a></li>
        <li role="presentation" data-id="notPassed"><a role="tab" class="text-danger" data-toggle="tab"
                                                       aria-expanded="false">未通过</a></li>
    </ul>
</div>
<div class="row" id="rollcallContent">
    {if is_array($needReview)}
        {foreach $needReview as $each}
            <div class="panel panel-default">
                <div class="panel-heading" data-id="{$each.md5}" isPassed="{$each.isPassed}">{$each.name}</div>

                <table class="table table-hover table-condensed">
                    <tbody class="text-center">
                    <tr>
                        <td>申请人学工号</td>
                        <td>{$each.owner}</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>开始时间</td>
                        <td>{$each.startTime}</td>
                        <td>结束时间</td>
                        <td>{$each.endTime}</td>
                    </tr>
                    <tr>
                        <td>申请网薪</td>
                        <td>{$each.award}</td>
                        <td>年级限制</td>
                        <td>
                            {if $each.limitConds != null}
                                {if $each.limitConds.grade != null}
                                    {$each.limitConds.grade}
                                {/if}
                            {/if}
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div style="padding: 10px 33px;">
                    <h7>活动详情</h7>
                    <div style="overflow: auto; border: dashed 1px #ccc">{$each.extra}</div>
                </div>

                <div class="panel-footer text-right">
                    <button type="button" class="btn btn-sm btn-success" onclick="review(this,1);">通过</button>
                    <button type="button" class="btn btn-sm btn-danger" onclick="review(this,-1);">拒绝</button>
                </div>
            </div>
        {/foreach}
    {/if}
</div>

<div style="display: none;" id="rollcallPanel">
    <div class="panel">
        <div class="panel-heading" id="name"></div>

        <table class="table table-hover table-condensed">
            <tbody class="text-center">
            <tr>
                <td>申请人学工号</td>
                <td id="owner">缺省</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>开始时间</td>
                <td id="start">缺省</td>
                <td>结束时间</td>
                <td id="end">缺省</td>
            </tr>
            <tr>
                <td>申请网薪</td>
                <td id="award">缺省</td>
                <td>年级限制</td>
                <td id="grade-limit">缺省</td>
            </tr>
            </tbody>
        </table>
        <div style="padding: 10px 33px;">
            <h7>活动详情</h7>
            <div id="extra" style="overflow: auto; border: dashed 1px #ccc">0</div>
        </div>

        <div class="panel-footer text-right" id="footer">
            <button type="button" class="btn btn-sm btn-success" id="pass" onclick="review(this,1);">通过</button>
            <button type="button" class="btn btn-sm btn-danger" id="reject" onclick="review(this,-1);">拒绝</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        //导航标签切换
        $('ul#rollcallNav').click(function (e) {
            e.preventDefault();

            $('#rollcallContent').html(loading);//载入动画
            $(this).tab('show');
        })

        //新导航标签被点击未显示时触发
        $('#rollcallNav').children('li').on('show.bs.tab', function (e) {
            var mValue = $(this).attr('data-id');
            $.get(
                    '/cms/api/rollcall',
                    {
                        m: mValue
                    },
                    function (data) {
                        var data = jQuery.parseJSON(data);
                        var content = data.data;

                        if (data.errno == 0) {
                            var panels = '';
                            var tag = $(e.target).parent().data('id');
                            var panelList = {
                                'needReview': 'panel-default',
                                'ready': 'panel-info',
                                'onGoing': 'panel-success',
                                'end': 'panel-warning',
                                'notPassed': 'panel-danger'
                            };

                            for (var i = 0; i < content.length; i++) {
                                var panel = $('#rollcallPanel').clone();
                                panel.find('.panel').addClass(panelList[tag]);

                                panel.find('div#name').attr('data-id', content[i].md5);//此处只能通过设置属性来记录id
                                panel.find('div#name').attr('isPassed', content[i].isPassed);//此处只能通过设置属性来记录id
                                panel.find('div#name').text(content[i].name);
                                panel.find('td#owner').text(content[i].owner);
                                panel.find('td#award').text(content[i].award);
                                panel.find('td#grade-limit').text(content[i].limitConds? content[i].limitConds.grade? content[i].limitConds.grade : "" : "");
                                panel.find('td#start').text(content[i].startTime);
                                panel.find('td#end').text(content[i].endTime);
                                panel.find('div#extra').html(content[i].extra);


                                //只要不是待审核标签，只有一个 退回重审 按钮
                                if (tag != 'needReview') {
                                    var footer = "";
                                    footer += '<button type="button" class="btn btn-sm btn-warning" onclick="review(this,0);">重审</button>';
                                    panel.find('div#footer').html(footer);
                                }

                                panels += panel.html();
                            }
                            ;

                            $('#rollcallContent').html(panels);
                            $('#rollcallContent').show();
                        }
                        else {
                            alert(content.errmsg);
                        }

                    });
        });

    });


    function review(e, isPass) {
        var id = $(e).parent().siblings('div').data('id');
        $.get(
                '/cms/api/rollcall',
                {
                    m: 'review',
                    md5: id,
                    isPassed: isPass
                },
                function (data) {
                    var data = eval('(' + data + ')');
                    if (data.errno == 0) {
                        $(e).closest('div.panel').remove();
                    }
                    else {
                        alert(data.errmsg);
                    }
                });
    }

</script>
