<div class="row">
  <h4>文本信息</h4>
</div>
<div class="row well" id='text'>
    {foreach $keywords as $keyword}
      <span class="label label-info" data-id="{$keyword.id}" data-type="{$keyword.replyType}">{$keyword.word}</span>
      <div style="display:none">{$keyword.reply}</div>
    {/foreach}
    <button type="button" class="btn btn-inverse" data-toggle="modal" data-backdrop="static" data-target="#newText" style="float: right;margin-top: 35px;">添加</button>
</div>

<div class="row" id="editor" style="display: none">
  <div class="col-md-6 col-md-offset-3">
    <input type="text" class="form-control" id="word" style="margin-bottom: 20px;">
    <div id="content"></div>
    <button id="submit" type="button" class="btn btn-inverse" style="float: right;margin-top: 35px;">提交</button>
  </div>
</div>


{* ====新建文本信息框====================================================================================== *}

<div class="modal fade" id="newText" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <div id="submit">

        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
          <h4 class="modal-title" id="TextLabel">新建关键词回复</h4>
        </div>
        <div class="modal-body">

          <form id="textForm" class="form-horizontal" role="form">

          <!-- 关键词 -->
            <div class="form-group">
              <label for="newText" class="col-sm-2 control-label">关键词</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="newWord">
              </div>
            </div>
          <!-- 回复内容 -->
            <div class="form-group">
              <label class="col-sm-2 control-label">回复内容</label>
              <div class="col-sm-8">
                <div id="addEditor"></div>
              </div>
            </div>

          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
          <button id="textSubmit" type="button" class="btn btn-info">提交</button>
        </div>

      </div>

      <div id="success" style="display: none;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
          <h4 class="modal-title" id="PushLabel">提交成功</h4>
        </div>
        <div class="modal-body">
          <p>提交成功，已生效。</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
        </div>
      </div>

    </div>
  </div>
</div>


<script type="text/javascript">
  var editor = new Weditor({
    area: '#content'
  });

  $('#text').find('span').on('click', function() {
    var type = $(this).data('type');
    if (type == 'text' || type == 'news') {
      $('#editor').find('#word').val($(this).text());
      $('#editor').find('#word').data('id',$(this).data('id'));
      editor.setType(type);
      editor.setContent($(this).next().text());
      $('#editor').show();
    } else {
      $('#editor').hide();
    }
  });

  $('#submit').on('click', function() {
    id = $('#editor').find('#word').data('id');
    var word =  $('#editor').find('#word').val();
    if (id == '' || word == '') {
      return false;
    };
    var type = editor.getType();
    var data = editor.getContent();
    if (type && data) {
      if (type == 'news') {
        for (i in data) {
          if (data[i]['Title'] == '' || data[i]['Url'] == '') {
            alert('请填写必填项');
            return false;
          };
        }
      }
      $.post(
        '/cms/api/text/?m=update', {
          id: id,
          word: word,
          content: JSON.stringify({
            type: type,
            data: data
          })
        },
        function(data) {
          data = jQuery.parseJSON(data);
          if (data.errno != 0) {
            alert(data.errmsg);
          };
          $('#editor').hide();

          $('#models').find('button').each(function() {
            if ($(this).attr('data-model') == 'text') {
              $(this).click(); //刷一遍页面
            };
          })

          return true;
        })
    }
  });

  var newEditor = null;
  $('#newText').on('show.bs.modal', function(e) {
    $('#newText').find('#newWord').val('');
    newEditor = new Weditor({
      area: '#addEditor'
    });
    $('#newText').find('#submit').show();
    $('#newText').find('#success').hide();
  });

  $('#textSubmit').on('click', function() {
    var type = newEditor.getType();
    var data = newEditor.getContent();
    var word = $('#newText').find('#newWord').val();
    if (word == '') {
      alert('请填写关键词');
      return false;
    };
    if (type && data && word) {
      if (type == 'news') {
        for (i in data) {
          if (data[i]['Title'] == '' || data[i]['Url'] == '') {
            alert('请填写必填项');
            return false;
          };
        }
      }
      $.post(
        '/cms/api/text?m=add', {
          word: word,
          content: JSON.stringify({
            type: type,
            data: data
          })
        },
        function(data) {
          data = jQuery.parseJSON(data);
          if (data.errno != 0) {
            alert(data.errmsg);
          };
          $('#newText').find('#submit').hide();
          $('#newText').find('#success').show();

          return true;
        });
    };
    return false;
  });
</script>
