var initialTicketModal = document.getElementById("Ticket").innerHTML;
var initialLoginModal = document.getElementById("Login").innerHTML;
var initialTicketManagerModal = document.getElementById("ticket-manager").innerHTML;
var initialRollcallModal = document.getElementById("rollcall").innerHTML;
var initialRollcallManagerModal = document.getElementById("rollcall-manager").innerHTML;
var initialTicketModalData;
var initialRollcallModalData;

$('#Login').on('hidden.bs.modal', function() {
    loginModal().onHide();
}).on('show.bs.modal',function() {
    loginModal().onShow();
});

$('#Ticket').on('hidden.bs.modal', function() {
    ticketModal().onHide();
}).on('show.bs.modal', function() {
    ticketModal().onShow(initialTicketModalData);
});

$("#ticket-manager").on("show.bs.modal", function(e) {
    ticketManagerModal().onShow();
}).on("hidden.bs.modal", function(e) {
    ticketManagerModal().onHide();
});

$("#rollcall").on("show.bs.modal", function() {
    rollcallModal().onShow(initialRollcallModalData);
}).on("hidden.bs.modal",function() {
    rollcallModal().onHide();
});

$("#rollcall-manager").on("show.bs.modal", function(e) {
    rollcallManagerModal().onShow();
}).on("hidden.bs.modal", function(e) {
    rollcallManagerModal().onHide();
});

function assignSeat(e){
    var seat = prompt("请按格式（01-02）输入座位号：", "01-02");
    if (seat == null && seat == "") {
        alert("输入错误，请重新输入！");
        assignSeat(e);
    }else{
        $.ajax({
            url: '/ticket/api/public/host?m=assignSeat',
            type: 'post',
            data: {
                logId: $(e).attr("data"),
                seat: seat
            },
            success: function(data) {
                var data = jQuery.parseJSON(data);
                if (data.errno != 0)
                    alert(data.errmsg);
                else {
                    $("#AssignSeatBtn").hide();
                    $("#ExchangeInfo").append('<span>座位号：' + seat + '</span>');
                }

            }
        });
    }
    
}

//可滑动的展示框
function showcase() {
    var self = document.getElementById("showcase");
    var apps = document.getElementsByClassName("app");
    var showcaseW = self.getBoundingClientRect().width;
    var currentCase = 0;

    return {
        fixLayout: function() {
            var picW = self.querySelector(".pic img").getBoundingClientRect().width;
            var numOfApps = apps.length;
            self.getElementsByTagName("ul")[0].style.width = (showcaseW * numOfApps) + "px";
            var textboxes = self.getElementsByClassName("textbox");
            for (var i = 0; i < textboxes.length; i++) {
                textboxes.item(i).style.width = (showcaseW - picW) + "px";
            }
        },
        swipe: function(index) {
            var tl = new TimelineLite();
            tl.to(self.getElementsByTagName("ul")[0], 1, {
                left: -(showcaseW * index) + "px",
                ease: Power1.easeInOut
            });
            currentCase = index;
        }
    };
}

//登录框
function loginModal() {
    var loginBtn = document.getElementById("loginButton");
    return {
        handleClick: function() {
            $(this).button("loading");
            var form = document.getElementById("loginForm");
            var username = form.querySelector("#username").value;
            var password = form.querySelector("#password").value;

            if (!username || !password) {
                $(this).button("reset");
                alert("请输入用户名和密码");
                return false;
            }
            var $loginBtn = $(loginBtn);
            var request = new XMLHttpRequest();
            var data = {
                user: username,
                pwd: password
            };
            request.open("POST", "/cms/api/login");
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            request.onreadystatechange = function() {
                if (request.readyState === 4 && request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    if (response.errno == 0) {
                        loginBtn.classList.add("btn");
                        loginBtn.classList.add("btn-success");
                        loginBtn.classList.add("index-btn|");
                        $loginBtn.button("success");
                        window.location.href = response.to;
                    } else {
                        $loginBtn.button("reset");
                        alert(response.errmsg);
                    }
                }
            };
            request.send(encodeFormDate(data));
        },

        handleKeypress: function(e) {
            if (e.keyCode === 13) {
                triggerMouseEvent(loginBtn, "click");
            }
        },

        onShow: function() {
            //点击登录按钮登录
            document.getElementById("loginButton").addEventListener("click", this.handleClick);

            //登录框中按回车登录
            document.getElementById("Login").addEventListener("keypress", this.handleKeypress);
        },

        onHide: function() {
            document.getElementById("Login").innerHTML = initialLoginModal;
            document.getElementById("loginButton").removeEventListener("click", this.handleClick);
            document.getElementById("Login").removeEventListener("keypress", this.handleKeypress);
        }
    }
}

