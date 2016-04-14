<style>
  #privilegeModal td {
    vertical-align: middle;
  }
  #privilegeModal td .btn {
    padding: 5px;
  }
</style>

<div class="row">
    <h4>平台管理</h4>
  <button type="button" class="btn btn-success btn-sm" id="create" data-toggle="modal" data-target="#createModal" style="float: right;">添加</button>
  <small>将鼠标移至对应管理员，即可获知该管理员有权限查看的模块</small>
</div>
<div class="row">
  <table class="table table-hover">
    <thead>
      <tr>
        <th>登录名</th>
        <th>昵称</th>
        <th>权限</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody class="table-striped" id="userList">
      {* ====普通用户看不到开发者==== *}
      {foreach $users as $user}
        {if $user.level < 10 || $currentLevel >= 10}
        <tr height="55px">
          <td class="user" data-id="{$user.id}">{$user.user}</td>
          <td class="nickname">{$user.nickname}</td>
          <td class="level" width="150px;">{$user.level}</td>
          <td>
              <button type="button" class="btn btn-info btn-sm reset">重置密码</button>
              <button type="button" class="btn btn-danger btn-sm delete">删除</button>
            {if $user.isPassed}
              {assign var=aStyle value="default"}
              {assign var=fStyle value="warning"}
            {else}
              {assign var=aStyle value="success"}
              {assign var=fStyle value="default"}
            {/if}
              <button type="button" class="btn btn-{$aStyle} btn-sm activate">激活</button>
              <button type="button" class="btn btn-{$fStyle} btn-sm freeze">冻结</button>
              <button type="button" class="btn btn-primary btn-sm config" data-toggle="modal" data-target="#privilegeModal"
                      data-id="{$user.id}"
                      data-nickname="{$user.nickname}">查看权限详情</button>
          </td>
        </tr>
        {/if}
      {/foreach}
    </tbody>
  </table>
</div>

<!-- 添加新管理员 -->
<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">新增管理员</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <input type="text" class="form-control" id="c-user" placeholder="登录名" required/>
          </div>
          <div class="form-group">
            <input type="password" class="form-control" id="c-pwd" placeholder="密码" required/>
          </div>
          <div class="form-group">
            <input type="password" placeholder="确认密码" id="c-pwd-confirm" class="form-control" required/>
          </div>
          <div class="form-group">
            <input type="email" placeholder="Email" id="c-email" class="form-control" required/>
          </div>
          <div class="form-group">
            <input type="text" placeholder="昵称(选填)" id="c-nickname" class="form-control"/>
          </div>
          <div class="form-group">
            <select name="" id="c-level" class="form-control">
              <option value="">权限等级（选填）</option>
              <option value="0">0</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
            </select>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="submitCreate">提交</button>
      </div>
    </div>
  </div>
</div>

