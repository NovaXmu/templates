<div class="row">
  <h4>推送平台
    <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-backdrop="static" data-target="#newPush">
       新建推送
    </button>
    <p style="float: right;">
      当前可送达&nbsp;&nbsp;<span class="label label-success">{$pushCount}</span>&nbsp;&nbsp;人
    </p>
  </h4>
  <small>07:00 ~ 23:00 每十分钟推送一次，夜间的推送任务将会在 07:00 推出。</small>
</div>

<div class="row" style="margin-bottom: 20px;">
  <ul class="nav nav-tabs nav-justified" role="tablist" id="pushNav">
    <li role="presentation" class="active" data-id="needReview"><a role="tab" class="text-muted" data-toggle="tab" aria-expanded="true">待审核</a></li>
    <li role="presentation" data-id="ready"><a role="tab" class="text-info" data-toggle="tab" aria-expanded="false">准备推送</a></li>
    <li role="presentation" data-id="finished"><a role="tab" class="text-success" data-toggle="tab" aria-expanded="false">已推送</a></li>
    <li role="presentation" data-id="disabled"><a role="tab" class="text-danger" data-toggle="tab" aria-expanded="false">拒绝推送</a></li>
  </ul>
</div>
<div class="row" id="pushContent">
</div>

<div id="pushText" style="display: none;">
  <div class="panel panel-default" style="width: 320px">
    <div class="panel-heading text-right"></div>
    {* 文本信息内容 *}
    <div class="panel-body">
      <p id="content"></p>
    </div>
    {if $change } {* 只有拥有写权限的用户可以使用底部区域 *}
    <div class="panel-footer text-right"></div>
    {/if }
  </div>
</div>

<div id="pushNews" style="display: none;">
  <div class="panel panel-default" style="width: 320px">
    <div class="panel-heading text-right"></div>
    <div id="head">
      <div style="z-index:0;position: relative;">
        {* 第一条图文信息图片 *}
        <img id="headImg" src="" style="width: 100%;height: 160px;">
      </div>
      <div style="z-index:10;position: relative;bottom: 0;left: 0;width: 100%;background: rgba(0,0,0,0.6)!important;">
        {* 第一条图文信息标题 *}
        <p id="headtitle" style="padding: 0 8px;margin: 0;color: #fff;font-size: 14px;line-height: 28px;"></p>
      </div>
    </div>
    <ul class="list-group">
      {* 后续图文信息标题和图片 *}
      <li class="list-group-item" style="height: 98px;display: none;"></li>
    </ul>
    {if $change } {* 只有拥有写权限的用户可以使用底部区域 *}
    <div class="panel-footer text-right"></div>
    {/if }
  </div>
</div>


{* ====新建推送活动框====================================================================================== *}

<div class="modal fade" id="newPush" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <div id="submit">

        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
          <h4 class="modal-title" id="PushLabel">新建推送任务</h4>
        </div>
        <div class="modal-body">

          <form id="pushForm" class="form-horizontal" role="form">

          <!-- 推送时间 -->
            <div class="form-group">
              <label for="newTime" class="col-sm-2 control-label">推送时间</label>
              <div class="col-sm-10">
                <input type="datetime-local" class="form-control" id="newTime">
              </div>
            </div>
          <!-- 推送内容 -->
            <div class="form-group">
              <label for="newContent" class="col-sm-2 control-label">推送内容</label>
              <div class="col-sm-10" id="newContent">
                {include file="cms/widget/Editer.tpl"}
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
          <button id="pushSubmit" type="button" class="btn btn-info">提交审核</button>
        </div>

      </div>

      <div id="success" style="display: none;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
          <h4 class="modal-title" id="PushLabel">提交成功</h4>
        </div>
        <div class="modal-body">
          <p>提交成功，请联系高级管理员进行审核。</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
        </div>
      </div>

    </div>
  </div>
</div>


