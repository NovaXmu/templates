var React = require('react');
var Api = require('../../utils/api')
var Action = require('../../action');


module.exports = React.createClass({

  getInitialState: function() {
    return {
       confirmMode: false   
    };
  },
  render: function() {
    var result = this.props.result != 1 ? (<div>
        <p>剩余可抢次数：{this.props.leftTimes}</p>
      </div>) : (<div>
        <p>兑换密钥：{this.formatToken(this.props.accessToken)}</p>
        <p>是否已兑换：{this.props.isUsed == 0 ? "否" : "是"}</p>
        <p>{this.state.confirmMode ? (<button className="confirm-btn" onClick={this.returnTicket}>再次点击，确认退票</button>) : (<button onClick={this.confirmReturn}>退票</button>)}</p>
      </div>)
    return <div className={"record-item " + (this.props.result != 1 ? "failure" : "success")}>
      <time>{this.props.time}</time>
      <header>{this.props.result == -1 ? "抢票失败" : (this.props.result == 1 ? "抢票成功" : "已退票")}</header>
      <h3>{this.props.name}</h3>
      {result}
    </div>
  },

  formatToken: function(t) {
    if (!t) return "无";
    return t.substr(0,4) + " " + t.substr(4,4) + " " + t.substr(8,4) + " " + t.substr(12, 4);
  },

  returnTicket: function(evt) {
    evt.stopPropagation();
    Api.post("api/user/participant", {m: "returnTicket"}, {log_id: this.props.id}, function(json) {
      if (json.errno == 0) {
        alert("已成功退票")
        Action.getRecords();
      } else {
        alert(json.errmsg);
      }
    }.bind(this))
    this.setState({
      confirmMode: false
    })
  },

  confirmReturn: function() {
    this.setState({
      confirmMode: true
    })
  }
})