<!-- 权限Modal -->
<div class="modal fade" id="privilegeModal" tabindex="-1" role="dialog" aria-labelledby="privilegeModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">权限管理</h4>
      </div>
      <div class="modal-body">
        <h6 id="priv-user-info" style="text-align: center"></h6>
        <div id="menu-privilege" class="panel panel-primary" data-type="1">
          <div class="title panel-heading">一级权限</div>
          <div class="panel-body">
            <table class="table table-striped table-hover">
            </table>
          </div>
        </div>
        <div id="sub-privilege" class="panel panel-primary" data-type="2">
          <div class="title panel-heading">二级权限</div>
          <div class="panel-body">
            <table class="table table-striped table-hover">
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  //@ sourceURL=dynamicScript.js
  $("#submitCreate").on("click", function() {
    var user = $("#c-user").val();
    var pwd = $("#c-pwd").val();
    var pwd_confirm = $("#c-pwd-confirm").val();
    var email = $("#c-email").val();
    var nickname = $("#c-nickname").val();
    var level = $("#c-level").val();

    if ( !user || !pwd || !pwd_confirm || !email ) {
      alert("信息不完整");
      return;
    }

    if ( pwd != pwd_confirm ) {
      alert("两次输入密码不一致，请重新输入");
      return;
    }

    $.post(
            '/cms/api/admin?m=create',
            {
              user: user,
              pwd: pwd,
              email: email,
              nickname: nickname,
              level: level
            },function(response) {
              if ( response.errno == 0 ) {
                alert("创建成功！");
              } else alert(response.errmsg);
            },"JSON"
    );
  });

  $(".activate").on("click",function(e) {
    var uid = $(e.target).parent().siblings('.user').data("id");
    $.post(
            '/cms/api/admin?m=setPass',
            {
              uid: uid,
              isPassed: 1
            }, function(response) {
              if ( response.errno == 0 ) {
                alert("激活成功！");
              } else {
                alert(response.errmsg);
              }
            },"JSON"
    );
  });

  $(".freeze").on("click",function(e) {
    var uid = $(e.target).parent().siblings('.user').data("id");
    $.post(
            '/cms/api/admin?m=setPass',
            {
              uid: uid,
              isPassed: 0
            }, function(response) {
              if ( response.errno == 0 ) {
                alert("冻结成功！");
              } else {
                alert(response.errmsg);
              }
            },"JSON"
    );
  });
  var addPrivBtnHtml = '<button class="btn btn-info add-priv" style="float: right;" onclick="addPriv(this)">添加</button>';
  var removePrivBtnHtml = '<button class="btn btn-danger remove-priv" style="float: right;" onclick="removePriv(this)">移除</button>';

  $("#privilegeModal").on("show.bs.modal", function(e) {
    var thisModal = $(this);
    $("#menu-privilege table, #sub-privilege table").empty();
    var uid = $(e.relatedTarget).data("id");
    var nickname = $(e.relatedTarget).data("nickname");
    var level = $(e.relatedTarget).parent("td").siblings(".level").text();
    var userPriv;
    $.get(
            '/cms/api/admin?m=getAdminPrivilege',
            {
              adminId: uid
            }, function(response) {
              if ( response.errno == 0 ) {
                $("#priv-user-info").text(nickname + "（" + level + "级）").data("id", uid);
                userPriv = response.data;
                if ( userPriv ) {
                  var menuPriv = userPriv.menus;
                  var subPriv = userPriv.subPrivileges;
                  var displayData = function(o, container) {
                    for ( var prop in o ) {
                      if ( o.hasOwnProperty(prop) && o[prop] ) {
                        var desc = o[prop]['description'];
                        var obtained = o[prop]['obtained'];
                        var id = o[prop]['id'] || "";
                        var icon, button;
                        if ( obtained ) {
                          icon = '<span class="glyphicon glyphicon-ok"></span>';
                          button = level < 10? removePrivBtnHtml : '';
                        } else {
                          icon = '<span class="glyphicon glyphicon-remove"></span>';
                          button = level < 10? addPrivBtnHtml : '';
                        }
                        var row = '<tr>\
                      <td class="priv-desc" data-key="' + prop + '" data-id="' + id + '">' + desc + '</td>\
                      <td>' + button + icon + '</td>\
                      </tr>';

                        $(row).appendTo(container);
                      }
                    }
                  };
                  displayData(menuPriv, "#menu-privilege table");
                  displayData(subPriv, "#sub-privilege table");
                }
              } else {
                $("#priv-user-info").text(response.errmsg);
              }
            }, "JSON"
    );
  });

  function addPriv(btn) {
    btn = $(btn);
    var descTd = btn.parent().siblings(".priv-desc");
    var key = btn.parent().siblings(".priv-desc").data("key");
    var uid = $("#priv-user-info").data("id");
    var levelType = btn.parents(".panel").data("type");
    if ( !key || !uid || !levelType ) return;
    $.post(
            '/cms/api/admin?m=addPrivilege',
            {
              uid: uid,
              privilege: key,
              level: levelType
            }, function(response) {
              if ( response.errno == 0 ) {
                btn.parent().html('<span class="glyphicon glyphicon-ok"></span>' + removePrivBtnHtml);
                descTd.data("id", response.data);
              } else {
                alert(response.errmsg);
              }
            }, "JSON"
    );
  }

  function removePriv(btn) {
    btn = $(btn);
    var id = btn.parent().siblings(".priv-desc").data("id");
    if ( !id ) return;
    $.post(
            '/cms/api/admin?m=removePrivilege',
            {
              privilegeId: id
            }, function(response) {
              if ( response.errno == 0 ) {
                btn.parent().html('<span class="glyphicon glyphicon-remove"></span>' + addPrivBtnHtml);
              } else {
                alert(response.errmsg);
              }
            }, "JSON"
    );
  }

  $('#userList').find('button.reset').click(function(e){
    var user = $(e.target).parent().siblings('.user').text();
    $.post(
      "/cms/api/admin?m=reset",
      {
        user:user
      },
      function(data){
        data = jQuery.parseJSON(data);
        if (data.errno == '0') {
          alert('重置成功');
        }
        else {
          alert(data.errmsg);
        }
      })
  });

  $('#userList').find('button.delete').click(function(e){
    if (confirm("确认删除吗？")){
      var user = $(e.target).parent().siblings('.user').text();
      $.post(
        "/cms/api/admin?m=delete",
        {
          user:user
        },
        function(data){
          data = jQuery.parseJSON(data);
          if (data.errno == '0') {
            $(e.target).parents('tr').remove();//删除当前行
          }
          else {
            alert(data.errmsg);
          }
      })
    }
  });

  //点击修改权限
  $('table td').click(function(){
    if(!$(this).is('.input') && $(this).is('.level') && $(this).text() < 10) {
      $(this).addClass('input').html('<input type="number" max="9" min="0" width="100%;" value="'+ $(this).text() +'" />').find('input').focus().blur(function(){
        var user = $(this).parent().siblings("td.user").text();
        var newLevel = $(this).val();

        $.get('/cms/api/admin?m=updateLevel'+'&user='+user+'&level='+newLevel);

        $(this).parent().removeClass('input').html($(this).val() || 0);
        //恢复左边栏原样
        $('li.board-list').children().each(function(){
          $(this).removeClass('btn-default');
          $(this).addClass('btn-primary');
        });
      });
    }
  });
</script>