//抢票活动申请单
function ticketModal() {
    var ticketSubmitBtn = document.getElementById("ticketSubmit");
    var form = document.forms.ticketForm;
    var editor;
    return {
        initEditor: function() {
            //Simditor 初始化
            editor = new Simditor({
                textarea: document.querySelector('#Ticket .content'),
                toolbarFloat: false,
                tabIndent: false,
                toolbar: [
                    'title', // 标题文字
                    'bold', // 加粗文字
                    'italic', // 斜体文字
                    'underline', // 下划线文字
                    'strikethrough', // 删除线文字
                    'color', // 修改文字颜色
                    'ol', // 有序列表
                    'ul', // 无序列表
                    'blockquote', // 引用
                    'table', // 表格
                    'link', // 插入链接
                    //'image'          ,// 插入图片
                    'hr', // 分割线
                    'indent', // 向右缩进
                    'outdent' // 向左缩进
                ]
            });
        },

        toggleChanceBtn: function(chance, times) {
            if (!chance || !times || chance == 100) {
                form.querySelector("#chance").textContent = "先到先得";
                form.querySelector("#chanceContainer").style.display = "none";
                form.querySelector("#chanceContainer input").value = "";
                form.querySelector("#timesContainer").style.display = "none";
                form.querySelector("#timesContainer input").value = "";
            } else {
                form.querySelector("#chance").textContent = "随机抢票";
                form.querySelector("#chanceContainer").style.display = "block";
                form.querySelector("#chanceContainer input").value = chance;
                form.querySelector("#timesContainer").style.display = "block";
                form.querySelector("#timesContainer input").value = times;
            }
        },

        handleSubmit: function(e) {
            e.preventDefault();
            var form = document.getElementById("ticketForm");
            var actID = form.dataset.actid || "";
            var name = form.querySelector("#name").value;
            var telephone = form.querySelector("#telephone").value;
            var content = editor.getValue();
            var chance = form.querySelector("#chanceContainer input").value;
            var total = form.querySelector("#total").value;
            var times = form.querySelector("#times").value;
            var startTime = form.querySelector("#startTime").value;
            var endTime = form.querySelector("#endTime").value;

            if (!times) {
                times = 1;
            }

            if (!name || !telephone || !content || !chance || !total || !startTime || !endTime) {
                alert('请填写所有信息');
                return false;
            }

            if (isNaN(telephone) || isNaN(total) || isNaN(times)) {
                alert('请填入数字');
                return false;
            }

            var data = {
                name: name,
                telephone: telephone,
                content: content,
                chance: chance,
                total: total,
                times: times,
                startTime: startTime,
                endTime: endTime,
                actID: actID
            };

            var ticketModal =  document.getElementById("Ticket");
            var request = new XMLHttpRequest();
            request.open("POST", "/cms/api/public/ticket?m=submit");
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            request.onreadystatechange = function() {
                if (request.readyState === 4 && request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    if (response.errno == 0) {
                        if (ticketSubmitBtn) {
                            ticketSubmitBtn.removeEventListener("click", this.handleSubmit);
                        }
                        ticketModal.getElementsByClassName("modal-body")[0].innerHTML = '<p class="text-success text-center">提交成功</p><p class="text-info text-center">可点击\'活动管理\'按钮查看申请进度</p>';
                        ticketModal.getElementsByClassName("modal-footer")[0].innerHTML = '<button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>';
                    } else {
                        alert(response.errmsg);
                    }
                }
            };
            request.send(encodeFormDate(data));
        },

        onShow: function(data) {
            this.initEditor();
            if (data) {
                form.setAttribute("data-actid", data.actID || "");
                form.querySelector("#name").value = data.name || "";
                form.querySelector("#telephone").value = data.telephone || "";
                editor.setValue(data.extra || data.content || "");
                this.toggleChanceBtn(data.chance, data.times);
                form.querySelector("#total").value = data.total || "";
                form.querySelector("#startTime").value = data.startTime? data.startTime.split(" ").join("T") : "";
                form.querySelector("#endTime").value = data.endTime? data.endTime.split(" ").join("T") : "";
            }
            //绑定按钮，提交抢票申请
            ticketSubmitBtn.addEventListener("click", this.handleSubmit);
            $("#rule1").on("click", function() {
                $("#chance").text("先到先得");
                document.querySelector("#chanceContainer input").value = 100;
                document.querySelector("#timesContainer input").value = 1;
                document.querySelector("#chanceContainer").style.display = "none";
                document.querySelector("#timesContainer").style.display = "none";
            });
            $("#rule2").on("click", function() {
                $("#chance").text("随机抢票");
                document.querySelector("#chanceContainer input").value = 0;
                document.querySelector("#timesContainer input").value = 1;
                document.querySelector("#timesContainer").style.display = "block";
                document.querySelector("#chanceContainer").style.display = "block";
            });
        },

        onHide: function() {
            document.getElementById("Ticket").innerHTML = initialTicketModal;
            initialTicketModalData = undefined;
            if (ticketSubmitBtn) {
                ticketSubmitBtn.removeEventListener("click", this.handleSubmit);
            }
        }
    }
}

