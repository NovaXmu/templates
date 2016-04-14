/**
 * Created by zhanz on 2015/11/10.
 */

var list = new List();

window.onload = function() {
    list.render();
};

function List() {
    try {
        this.data = JSON.parse(localStorage.getItem("yourToDoListData"));
        if ( isArray(this.data) ) {
            this.data = this.data.filter(function(elem) {
                return elem != undefined;
            });
        } else {
            localStorage.setItem("yourToDoListData", "[]");
            this.data = [];
        }
    } catch(e) {
        localStorage.setItem("yourToDoListData", "[]");
        this.data = [];
    }
    this.options = {
        hideTheDone: false
    };
    this.getData = function() {
        return this.data;
    };
    this.render = function() {
        var _data = this.data;
        if ( this.options.hideTheDone ) {
            _data = _data.filter(function(elem) {
                return !elem.done;
            });
        }
        var ul = document.querySelector("#list ul");
        ul.innerHTML = "";
        if ( _data && _data.length > 0 ) {
            for ( var i = 0; i < _data.length; i++ ) {
                var item = makeItem(_data[i]);
                ul.appendChild(item);
            }
        } else {
            ul.innerHTML = "<h1 class='msg'>Seems like you have nothing to do currently. Try adding a plan now.</h1>";
        }
    };
    this.update = function(data) {
        this.data = data;
        localStorage.setItem("yourToDoListData", JSON.stringify(data));
    };
    this.clear = function() {
        this.data = [];
        localStorage.setItem("yourToDoListData", "[]");
    };
    this.contains = function(time) {
        for ( var i = 0; i < this.data.length; i++ ) {
            if ( this.data[i].time == time ) {
                return true;
            }
        }
        return false;
    }
}

function makeItem(data) {
    if ( !data ) return;
    var state = data.done? "done": "";
    var li = newElement("li", state);
    li.dataset.time = data.time || "";
    var checkBox = newElement("div", "checkbox");
    var content = newElement("div", "content");
    var cap = newElement("h3", "cap");
    cap.innerHTML = data.title;
    var info = newElement("p", "info");
    info.innerHTML = data.desc;
    content.appendChild(cap);
    content.appendChild(info);
    var ops = newElement("div", "ops");
    var deleteBtn = newElement("button", "delete");
    ops.appendChild(deleteBtn);

    li.appendChild(checkBox);
    li.appendChild(content);
    li.appendChild(ops);

    return li;
}

function deleteItem(time) {
    var listData = list.getData();
    listData = listData.filter(function(item) {
        return item.time != time;
    });
    list.update(listData);
    list.render();
}

function createNewItem() {
    var title = document.querySelector("#title").value;
    var desc = document.querySelector("#desc").value;
    var time = new Date().valueOf();
    if ( !title ) {
        var notice = new Notice(document.getElementById("notice"), "Please at least enter the title.");
        notice.setResult("bad");
        notice.show();
        setTimeout(function() {
            notice.hide();
        }, 2000);
        return false;
    }
    if ( title.length > 50 ) {
        notice = new Notice(document.getElementById("notice"), "Title too long!");
        notice.setResult("bad");
        notice.show();
        setTimeout(function() {
            notice.hide();
        }, 2000);
        return false;
    }
    var newItem = {
        title: title,
        desc: desc,
        time: time,
        done: false
    };
    var listData = list.getData();
    if (  listData ) {
        listData.unshift(newItem);
        list.update(listData);
        list.render();
    } else {
        notice = new Notice(document.getElementById("notice"), "Oops! Something went wrong...");
        notice.setResult("bad");
        notice.show();
        setTimeout(function() {
            notice.hide();
        }, 1500);
    }
    toggleCreate(true);
}

function toggleDone(time) {
    var listData = list.getData();
    listData = listData.map(function(elem) {
        if ( elem.time == time ) {
            elem.done = !elem.done;
        }
        return elem;
    });
    list.update(listData);
    list.render();
}

function toggleCreate(back) {
    if (back) {
        $("#create-form").fadeToggle("fast",function() {
            $("#create").find("span").fadeToggle().end().find("input").val("");
        });
    } else {
        $("#create").find("span").fadeToggle("fast",function() {
            $("#create-form").fadeToggle();
        });
    }
}

function importData(json) {
    try {
        var data = JSON.parse(json);
    } catch(e) {
        var notice = new Notice(document.getElementById("notice"), "Invalid data");
        notice.setResult("bad");
        notice.show();
        setTimeout(function() {
            notice.hide();
        }, 2000);
        return false;
    }
    if ( isArray(data) ) {
        data = data.filter(function(elem) {
            return !list.contains(elem.time);
        });
        list.update(list.data.concat(data));
        list.render();
    }
}

$("#create").find("span").on("click", function(e) {
    e.preventDefault();
    toggleCreate(false);
});
$("#add-btn").on("click", function(e) {
    e.preventDefault();
    createNewItem();
});
$("#cancel-btn").on("click", function(e) {
    e.preventDefault();
    toggleCreate(true);
});
$("body").on("click", ".delete", function() {
    var time = $(this).parents("li").data("time");
    if ( time && confirm("Are you sure to delete this item?")) {
        deleteItem(time);
    }
});
$("body").on("click", ".checkbox", function() {
    var time = $(this).parents("li").data("time");
    if ( time ) {
        toggleDone(time);
    }
});
$("#filter").on("click", function () {
    $(this).toggleClass("pressed");
    list.options.hideTheDone = $(this).hasClass("pressed");
    list.render();
});
$("#import").on("click", function() {
    $("#cover").addClass("show");
    $("#modal").find("h2").text("Paste Data:").end().find("textarea").val("").end().find("button:first-child").show().end().addClass("show");
});
$("#export").on("click", function() {
    $("#cover").addClass("show");
    $("#modal").find("h2").text("Copy Data:").end().find("textarea").val(JSON.stringify(list.getData())).select().end().find("button:first-child").hide().end().addClass("show");
});
$("#modal").find("button:last-child").on("click", function() {
    $("#cover").removeClass("show");
    $("#modal").removeClass("show");
}).find("button:first-child").on("click", function () {
    importData($("#modal").find("textarea").val());
    $("#cover").removeClass("show");
    $("#modal").removeClass("show");
});
$("#clear").on("click", function() {
    if ( confirm("Are you sure to clear everything in the list?") ) {
        list.clear();
        list.render();
    }
});

function Notice(elem, msg) {
    elem.innerHTML = msg;
    this.setResult = function(str) {
        removeClass(elem, "good");
        removeClass(elem, "bad");
        addClass(elem, str);
    };
    this.show = function() {
        addClass(elem, "show");
    };
    this.hide = function() {
        removeClass(elem, "show");
        elem.className = "";
    };
}


function newElement(tagName, classes) {
    var elem = document.createElement(tagName);
    if ( classes ) {
        elem.className = classes;
    }
    return elem;
}

function isArray(obj) {
    if (obj) {
        return Object.prototype.toString.call(obj) === "[object Array]";
    }
    return false;
}


function removeClass(elem, classN) {
    elem.className = elem.className.replace(new RegExp("(?:^|\\s)"+ classN +"(?!\\S)"), '' );
}

function addClass(elem, classN) {
    elem.className = elem.className.concat(" " + classN);
}

