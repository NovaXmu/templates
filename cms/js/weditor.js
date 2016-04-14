(function(root, factory) {
  root['Weditor'] = factory(jQuery);
}(this, function($) {

  var Text = function() {
    this.type = 'text';
    this.pluginText = '文本消息';
    this._connected = false;

    this._tpl = "<textarea class=\"form-control\" rows=\"10\"></textarea>";

    this._render = function(_body) {
      this.container = _body.html(this._tpl).find('textarea');
    };

    this.setContent = function(_content) {
      this.container.val(_content['Content']);
    };

    this.getContent = function() {
      var result = {
        'Content': this.container.val()
      }
      return result;
    };

  };

  var News = function() {
    this.type = 'news';
    this.pluginText = '图文消息';
    this._connected = false;

    this._default = {
      "Title": "标题",
      "Description": " 描述",
      "PicUrl": "图片链接",
      "Url": "跳转链接",
    }

    this._tpl = "<ul class=\"list-group\"></ul>";
    this._item = "<li class=\"list-group-item\"><label></label><input class=\"form-control\" type=\"text\"></li>";
    this._addBtn = "<button class=\"btn btn-info btn-sm\" type=\"button\" style=\"float: right;margin-top: 10px;\">新增一条</button>";

    this._render = function(_body) {
      this.container = _body.html('');
      this.container.append($(this._addBtn).on('click', (function(_this) {
        return function() {
          return _this.addItem(); //点击添加新项
        }
      })(this)));
      this.bottom = this.container.find('button'); //默认只有一个按钮
    };

    this.addItem = function() {
      var index = this.container.find('ul').length + 1;
      if (index > 10) {
        alert('最多添加十条图文信息');
        return false;
      };

      var item = $(this._tpl).html('<li><label>第' + index + '条</label></li>');
      item.find('li').append($('<button/>', { //删除按钮
        class: 'close',
        html: '<span >&times;</span>'
      }).on('click', function() {
        var body = $(this).closest('.weditor-body');
        $(this).closest('ul').hide();
        $(this).closest('ul').remove();
        body.find('ul').each(function(index) {
          $(this).find('li:first label').text('第' + (index + 1) + '条'); //更新消息序号
        })
      }));
      var flag = arguments.length == 1 ? true : false; //检查是否需要放置内容
      for (var key in this._default) {
        var temp = $(this._item);
        temp.find('label').text(this._default[key]);
        temp.find('input').attr('placeholder', key);
        if (flag) {
          temp.find('input').val(arguments[0][key]);
        };
        item.append(temp);
      }
      item.insertBefore(this.bottom);
    }

    this.setContent = function(_content) {
      var articles = _content['Articles'];
      for (i in articles) {
        this.addItem(articles[i]);
      }
    };

    this.getContent = function() {
      var result = {
        'Articles': []
      };
      this.container.find('ul').each(function() {
        var temp = new Object();
        $(this).find('input').each(function() {
          temp[$(this).attr('placeholder')] = $(this).val();
        })
        result['Articles'].push(temp);
      });
      return result;
    };
  };

  var Weditor = function(_opts) {

    Weditor.count = 0;

    Weditor.prototype.opts = {
      area: null,
      type: 'text',
      content: ''
    };

    Weditor.prototype._init = function() {
      var editor, type;
      this.opts = $.extend({}, this.opts, _opts);
      this.area = $(this.opts.area);
      if (typeof this.area != 'object') {
        throw new Error('weditor: param area is required.');
        return;
      }

      this.id = ++Weditor.count;

      this._render();
      this.setType(this.opts.type);
      this.container.setContent(this.opts.content);
    };

    Weditor.prototype._mainTpl = "<div class=\"weditor\">\n <div class=\"row weditor-head \" style=\"width: 50%;margin-bottom: 20px;\"></div>\n <div class=\"row weditor-body\"></div>\n <div class=\"row weditor-foot\"></div>\n </div>";

    Weditor.prototype._render = function() {
      this.el = $(this._mainTpl).insertBefore(this.area);
      this.head = this.el.find('.weditor-head');
      this.body = this.el.find('.weditor-body');
      this.foot = this.el.find('.weditor-foot');
      this.area.data('weditor', this).hide();

      this._selectRender();
    };

    Weditor.prototype._selectTpl = "<select class=\"form-control\"></select>";

    Weditor.prototype._selectRender = function() {
      var selectTpl = $(this._selectTpl).on('change', (function(_this) {
        return function() {
          _this.setType(_this.select.val());
        };
      })(this));
      for (var i in this._connectedClasses) {
        selectTpl.append($('<option/>', {
          text: this._connectedClasses[i].pluginText,
          value: this._connectedClasses[i].type
        }));
      }
      this.head.append(selectTpl);
      this.select = selectTpl;
    };

    Weditor.prototype.setType = function(_type) {
      var plugin;
      if (typeof this._connectedClasses[_type] == 'undefine') {
        throw new Error('Weditor.select: cannot select unknown type');
        return;
      };
      plugin = this[_type];
      plugin._render(this.body);
      this.select.val(_type);
      this.container = plugin;
    };

    Weditor.prototype.getType = function() {
      return this.container.type;
    };

    Weditor.prototype.setContent = function(_content) {
      var content = jQuery.parseJSON(_content);
      return this.container.setContent(content);
    };

    Weditor.prototype.getContent = function() {
      return this.container.getContent();
    };

    Weditor.prototype.addButton = function(button) {
      return this.foot.append(button);
    };

    Weditor.prototype.connect = function(cls) {
      if (typeof cls !== 'function') {
        return;
      }
      cls = new cls();
      if (!cls.type) {
        throw new Error('Weditor.connect: cannot connect plugin without type');
        return;
      }
      cls._connected = true;
      if (!this._connectedClasses) {
        this._connectedClasses = [];
      }
      this._connectedClasses.push(cls);
      if (cls.type) {
        return this[cls.type] = cls;
      }
    };

    this.connect(Text);

    this.connect(News);

    this._init();
  };


  return Weditor;
}));