//抢票管理
function ticketManagerModal() {
 
    return {
        handleVoucherInput: function(e) {
            document.getElementById("ExchangeBtn").disabled = false;
            //document.getElementById("ExchangeInfo").innerHTML = "";
        },

        handleKeypress: function(e) {
            if (e.keyCode === 13 && document.activeElement == document.getElementById("tele")) {
                e.preventDefault();
                triggerMouseEvent(document.getElementById("ManagerLoadBtn"), "click");
            }
        },

        handleQueryBtnClick: function(e) {
            var telephone = document.getElementById("tele").value;
            var request = new XMLHttpRequest();
            request.open("GET", '/cms/api/public/ticket?m=list&telephone=' + telephone);
            request.onreadystatechange = function() {
                if (request.readyState === 4 && request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    if (response.errno == 0) {
                        document.getElementById("Exchange").style.display = "block";
                        document.getElementById("ActSearch").style.display = "none";

                        var content = document.querySelector("#ticket-manager .content");
                        content.innerHTML = "";
                        document.querySelector("select#actID").innerHTML = "";
                        var list = response.data;
                        var length = list instanceof Array? list.length : 0;
                        if (length > 0) {
                            for (var i = 0; i < length; i++) {
                                var item = list[i];
                                var now = new Date();
                                var startTime = new Date(Date.parse(item.startTime.replace("-","/")));
                                var endTime = new Date(Date.parse(item.endTime.replace("-","/")));
                                var panel = document.createElement("div");
                                panel.classList.add("panel");
                                var panelStyle = endTime <= now? "panel-warning" : startTime <= now? "panel-success" : "panel-warning";
                                panel.classList.add(panelStyle);
                                panel.dataset.tele = telephone;

                                /*第二级DOM*/
                                var panelHeading = document.createElement("div");
                                panelHeading.classList.add("panel-heading");

                                var listGroup = document.createElement("ul");
                                listGroup.classList.add("list-group");

                                var panelBody = document.createElement("div");
                                panelBody.classList.add("panel-body");

                                /*第三级DOM*/
                                //heading
                                var name = document.createElement("span");
                                name.setAttribute("id", "getID");
                                name.dataset.id = item.actID;
                                name.textContent = item.name;
                                panelHeading.appendChild(name);

                                var label = document.createElement("span");
                                label.classList.add("label");
                                if (item.isPassed == 1) {
                                    label.classList.add("label-success");
                                    label.textContent = "审核通过";

                                    var temp = document.createElement("option");
                                    temp.setAttribute("value", item.actID);
                                    temp.textContent = item.name;
                                    document.querySelector("select#actID").appendChild(temp);
                                } else if (item.isPassed == 0) {
                                    label.classList.add("label-warning");
                                    label.textContent = "正在审核";
                                } else {
                                    label.classList.add("label-danger");
                                    label.textContent = "审核未通过";
                                }
                                label.style.marginLeft = "5px";
                                panelHeading.appendChild(label);

                                var btns = document.createElement("div");
                                btns.classList.add("list-btns");

                                var modifyBtn = document.createElement("button");
                                modifyBtn.setAttribute("type", "button");
                                modifyBtn.setAttribute("id", "ticket_modify");
                                modifyBtn.classList.add("modify");
                                modifyBtn.style.cssFloat = "right";
                                modifyBtn.onclick = ticketManagerModal().handleModifyBtnClick;

                                var modifyIcon = document.createElement("span");
                                modifyIcon.classList.add("glyphicon");
                                modifyIcon.classList.add("glyphicon-pencil");
                                modifyIcon.setAttribute("aria-hidden", true);
                                var txt = document.createTextNode("修改");
                                modifyBtn.appendChild(modifyIcon);
                                modifyBtn.appendChild(txt);

                                btns.appendChild(modifyBtn);
                                panelHeading.appendChild(btns);

                                panel.appendChild(panelHeading);

                                //body
                                if (endTime <= now || startTime <= now) {
                                    panelBody.innerHTML = '抢票人次<span class="label label-primary">' + item.count + '</span>\
                                    抢中人数<span class="label label-info">' + item.resultCount + '</span>\
                                    兑奖人数<span id="success-num" class="label label-success">' + item.usedCount + '</span>'
                                }

                                if (panelBody.hasChildNodes()) {
                                    panel.appendChild(panelBody);
                                }

                                //list-group
                                var tt = document.createElement("li"); //总票数
                                tt.textContent = "总票数：" + item.total;
                                tt.classList.add("list-group-item");
                                var method1 = document.createElement("li"); //抢票方式"先到先得"
                                method1.textContent = "先到先得";
                                method1.classList.add("list-group-item");
                                var tms = document.createElement("li"); //每人抢票次数
                                tms.textContent = "每人抢票次数：" + item.times;
                                tms.classList.add("list-group-item");
                                var chns = document.createElement("li"); //抢票概率
                                chns.textContent = "抢票概率：" + item.chance + "%";
                                chns.classList.add("list-group-item");
                                var stT = document.createElement("li");
                                stT.textContent = "开始时间：" + item.startTime;
                                stT.classList.add("list-group-item");
                                var eT = document.createElement("li");
                                eT.textContent = "结束时间：" + item.endTime;
                                eT.classList.add("list-group-item");

                                listGroup.appendChild(tt);
                                if (item.chance == "100") {
                                    listGroup.appendChild(method1);
                                } else {
                                    listGroup.appendChild(tms);
                                    listGroup.appendChild(chns);
                                }
                                listGroup.appendChild(stT);
                                listGroup.appendChild(eT);

                                panel.appendChild(listGroup);

                                content.appendChild(panel);
                            }
                        } else {
                            //空列表
                            content.innerHTML = '<p class="text-warning text-center">没有申请记录</p>';
                        }
                        content.style.display = "block";
                    } else {
                        alert(response.errmsg);
                    }
                }
            };
            request.send();
        },
        handleExchangeBtnClick: function(e) {
            $("#AssignSeatBtn").hide();
            $("#infoText").text("");
            $("#AssignSeatBtn").nextAll().remove();
            this.disabled = true;
            var token = document.getElementById("voucher").value;
            var actID = document.getElementById("actID").value;
            if (token.length != 12 || isNaN(token)) {
                $("#infoText").text("请输入正确的12位兑换码");
                //document.getElementById("ExchangeInfo").textContent = "请输入正确的12位兑换码";
                return;
            }
            var request = new XMLHttpRequest();
            request.open("POST", "/ticket/api/public/host?m=exchange");
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            var realname;
            var xmuId;
            var seat;
            request.onreadystatechange = function() {
                if (request.readyState === 4 && request.status == 200) {
                    var response = JSON.parse(request.responseText);
                    if (response.errno == 0 && response.data.isUsed==0) {

                        realname=response.data.realname==null||response.data.realname==""?"":"姓名："+response.data.realname;
                        xmuId=response.data.xmuId==null||response.data.xmuId==""?"":"学号："+response.data.xmuId;

                        $("#AssignSeatBtn").show();
                        $("#AssignSeatBtn").attr("data",""+response.data.logId+"");
                        $("#infoText").text("兑换成功！");
                        $("#AssignSeatBtn").after('<p>'+realname+' '+xmuId+' </p>');
                        //document.getElementById("ExchangeInfo").textContent = '您已兑换成功\n证件号码：' + response.data.realname+"  " + response.data.xmuId;
                        var num = document.getElementById("success-num").textContent;
                        num = parseInt(num) + 1;
                        document.getElementById("success-num").textContent = num;
                    } 
                    else if(response.errno==0 && response.data.isUsed==1){

                        realname=response.data.realname==null||response.data.realname==""?"":"姓名："+response.data.realname;
                        xmuId=response.data.xmuId==null||response.data.xmuId==""?"":"学号："+response.data.xmuId;
                        seat=response.data.seat==null||response.data.seat==""?"":"座位号:"+response.data.seat;

                        if(response.data.seat==""||response.data.seat==null){
                            $("#AssignSeatBtn").show();
                            $("#AssignSeatBtn").attr("data",""+response.data.logId+"");
                            
                        }else{
                            $("#AssignSeatBtn").hide();                     
                        }
                        $("#infoText").text("已兑换！");  
                        $("#AssignSeatBtn").after('<p>'+realname+' '+xmuId+'</p><span>'+seat+'</span>');
                    }
                    else {
                        
                        $("#infoText").text(""+response.errmsg+"");
                        $("#AssignSeatBtn").hide();
                        $("#AssignSeatBtn").nextAll().remove();

                        //$("#infoText").text(''+response.errmsg+'');
                        //document.getElementById("ExchangeInfo").textContent = response.errmsg;
                    }
                }
            };
            var data = {
                actID: actID,
                token: token
            };
            request.send(encodeFormDate(data));
        },

        handleModifyBtnClick: function(e) {
            var $panel = $(e.target).parents(".panel");
            var telephone = $panel.attr("data-tele");
            var actID = $panel.find("#getID").attr("data-id");
            var data;

            var request = new XMLHttpRequest();
            request.open("GET", '/cms/api/public/ticket?m=list&telephone=' + telephone);
            request.onreadystatechange = function() {
                if (request.readyState === 4 && request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    if (response.errno == 0) {
                        var list = response.data;
                        if (list instanceof Array && list.length > 0) {
                            for (var i = 0; i < list.length; i++) {
                                if (list[i].actID == actID) {
                                    data = list[i];
                                    break;
                                }
                            }
                        }
                        data.telephone = telephone;
                        initialTicketModalData = data;
                        $("#ticketSubmit").text("修改申请");
                        $("#TicketLabel").text("抢票修改申请");
                        $("#ticket-manager").modal("hide");
                        $("#Ticket").modal('show');
                    }
                }
            };
            request.send();

        },

        onShow: function() {
            //票据重新输入时启用按钮
            document.getElementById("voucher").addEventListener("input", this.handleVoucherInput);
            document.getElementById("ManagerLoadBtn").addEventListener("click", this.handleQueryBtnClick);
            document.getElementById("ExchangeBtn").addEventListener("click", this.handleExchangeBtnClick);
            document.getElementById("ticket-manager").addEventListener("keypress", this.handleKeypress);
        },

        onHide: function() {
            document.getElementById("ticket-manager").innerHTML = initialTicketManagerModal;
            document.getElementById("voucher").removeEventListener("input", this.handleVoucherInput)
            document.getElementById("ManagerLoadBtn").removeEventListener("click", this.handleQueryBtnClick);
            document.getElementById("ExchangeBtn").removeEventListener("click", this.handleExchangeBtnClick);
            document.getElementById("ticket-manager").removeEventListener("keypress", this.handleKeypress);
        }
    }
}

