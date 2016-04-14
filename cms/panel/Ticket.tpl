<div class="row">
  <h4>抢票平台</h4>
</div>

<div class="row" style="margin-bottom: 20px;">
  <ul class="nav nav-tabs nav-justified" role="tablist" id="ticketNav">
    <li role="presentation" class="active" data-id="needReview"><a role="tab" class="text-muted" data-toggle="tab" aria-expanded="true">待审核</a></li>
    <li role="presentation" data-id="ready"><a role="tab" class="text-info" data-toggle="tab" aria-expanded="false">即将开始</a></li>
    <li role="presentation" data-id="onGoing"><a role="tab" class="text-success" data-toggle="tab" aria-expanded="false">正在进行</a></li>
    <li role="presentation" data-id="end"><a role="tab" class="text-warning" data-toggle="tab" aria-expanded="false">已结束</a></li>
    <li role="presentation" data-id="notPassed"><a role="tab" class="text-danger" data-toggle="tab" aria-expanded="false">未通过</a></li>
  </ul>
</div>
<div class="row" id="ticketContent">
  {if is_array($needReview)}
    {foreach $needReview as $each}
      <div class="panel panel-default">
        <div class="panel-heading" data-id="{$each.actID}">{$each.name}</div>

        <table class="table table-hover table-condensed">
          <tbody class="text-center">
            <tr>
              <td>联系人</td>
              <td>{$each.owner}</td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>总票数</td>
              <td>{$each.total}</td>
              <td>每人可抢次数</td>
              <td>{$each.times}</td>
            </tr>
            <tr>
              <td>开始时间</td>
              <td>{$each.startTime}</td>
              <td>结束时间</td>
              <td>{$each.endTime}</td>
            </tr>
            <tr>
              <td>抢票人数</td>
              <td>{$each.count}</td>
              <td></td>
              <td></td>
            </tr>
          </tbody>
        </table>

        <div class="panel-footer text-right">
          <button type="button" class="btn btn-sm btn-success" onclick="review(this,1);">通过</button>
          <button type="button" class="btn btn-sm btn-danger" onclick="review(this,-1);">拒绝</button>
        </div>
      </div>
    {/foreach}
  {/if}
</div>

<div style="display: none;" id="ticketPanel">
  <div class="panel">
    <div class="panel-heading" id="name"></div>

    <table class="table table-hover table-condensed">
      <tbody class="text-center">
        <tr>
          <td>联系人</td>
          <td id="owner">缺省</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>总票数</td>
          <td id="total">缺省</td>
          <td>每人可抢次数</td>
          <td id="times">缺省</td>
        </tr>
        <tr>
          <td>开始时间</td>
          <td id="start">缺省</td>
          <td>结束时间</td>
          <td id="end">缺省</td>
        </tr>
        <tr>
          <td>抢票人数</td>
          <td id="count">0</td>
          <td></td>
          <td></td>
        </tr>
      </tbody>
    </table>

    <div class="panel-footer text-right" id="footer">
      <button type="button" class="btn btn-sm btn-success" id="pass" onclick="review(this,1);">通过</button>
      <button type="button" class="btn btn-sm btn-danger" id="reject" onclick="review(this,-1);">拒绝</button>
    </div>
  </div>
</div>

<script type="text/javascript">
  //@ sourceURL=dynamicScript.js
$(document).ready(function(){

  //导航标签切换
  $('ul#ticketNav').click(function (e) {
    e.preventDefault();

    $('#ticketContent').html(loading);//载入动画
    $(this).tab('show');
  })

  //新导航标签被点击未显示时触发
  $('#ticketNav').children('li').on('show.bs.tab', function (e) {
    $.get(
      '/cms/api/ticket?m=' + $(e.target).parent().data('id'),
      function(data){
        data = jQuery.parseJSON(data);
        data = data.data;

        var panels = '';
        var tag = $(e.target).parent().data('id');
        var panelList = { 'needReview':'panel-default','ready':'panel-info','onGoing':'panel-success','end':'panel-warning','notPassed':'panel-danger' } ;

        for (var i = 0; i < data.length; i++) {
          var panel = $('#ticketPanel').clone();
          panel.find('.panel').addClass(panelList[tag]);

          panel.find('div#name').attr('data-id',data[i]['actID']);//此处只能通过设置属性来记录id
          panel.find('div#name').text(data[i]['name']);
          panel.find('td#owner').text(data[i]['owner']);
          panel.find('td#total').text(data[i]['total']);
          panel.find('td#times').text(data[i]['times']);
          panel.find('td#start').text(data[i]['startTime']);
          panel.find('td#end').text(data[i]['endTime']);
          panel.find('td#count').text(data[i]['count']);


          //只要不是待审核标签，只有一个 退回重审 按钮
          if (tag != 'needReview') {
            var footer = "";

            //若有抢中结果，显示下载抢中列表按钮
            if (data[i]['resultCount'] > 0 ) {
              footer += '<a type="button" class="btn btn-sm btn-info" href="/cms/api/public/ticket?m=getList&id='+ data[i]['actID'] +'">下载中奖名单</a>&nbsp;&nbsp;';
              panel.find('tr').last().children().eq(2).text('中奖人数');
              panel.find('tr').last().children().eq(3).text(data[i]['resultCount']);

            };

            footer += '<button type="button" class="btn btn-sm btn-warning" onclick="review(this,0);">重审</button>';
            panel.find('div#footer').html(footer);
          }

          panels += panel.html();
        };

        $('#ticketContent').html(panels);
        $('#ticketContent').show();
    });
  });

});


function review(e,isPass) {
  var id = $(e).parent().siblings('div').data('id');
  $.post(
    '/cms/api/ticket?m=review',
    {
      actID:id,
      isPassed:isPass
    },
    function(data){
      $(e).closest('div.panel').remove();
    });
}

</script>
