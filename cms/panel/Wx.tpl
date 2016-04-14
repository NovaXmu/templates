<style>
    #switch {
        margin: 10px 0;
        width: 100%;
    }

    .item {
        list-style: none;
        margin: 0 0 20px;
        background-color: #eee;
        padding: 10px 30px 10px 10px;
    }

    .delete-item {
        position: absolute;
        margin: 0 10px;
        color: #ccc;
    }

    .delete-item:hover {
        cursor: pointer;
        color: #000;
    }

    .msg {
        margin: 5px 0;
    }

    .labels div {
        text-align: center;
    }

    .btns {
        float: right;
        padding: 15px;
    }
</style>

<div class="row">
    <h4>抢票平台</h4>
</div>

<div class="row">
    <div class="col-xs-8">
        <button id="switch" data-mode="none" class="btn">点击按钮选择操作模式</button>
        <div id="list"></div>
        <div class="alert" id="message" style="display: none;"></div>
        <div class="row btns">
            <button class="btn btn-danger" id="add-item">添加</button>
            <button class="btn btn-primary" id="submit">确定</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    //@ sourceURL=dynamicScript.js
    $("button#switch").on("click", function() {
        if ( $(this).data("mode") === "none" || $(this).data("mode") === "deduct" ) {
            $(this).data("mode","distribute").text("发网薪").removeClass("btn-danger").addClass("btn-primary");
        } else if ( $(this).data("mode") === "distribute" ) {
            $(this).data("mode","deduct").text("扣网薪").removeClass("btn-primary").addClass("btn-danger");
        }
        $("#message").text("").attr("class","alert").hide();
        $(".msg").text("").attr("class", "msg alert col-xs-12").hide();
    });

    $("#add-item").on("click", function() {
        var item = '<li class="row item">\
                <input type="text" class="col-xs-6 yiban-id" placeholder="易班ID"/>\
        <input type="text" class="col-xs-6 amount" placeholder="金额"/>\
        <span class="delete-item" onclick="deleteItem(this)">x</span>\
        <p class="msg alert col-xs-12" style="display: none;"></p>\
        <textarea name="desc" rows="3" class="col-xs-12 desc" placeholder="备注"></textarea>\
        </li>';
         $("#list").append(item);
    });

    function deleteItem(e) {
        $(e).parents(".item").detach();
    }

    function onSubmit() {
        var m = $("#switch").data("mode");
        var yibanIds = [];
        var awards = [];
        var descriptions = [];
        var legal = true;
        if ( m != "distribute" && m != "deduct" ) {
            $("#message").text("请选择一种操作").addClass("alert-warning").show();
            return;
        } else {
            $("#message").text("").attr("class","alert").hide();
        }
        $(".item").each(function() {
            var id = $(this).find(".yiban-id").val();
            var amount = $(this).find(".amount").val();
            var desc = $(this).find(".desc").val();

            if ( id && ( !amount || amount < 0 || isNaN(amount) ) ) {
                $(this).find(".msg").text("金额必须是大于零的整数").removeClass("alert-danger").removeClass("alert-success").addClass("alert-warning").show();
                legal = false;
                return;
            }

            if ( id ) {
                yibanIds.push(id);
                awards.push(parseInt(amount));
                descriptions.push(desc);
            }
        });

        if ( !legal || !yibanIds.length || yibanIds.length != awards.length ) {
            return;
        }
        $("#submit").prop("disabled",true);
        $.post(
                '/cms/api/wx?m=' + m,
                {
                    yibanIds: JSON.stringify(yibanIds),
                    awards: JSON.stringify(awards),
                    descriptions: JSON.stringify(descriptions)
                }, function(response) {
                    if ( response.errno == 0 ) {
                        $(".msg").text("").attr("class", "msg alert col-xs-12").hide();
                        $("#message").text($("#switch").text() + "成功！").removeClass("alert-warning").removeClass("alert-danger").addClass("alert-success").show();
                    } else {
                        $("#message").text("还有一些条目没有操作成功，请重试！" + response.errmsg? "错误信息：" + response.errmsg : "").removeClass("alert-warning").removeClass("alert-success").addClass("alert-danger").show();
                        var filtered = $(".item").filter(function() {
                            return $(this).find(".yiban-id").val();
                        });

                        filtered.each(function(index) {
                            var resp = response.data[index];
                            if ( resp.errno == 0 ) {
                                $(this).detach();
                            } else {
                                $(this).find(".msg").text(resp.errmsg).removeClass("alert-warning").removeClass("alert-success").addClass("alert-danger").show();
                            }
                        });
                    }
                    $("#submit").prop("disabled",false);
                }, "JSON"
        );
    }

    $("#submit").on("click", onSubmit);
    $(function() {
        $("#add-item").click();
    });

</script>