//扫码签到申请单
function rollcallModal() {
    var form = document.getElementById("RollcallForm");
    return {
        initEditor: function() {
            //Simditor 初始化
            editor2 = new Simditor({
                textarea: document.querySelector('#RollcallForm #act-content'),
                toolbarFloat: false,
                tabIndent: false,
                toolbar: [
                    'title', // 标题文字
                    'bold', // 加粗文字
                    'italic', // 斜体文字
                    'underline', // 下划线文字
                    'strikethrough', // 删除线文字
                    'color', // 修改文字颜色
                    'ol', // 有序列表
                    'ul', // 无序列表
                    'blockquote', // 引用
                    'table', // 表格
                    'link', // 插入链接
                    //'image'          ,// 插入图片
                    'hr', // 分割线
                    'indent', // 向右缩进
                    'outdent' // 向左缩进
                ]
            });
        },

        handleSubmit: function(e) {
            e.preventDefault();
            var data = {
                m: "submit",
                owner: form.querySelector("#student-id").value,
                name: form.querySelector("#name2").value,
                startTime: form.querySelector("#startTime2").value,
                endTime: form.querySelector("#endTime2").value,
                extra: editor2.getValue(),
                md5: form.getAttribute("data-md5") || "",
                award: form.querySelector("#award").value,
                limitConds: JSON.stringify({
                    grade: form.querySelector("#grade-limit-type").value + form.querySelector("#grade-limit-val").value
                })
            };

            //Ajax
            var request = new XMLHttpRequest();
            request.open("GET", "/cms/api/public/rollcall?" + encodeFormDate(data));
            request.onreadystatechange = function() {
                if (request.readyState === 4 && request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    if (response.errno == 0) {
                        document.getElementById("rollcall").getElementsByClassName("modal-body")[0].innerHTML = '<p class="text-success text-center">提交成功</p><p class="text-info text-center">可点击\'活动管理\'按钮查看申请进度</p>';
                        document.getElementById("rollcall").getElementsByClassName("modal-footer")[0].innerHTML = '<button typce="button" class="btn btn-warning" id="closeAfterSmt" data-dismiss="modal">关闭</button>';
                    } else {
                        alert(response.errmsg);
                    }
                }
            };
            request.send();
        },

        onShow: function(data) {
            this.initEditor();
            document.getElementById("rollcallSubmit").addEventListener("click", this.handleSubmit);

            //填充初始数据
            if (data) {
                form.querySelector("#name2").value = data.name || "";
                form.querySelector("#student-id").value = data.owner || "";
                editor2.setValue(data.extra || "");
                form.querySelector("#startTime2").value = data.startTime? data.startTime.split(" ").join("T") : "" || "";
                form.querySelector("#endTime2").value = data.endTime? data.endTime.split(" ").join("T") : "" || "";
                form.querySelector("#award").value = data.award || "";
                form.querySelector("#grade-limit-type").value = data.limitConds? (data.limitConds.grade)? (data.limitConds.grade).match(/[^0-9]+/)[0] : "" : "" || "";
                form.querySelector("#grade-limit-val").value = data.limitConds? (data.limitConds.grade)? (data.limitConds.grade).match(/[0-9]+/)[0] : "" : "" || "";
                form.setAttribute("data-md5", data.md5 || "");
            }
        },

        onHide: function() {
            document.getElementById("rollcall").innerHTML = initialRollcallModal;
            document.getElementById("rollcallSubmit").removeEventListener("click", this.handleSubmit);
        }
    }
}