<script type="text/javascript">
$(document).ready(function(){

  //导航标签切换
  $('ul#pushNav').click(function (e) {
    e.preventDefault();
    $('#pushContent').html(loading);//载入动画
    $(this).tab('show');
  });

  //新导航标签被点击未显示时触发
  $('#pushNav').children('li').on('show.bs.tab', function (e) {
    showTab($(e.target).parent().data('id'));
  });

  function reviewTask(id,isPass) {
    $.get(
      '/cms/api/push',
      {
        m:'review',
        id:id,
        review:isPass
      },function(data){
        data = jQuery.parseJSON(data);
        if (data.errno != 0) {
          alert(data.errmsg);
        }
        else {
          showTab($('li.active').data('id')); //刷标签页，更新内容
        }
    });
  }

  function resetTask(id) {
    $.get(
      '/cms/api/push',
      {
        m:'reset',
        id:id
      },function(data){
        data = jQuery.parseJSON(data);
        if (data.errno != 0) {
          alert(data.errmsg);
        }
        else {
          showTab($('li.active').data('id')); //刷标签页，更新内容
        }
    });
  }

  function updateTime (head, taskId) {
    var oldtime = head.text();
    var input = $("<input type='text' value='" + oldtime + "'/>");
    head.html(input);
    input.click(function() {
      return false;
    });
    //获取焦点
    input.trigger("focus");
    //文本框失去焦点后提交内容，重新变为文本
    input.blur(function() {
      var newTime = $(this).val();
      //判断文本有没有修改
      if (newTime != oldtime) {
        head.html(newTime);
        $.get(
          '/cms/api/push',
          {
            m:'update',
            id:taskId,
            newTime:newTime
          },
          function(data) {
            data = jQuery.parseJSON(data);
            if (data.errno != 0) {
              alert(data.errmsg);
            };
            showTab($('li.active').data('id')); //刷标签页，更新内容
        });
      } else {
        head.html(newTime);
      }
    });
  }

  function showTab (id) {
    $.get(
      '/cms/api/push?m=' + id,
      function(data){
        data = jQuery.parseJSON(data);
        if (data.errno != 0) {
          alert(data.errmsg);
        };
        //创建两列
        $('#pushContent').html('<div class="col-md-5" id="firstCol"></div><div class="col-md-5" id="secondCol"></div>');

        data = data.data;
        for(var i = 0; i < data.length; i++) {
          var tasks = data[i];
          var taskID = tasks.id;
          var taskTime = tasks.pushTime;
          var taskState = tasks.state;
          var taskReview = tasks.review;
          var taskContent = jQuery.parseJSON(tasks.content);

          //选择模板
          if (taskContent.type == 'text') { //文本消息
            var view = $('#pushText').clone();
            view.find('#content').text(taskContent.data.content);
          }
          else if (taskContent.type == 'news') { //图文消息
            var view = $('#pushNews').clone();
            //初始化
            view.find('.list-group').html('<li class="list-group-item" style="height: 98px;display: none;"></li>');

            //第一张大图文
            view.find('#headImg').attr('src',taskContent.data.articles[0].picurl);
            view.find('#headtitle').text(taskContent.data.articles[0].title);
            view.find('#head').bind('click', { url : taskContent.data.articles[0].url } ,function(e){
              if(e.data.url && e.data.url.indexOf('://') == -1) {
                e.data.url = 'http://' + e.data.url;
              }
              window.open(e.data.url);
            });

            //后续小图文
            var length = taskContent.data.articles.length;
            for(var j = 1; j < length; j++) {
              var article = taskContent.data.articles[j];
              var item = view.find('.list-group-item').clone();
              var img = '<img src="'+article.picurl+'" style="float: right;width: 78px;height: 78px;margin-left: 14px;">';
              item.html(article.title + img);

              item.bind('click', { url : article.url } ,function(e){
                if(e.data.url && e.data.url.indexOf('://') == -1) {
                  e.data.url = 'http://' + e.data.url;
                }
                window.open(e.data.url);
              });
              item.css('display','block');
              view.find('.list-group').append(item);
            }
          }
          else {
            break; //遇到不认识的类型先跳过
          }

          //头部区域
          view.find('.panel-heading').html('');
          view.find('.panel-heading').text(taskTime);

          {if $change } {* 只有拥有写权限的用户可以使用底部区域 *}
          //点击修改时间
          view.find('.panel-heading').click( { id:taskID } ,function(e) {
            updateTime($(this),e.data.id);
          });

          {/if}

          taskTime = taskTime.replace("-","/");//替换字符，变成标准格式
          var now = new Date();//取今天的日期
          var taskTime = new Date(Date.parse(taskTime));
          if(now >= taskTime) {
            view.find('.panel').removeClass('panel-default');
            view.find('.panel').addClass('panel-warning');
          }
          else {
            view.find('.panel').removeClass('panel-default');
            view.find('.panel').addClass('panel-info');
          }

          {if $change } {* 只有拥有写权限的用户可以使用底部区域 *}

          //底部操作区域
          var pass   = $('<button type="button" class="btn btn-sm btn-success" >通过</button>');//批准推送
          var reject = $('<button type="button" class="btn btn-sm btn-danger" >拒绝</button>');//拒绝推送
          var reset  = $('<button type="button" class="btn btn-sm btn-warning" >重置</button>');//重置任务状态，恢复未审核未推送

          pass.css('margin','0px 2px 0px 2px');
          if (now >= taskTime) { //若活动已过期，审核通过后会在下一次推送时推出，需要 confirm
            pass.click( { taskID:taskID } ,function(event){
              if (confirm('任务将会在下一个十分钟推出！\n请谨慎审核')){
                reviewTask(event.data.taskID,1);
              }
            })
          }
          else {
            pass.click( { taskID:taskID } ,function(event){
              if (confirm('确认后，任务将会定时推出，请谨慎审核')){
                reviewTask(event.data.taskID,1);
              }
            })
          }
          reject.css('margin','0px 2px 0px 2px');
          reject.click( { taskID:taskID } ,function(event){
            reviewTask(event.data.taskID,-1);
          })
          reset.css('margin','0px 2px 0px 2px');
          reset.click( { taskID:taskID } ,function(event){
            resetTask(event.data.taskID);
          })

          view.find('.panel-footer').html('');
          if (id != 'needReview') {
            view.find('.panel-footer').append(reset);
          }
          else {
            view.find('.panel-footer').append(pass);
            view.find('.panel-footer').append(reject);
          }

          {/if}

          view.show();
          if (i % 2 == 0) { //分两列展示
            $('#firstCol').append(view);
          }
          else {
            $('#secondCol').append(view);
          }
        }
      });
    $('#pushContent').show();
  }

  var editer = null;
  $('#newPush').on('show.bs.modal', function (e) {
    $('#newPush').find('#newTime').val('');
    editer = wechatEditer.createNew();
    $('#newPush').find('#submit').show();
    $('#newPush').find('#success').hide();
  });

  $('#pushSubmit').on('click', function () {
    var type = editer.getType();
    var data = editer.getContent();
    var time = $('#newPush').find('#newTime').val();
    if (time == '') {
      alert('请填写推送时间');
      return false;
    };
    if (type && data && time) {
      if (type == 'news') {
        for(i in data){
          if (data[i]['Title'] == '' || data[i]['Url'] == '') {
            alert('请填写必填项');
            return false;
          };
        }
      }
      $.post(
        '/cms/api/push/?m=add',
        {
          time:time,
          content:JSON.stringify({
            type:type,
            data:data
          })
        },
        function(data){
          data = jQuery.parseJSON(data);
          if (data.errno != 0) {
            alert(data.errmsg);
          };
          $('#newPush').find('#submit').hide();
          $('#newPush').find('#success').show();
          showTab('needReview'); //刷一遍待审核页面

          return true;
        });
    };
    return false;
  });

  showTab('needReview'); //默认打开待审核页面
});

</script>
