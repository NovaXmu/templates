var React = require('react');
var Api = require("../utils/api");
var Modal = require("./Modal");
var HorizontalForm = require("./HorizontalForm");
var ContentEditable = require("./ContentEditable");

module.exports = React.createClass({

  getInitialState: function() {
    return {
      editMode: false,
      picUrl: this.props.picUrl,
      showModal: false,
      showDelConfirmModal: false,
      name: this.props.name,
      amount: this.props.amount || 0,
      price: this.props.price || 0,
      scale: this.props.scale || "",
      remark: this.props.remark || ""
    };
  },
  render: function() {
    var picModal = <Modal isOpen={this.state.showModal} onRequestClose={this.closeModal}>
      <img className="pic-show" src={this.state.picUrl} />
    </Modal>

    var delConfirmModal = <Modal isOpen={this.state.showDelConfirmModal}>
      <p>确定要从数据库里删除该物品相关的所有信息吗？</p>
      <div className="btn-wrap">
        <button onClick={this.delete}>确定</button>
        <button onClick={this.closeDelConfirmModal}>取消</button>
      </div>
    </Modal>

    return <li className="val-item">
      <div className="body clearfix">
        {this.renderPicture()}
        {this.renderInfo()}
      </div>
      {this.renderFooter()}
      {picModal}
      {delConfirmModal}
    </li>
  },

  closeModal: function() {
    this.setState({
      showModal: false
    })
  },

  closeDelConfirmModal: function(evt) {
    evt.preventDefault();
    this.setState({
      showDelConfirmModal: false
    })
  },

  openDelConfirmModal: function(evt) {
    
    this.setState({
      showDelConfirmModal: true
    })
  },

  renderInfo: function() {
    if (!this.state.editMode) {
      return <div className="info">
        <h3>{this.state.name || "未命名"}</h3>
        <p><label>数量</label><em>{this.state.amount}</em></p>
        <p><label>价格</label><em>{this.state.price}</em></p>
        <p><label>规格</label><em>{this.state.scale}</em></p>
        <p><label>备注</label><em>{this.state.remark}</em></p>
      </div>
    } else {
      return <div className="info">
        <h3>
          <ContentEditable html={this.state.name} onChange={this.onNameEdit} />
        </h3>
        <div><label>数量</label><ContentEditable html={this.state.amount} onChange={this.onAmountEdit} /></div>
        <div><label>价格</label><ContentEditable html={this.state.price} onChange={this.onPriceEdit} /></div>
        <div><label>规格</label><ContentEditable html={this.state.scale} onChange={this.onScaleEdit} /></div>
        <div><label>备注</label><ContentEditable html={this.state.remark} onChange={this.onRemarkEdit} /></div>
      </div>
    }
  },

  onNameEdit: function(evt) {
    this.setState({
      name: evt.target.value
    })
  },

  onAmountEdit: function(evt) {
    this.setState({
      amount: evt.target.value
    })
  },

  onPriceEdit: function(evt) {
    this.setState({
      price: evt.target.value
    })
  },

  onScaleEdit: function(evt) {
    this.setState({
      scale: evt.target.value
    })
  },

  onRemarkEdit: function(evt) {
    this.setState({
      remark: evt.target.value
    })
  },

  renderFooter: function() {
    var btns;

    if (this.state.editMode) {
      btns = <div className="btn-wrap">
        <button onClick={this.modify}>提交</button>
        <button onClick={this.dontEdit}>取消</button>
      </div>
    } else {
      btns = <div className="btn-wrap">
        <button onClick={this.toEdit}>修改</button>
        <button onClick={this.openDelConfirmModal}>删除</button>
      </div>
    }

    return <div className="footer">
      {btns}
    </div>
  },

  toEdit: function() {
    this.setState({
      editMode: true
    })
  },

  dontEdit: function() {
    this.setState(this.getInitialState())
  },

  renderPicture: function() {
    var style = {
      backgroundImage: "url('" + this.state.picUrl + "')"
    }
    return <div className="pic" style={this.state.picUrl ? style : null}  onClick={this.onImgClick}></div>
  },

  modify: function() {
    var data = {
      id: this.props.id,
      name: this.state.name,
      price: this.state.price,
      amount: this.state.amount,
      scale: this.state.scale,
      remark: this.state.remark
    }
    Api.post("api/admin/item", {m: "modifyValuables"}, data, function(json) {
      if (json.errno == 0) {
        alert("提交成功！");
        this.setState({
          editMode: false
        })
      } else {
        alert(json.ermsg)
      }
    }.bind(this))
  },

  delete: function() {
    var data = {
      id: this.props.id,
      deleted: 1
    }
    Api.post("api/admin/item", {m: "modifyValuables"}, data, function(json) {
      if (json.errno == 0) {
        alert("物品删除成功");
        this.setState({
          editMode: false,
          showDelConfirmModal: false
        })
        this.props.onItemUpdated()
      } else {
        alert(json.ermsg)
      }
    }.bind(this))
  },

  onImgClick: function() {
    if ( this.state.editMode ) {
      wx.chooseImage({
        count: 1, // 默认9
        sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
        success: function (res) {
          var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
          wx.uploadImage({
              localId: localIds[0], // 需要上传的图片的本地ID，由chooseImage接口获得
              isShowProgressTips: 1, // 默认为1，显示进度提示
              success: function (res) {
                  var serverId = res.serverId; // 返回图片的服务器端ID
                  var data = {
                    item_id: this.props.id,
                    media_id: serverId,
                    type: "valuables"
                  }
                  
                  Api.post("api/admin/item", {m: "picFromWechat"}, data, function(json) {
                    if ( json.errno == 0 ) {
                      alert("上传成功");
                      //Actions.getItemsInCategory();
                      if ( this.state.picUrl ) {
                        this.setState({
                          picUrl: this.state.picUrl + "?v=" + new Date().valueOf()
                        })
                      }
                    } else {
                      alert( json.errmsg );
                    }
                  }.bind(this))
              }.bind(this)
          });
        }.bind(this)
      });
    } else {
      if ( this.state.picUrl ) {
        this.setState({
          showModal: !this.state.showModal
        })
      }
    }
  }
})