var React = require('react');
var Api = require('../utils/api');

module.exports = React.createClass({

  getInitialState: function() {
    return {
      return_amount: 1      
    };
  },

  render: function() {
    var backTime = this.props.back_time ? (<div className="back_time">
        <label>应归还时间：</label>
        {this.props.back_time}
      </div>) : null;
    return <li className={"order-item clearfix " + ( this.props.i_type == 0 ? "take " : "borrow " ) }>
      <div className="name">{this.props.i_name}</div>
      <div className="apply_amount"><label>请求数量：</label>{this.props.apply_amount || 0}</div>
      <div className="real_amount"><label>通过数量：</label>{this.props.real_amount == 0 ? this.props.apply_amount : this.props.real_amount}</div>
      <div className="room"><label>仓库：</label>{this.props.i_room}</div>
      <div className="location"><label>位置：</label>{this.props.i_location}</div>
      {backTime}
      {this.renderFooter()}
    </li>
  },

  return: function() {
    var data = {
      item_id: this.props.item_id,
      order_num: this.props.order_num,
      back_amount: this.state.return_amount
    }
    Api.post("api/admin/order", {m: "returnItem"}, data, function(json) {
      if (json.errno == 0)  {
        this.props.onItemUpdated();
      } else {
        alert(json.errmsg);
      }
    }.bind(this))
  },

  renderFooter: function() {
    if (this.props.orderType == "borrow" && this.props.dealt == "1" && this.props.borrowingInfo) {
      if (this.props.borrowingInfo[this.props.item_id]) {
        var info = this.props.borrowingInfo[this.props.item_id];
        return <div className="return-manager">
          <label>已归还数量：</label>
          {info.back_amount + " (" + info.back_time.substr(0,10) + ")"}
        </div>
      } else {
        return <div className="return-manager">
          <div className="to-return">
            <input type="number" value={this.state.return_amount} onChange={this.hanldeReturnAmountChange}/>个
            <button onClick={this.return}>归还</button>
          </div>
        </div>
      }
    } 
  },

  hanldeReturnAmountChange: function(evt) {
    this.setState({
      return_amount: evt.target.value
    })
  }
})