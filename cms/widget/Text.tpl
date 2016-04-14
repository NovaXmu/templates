<div id="widgetText" style="display: none;">
  <div class="row">
    <ul class="list-group">
      <li class="list-group-item" style="height: 50px;"><label>内容</label></li>
      <li class="list-group-item">
        <textarea class="form-control" rows="10" data-id="Content"></textarea>
      </li>
    </ul>
  </div>
</div>


<script type="text/javascript">
var wechatTextEditer = {

    createNew: function(){
        var editer = {};

        wechatTextEditer.init();

        editer.type = 'text';

        editer.getContent = function(){
            var temp = $('#widgetContent').find('textarea').val();
            if (temp == '') {
                alert('请输入内容');
                return false;
            };
            return { Content:temp };
        };

        editer.setContent = function(content){
          $('#widgetContent').find('textarea').val(content['Content']);
        };

        return editer;
    },

    init: function() {
      var temp = $('#widgetText').clone();
      $('#widgetContent').html(temp.html());
    }
};

</script>
