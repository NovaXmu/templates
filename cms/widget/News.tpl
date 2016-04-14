<div id="widgetNews" style="display: none;">
  <div class="row" id="article">
    <ul class="list-group">
      <li class="list-group-item" style="height: 50px;">
        <label id="articleIndex"></label>
        <button type="button" class="close" id="removeBtn"><span >&times;</span></button>
      </li>
      <li class="list-group-item"><label>标题*</label><input type="text" class="form-control" id="Title" placeholder="Title"></li>
      <li class="list-group-item"><label>描述</label><input type="text" class="form-control" id="Description" placeholder="Description"></li>
      <li class="list-group-item"><label>图片链接</label><input type="text" class="form-control" id="PicUrl" placeholder="PicUrl"></li>
      <li class="list-group-item"><label>文章链接*</label><input type="text" class="form-control" id="Url" placeholder="Url"></li>
    </ul>
  </div>
  <div class="row" id="addBtnRow">
    <button type="button" class="btn btn-info btn-sm" id="addBtn" style="float: right;margin-top: 10px;">新增一条</button>
  </div>
</div>

<script type="text/javascript">

var wechatNewsEditer = {
    article : $('#article').clone(),

    createNew: function(){
        var editer = {};

        wechatNewsEditer.init();

        $('#addBtn').on('click',function(){
          wechatNewsEditer.addItem();

          var count = $(this).parent().siblings('#article').length;
          if (count >= 10) {
            $(this).parent().hide();
          };
        });

        editer.type = 'news';

        editer.getContent = function(){
            var ret = { 'Articles':[] } ;
            $('#widgetContent').find('div#article').each(function () {
                var each = new Object();
                $(this).find('input').each(function (){
                    each[$(this).attr('id')] = $(this).val();
                })
                ret['Articles'].push(each);
            });
            return ret;
        };

        editer.setContent = function(content){
          $('#widgetContent').find('#article').remove();//删掉原有 createNew 里边的第一条图文
          content = content['Articles'];
          for(i in content) {
            var newItem = wechatNewsEditer.addItem();
            newItem.find('input#Title').val(content[i]['Title']);
            newItem.find('input#Description').val(content[i]['Description']);
            newItem.find('input#PicUrl').val(content[i]['PicUrl']);
            newItem.find('input#Url').val(content[i]['Url']);
          }
        };

        return editer;
    },

    init: function() {
      $('#widgetContent').children().replaceWith($('#widgetNews').find('#addBtnRow').clone());
      wechatNewsEditer.addItem();
    },

    addItem: function() {
      var temp = wechatNewsEditer.article.clone();

      temp.find('#removeBtn').on('click',function(e){
          wechatNewsEditer.removeItem($(e.target));
      });

      temp.insertBefore($('#addBtnRow'));

      var count = $('#widgetContent').find('div#article').length;
      temp.find('#articleIndex').text('第 '+count+' 条');

      return temp;
    },

    removeItem: function(e) {
      e.closest('#article').hide();
      e.closest('#article').remove();
      wechatNewsEditer.updateIndex();
    },

    updateIndex: function() {
      var i = 1;
      $('#widgetContent').find('div#article').each(function () {
        $(this).find('#articleIndex').text('第 '+i+' 条');
        i++;
      });
    }
};

</script>