function rollcallManagerModal() {
    return {
        handleQueryBtnClick: function() {
            var owner = document.getElementById("student-id2").value;
            var pwd = document.getElementById("password2").value;
            if (!owner || !pwd) {
                return;
            }
            var data = {
                m: "list",
                owner: owner,
                pwd: pwd
            };
            var request = new XMLHttpRequest();
            request.open("GET", "/cms/api/public/rollcall?" + encodeFormDate(data));
            request.onreadystatechange = function() {
                if (request.readyState === 4 && request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    if (response.errno == 0) {
                        var list = response.data;
                        var content = document.createElement("div");
                        content.classList.add("content");
                        var modalBody = document.getElementById("rollcall-manager").getElementsByClassName("modal-body")[0];
                        if (list && list instanceof Array && list.length > 0) {
                            for (var i = 0; i < list.length; i++) {
                                var item = list[i];
                                var style, state;
                                if (item.isPassed == 1) {
                                    style = "success";
                                    state = "审核通过";
                                } else if (item.isPassed == 0) {
                                    style = "warning";
                                    state = "待审核";
                                } else {
                                    style = "danger";
                                    state = "未通过";
                                }

                                var panel = document.createElement("a");
                                panel.classList.add("list-group-item");
                                panel.classList.add("list-group-item-" + style);
                                panel.setAttribute("id", item.id);
                                panel.dataset.md5 = item.md5;
                                panel.dataset.owner = owner;
                                panel.dataset.metadata = JSON.stringify(item);

                                var heading = document.createElement("p");
                                heading.classList.add("list-group-item-heading");
                                heading.textContent = item.name;

                                var label = document.createElement("span");
                                label.classList.add("label");
                                label.classList.add("label-" + style);
                                label.textContent = state;
                                label.style.marginLeft = "5px";
                                heading.appendChild(label);

                                var modifyBtn = document.createElement("button");
                                modifyBtn.setAttribute("type","button");
                                modifyBtn.classList.add("modify");
                                modifyBtn.innerHTML = "<span class='glyphicon glyphicon-pencil'></span> 修改";
                                modifyBtn.onclick = function(e) {
                                    var metadata = $(e.target).parents(".list-group-item")[0].dataset.metadata;
                                    if (!metadata) {
                                        alert("信息获取失败");
                                        return;
                                    }
                                    metadata = JSON.parse(metadata);
                                    metadata.owner = owner;
                                    initialRollcallModalData = metadata;
                                    $("#rollcallSubmit").text("修改申请");
                                    $("#rollcallLabel").text("扫码签到 修改申请");
                                    $("#rollcall-manager").modal("hide");
                                    $("#rollcall").modal("show");
                                };

                                var downloadBtn = document.createElement("button");
                                downloadBtn.setAttribute("type","button");
                                downloadBtn.classList.add("download");
                                downloadBtn.innerHTML = "<span class='glyphicon glyphicon-download-alt'></span> 下载";
                                downloadBtn.onclick = function(e) {
                                    e.stopPropagation();
                                    var metadata = $(e.target).parents(".list-group-item")[0].dataset.metadata;
                                    if (!metadata) {
                                        alert("信息获取失败");
                                        return;
                                    }
                                    metadata = JSON.parse(metadata);
                                    var md5 = metadata.md5;
                                    var request = new XMLHttpRequest();
                                    request.open("GET", "/cms/api/public/rollcall?m=download&act=" + md5);
                                    request.onreadystatechange = function() {
                                        if (request.readyState === 4 && request.status === 200) {
                                            window.open("/cms/api/public/rollcall?m=download&act=" + md5);
                                        }
                                    };
                                    request.send();
                                };

                                var toScanBtn = document.createElement("button");
                                toScanBtn.setAttribute("type","button");
                                toScanBtn.classList.add("toScan");
                                toScanBtn.innerHTML = "<span class='glyphicon glyphicon-eye-open'></span> 扫码";
                                toScanBtn.onclick = function(e) {
                                    e.preventDefault();
                                    e.stopPropagation();
                                    var metadata = $(e.target).parents(".list-group-item")[0].dataset.metadata;
                                    if (!metadata) {
                                        alert("信息获取失败");
                                        return;
                                    }
                                    metadata = JSON.parse(metadata);
                                    var md5 = metadata.md5;
                                    window.open("/rollcall?act=" + md5);
                                };

                                var buttons = document.createElement("div");
                                buttons.classList.add("list-btns");
                                buttons.setAttribute("role", "group");
                                buttons.appendChild(modifyBtn);
                                if (item.isPassed == 1) {
                                    buttons.appendChild(downloadBtn);
                                    buttons.appendChild(toScanBtn);
                                }

                                heading.appendChild(buttons);

                                var listGroup = document.createElement("ul");
                                listGroup.classList.add("list-group");
                                listGroup.dataset.id = item.id;

                                //list-group
                                var st = document.createElement("li");
                                st.textContent = "开始时间：" + item.startTime;
                                st.classList.add("list-group-item");
                                listGroup.appendChild(st);

                                var et = document.createElement("li");
                                et.textContent = "结束时间：" + item.endTime;
                                et.classList.add("list-group-item");
                                listGroup.appendChild(et);

                                var award = document.createElement("li");
                                award.textContent = "申请网薪：" + item.award;
                                award.classList.add("list-group-item");
                                listGroup.appendChild(award);

                                var gradeLimit = document.createElement("li");
                                gradeLimit.textContent = "年级限制：" + (item.limitConds? item.limitConds.grade : "");
                                gradeLimit.classList.add("list-group-item");
                                listGroup.appendChild(gradeLimit);

                                var extra = document.createElement("li");
                                extra.innerHTML = "详情：\n" + item.extra;
                                extra.classList.add("list-group-item");
                                listGroup.appendChild(extra);

                                panel.appendChild(heading);
                                content.appendChild(panel);
                                content.appendChild(listGroup);
                            }
                        } else {
                            content.innerHTML = '<p class="text-warning text-center">没有申请记录</p>';
                        }
                        modalBody.removeChild(modalBody.querySelector(".login-form"));
                        modalBody.appendChild(content);
                        document.getElementById("rollcall-manager").getElementsByClassName("modal-footer")[0].innerHTML = '<button type="button" class="btn btn-primary" id="log-out" style="float: right;" data-dismiss="modal">退出</button>';
                    } else {
                        alert(response.errmsg);
                    }
                }
            };
            request.send();
        },

        handleKeypress: function(e) {
            var self = this;
            if (self.getElementsByClassName("login-form") && self.getElementsByClassName("login-form").length > 0 && e.keyCode === 13) {
                e.preventDefault();
                triggerMouseEvent(document.getElementById("ManagerLoadBtn2"), "click");
            }
        },

        onShow: function() {
            document.getElementById("ManagerLoadBtn2").addEventListener("click", this.handleQueryBtnClick);
            document.getElementById("rollcall-manager").addEventListener("keypress", this.handleKeypress);
        },

        onHide: function() {
            document.getElementById("rollcall-manager").innerHTML = initialRollcallManagerModal;
            initialRollcallModalData = undefined;
            document.getElementById("ManagerLoadBtn2").removeEventListener("click", this.handleQueryBtnClick);
            document.getElementById("rollcall-manager").removeEventListener("keypress", this.handleKeypress);
        }
    }
}

