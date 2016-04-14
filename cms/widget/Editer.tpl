<div id="widgetEditer" style="width: 100%;">
  <div class="row" id="widgetSelecter" style="width: 50%;margin-bottom: 20px;">
    <select class="form-control">
      <option value="text">文本消息</option>
      <option value="news">图文消息</option>
    </select>
  </div>
  <div class="row" id="widgetContent" style="width: 90%;">
  </div>
</div>

{include file="cms/widget/Text.tpl"}
{include file="cms/widget/News.tpl"}

<script type="text/javascript">
var wechatEditer = {
    currentEditer : null,
    createNew: function(){
        var editer = {};

        //默认展现文本信息编辑框
        wechatEditer.currentEditer = wechatTextEditer.createNew();
        $('#widgetSelecter').find('select').val('text');

        editer.getType = function(){ return wechatEditer.currentEditer.type };

        editer.getContent = function(){
            return wechatEditer.currentEditer.getContent();
        };

        editer.setType = function(type){
          $('#widgetSelecter').find('select').val(type);
          if (type == 'text') {
              wechatEditer.currentEditer = wechatTextEditer.createNew();
          }
          else if (type == 'news') {
              wechatEditer.currentEditer = wechatNewsEditer.createNew();
          }
          else {
              wechatEditer.currentEditer = null;
              $('#widgetContent').html('');
          }
        };

        editer.setContent = function(content){
            return wechatEditer.currentEditer.setContent(content);
        };

        return editer;
    }
};

$('#widgetSelecter').on('change',function () {
    var type = $(this).find("option:selected").val();
    if (type == 'text') {
        wechatEditer.currentEditer = wechatTextEditer.createNew();
    }
    else if (type == 'news') {
        wechatEditer.currentEditer = wechatNewsEditer.createNew();
    }
});


</script>
