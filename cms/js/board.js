var loading = '<div class="spinner">\
                  <div class="rect1"></div>\
                  <div class="rect2"></div>\
                  <div class="rect3"></div>\
                  <div class="rect4"></div>\
                  <div class="rect5"></div>\
                </div>';
$(document).ready(function () {

    //加载面板
    $('#models').find('button').on('click', function (e) {
        e.stopPropagation();
        $('#panel').html(loading);
        var url = "/cms/board/panel/" + $(this).attr('data-model');
        $('#panel').load(url);
    });

    //用户信息修改
    $('#UserUpdateBtn').click(function () {
        var user = $('#User');
        var name = user.find('#name').val();
        var password = user.find('#password').val();
        var confirm = user.find('#confirm').val();
        if (!name && !password) {
            return false;
        }

        if (password != confirm) {
            user.find('#info').removeClass('text-info')
                .addClass('text-warning')
                .text('请确认您两次密码输入一致');
            return false;
        }
        else if (password && password.length < 6) {
            user.find('#info').removeClass('text-info')
                .addClass('text-warning')
                .text('密码长度需多于六位');
            return false;
        }
        else {
            $.post(
                '/cms/api/admin?m=update',
                {
                    name: name,
                    password: password
                }, function (data) {
                    data = jQuery.parseJSON(data);
                    if (data.errno == 0) {
                        if (name) {
                            user.find('#name').attr('placeholder', name);
                        }

                        user.modal('hide');
                        alert('修改成功');
                        if (name) {
                            //只有在修改了昵称的情况下才需要刷新页面
                            window.location.href = '/cms/board/index';
                        }
                    }
                    else {
                        user.find('#info').removeClass('text-info')
                        .addClass('text-warning')
                        .text(data.errmsg);
                    }
                });
        }
    });

    //用户信息修改框重置
    $('#User').on('hidden.bs.modal', function () {
        $('#User').find('#name').val('')
            .end().find('#password').val('')
            .end().find('#confirm').val('')
            .end().find('#info').removeClass('text-warning')
            .end().find('#info').addClass('text-info');
    });
});