//工具函数：动态触发点击事件
function triggerMouseEvent(elem, type) {
    var event;
    if (typeof elem != "object" || typeof type != "string") {
        return;
    }
    if (document.createEvent) {
        event = document.createEvent("MouseEvent");
        event.initEvent(type, false, true);
        event.eventName = type;
        elem.dispatchEvent(event);
    } else {
        event = document.createEventObject();
        event.eventType = type;
        event.eventName = type;
        elem.fireEvent("on" + type, event);
    }
}

//工具函数：把对象编码成表单请求格式
function encodeFormDate(data) {
    if (!data) return "";
    var pairs = [];
    for (var key in data) {
        if (!data.hasOwnProperty(key)) continue;
        if (typeof data[key] === "function") continue;
        var value = data[key].toString();
        var pair = encodeURIComponent(key.replace("%20", "+")) + "=" + encodeURIComponent(value.replace("%20", "+"));
        pairs.push(pair);
    }
    return pairs.join("&");
}

window.onload = function() {
    /*页面加载完毕，调整布局，绑定事件*/
    var apps;
    showcase().fixLayout();

    //点击页面下方图片，在展示框显示相应板块
    apps = document.getElementsByClassName("app");
    for (var i = 0; i < apps.length; i++) {
        var app = apps.item(i);
        app.index = i;
        app.addEventListener("click", function(e) {
            e.preventDefault();
            var i = e.currentTarget.index;
            showcase().swipe(i);
        });
    }
};

/***************************查询与兑换******************************************/
function query() {
    $.get(
        '/cms/api/public/mall?m=exchange1&token=' + $("input#exg-token").val(),
        function(data) {
            $("input#exg-token").hide();
            $("#queryBtn").hide();

            var response = $.parseJSON(data);
            if (response.errno == 0) {
                $("div#exg-response").empty()
                    .append('<p style="text-align:left;">学号：' + response.data.xmu_num + '</p>' + '<p style="text-align:left;">ID号：' + response.data.name + '</p>' + '<p style="text-align:left;">商品名称：' + response.data.itemsName + '</p>' + '<p class="logID" style="display:none;">' + response.data.logID + '</p>').show();
                $("#exchangeBtn").show();
            } else {
                $("div#exg-response").empty().append('<p class="warning" style="color:red; font-size:300%;">' + response.errmsg + '</p>').show();
                $("#closeBtn").show();
            }
        }
    );
}

function exchange(e) {
    $("#exchangeBtn").hide();
    $.get(
        '/cms/api/public/mall?m=exchange2&logID=' + $(e).parents("#exchangeModal").find('p.logID').text(),
        function(data) {
            var response = $.parseJSON(data);
            if (response.errno == 0) {
                $("div#exg-response").empty().append('<p class="warning" style="color:red; font-size:300%;">' + "兑换成功！" + '</p>').show();
                $("#closeBtn").show();
            } else {
                $("div#exg-response").empty().append('<p class="warning" style="color:red; font-size:300%;">' + response.errmsg + '</p>').show();
                $("#closeBtn").show();
            }
        }
    );
}

$('#exchangeModal').on('hidden.bs.modal', function(e) {
    $("input#exg-token").val("").show();
    $("#exg-response").empty().hide();
    $("#queryBtn").show().siblings('button').hide();
});

