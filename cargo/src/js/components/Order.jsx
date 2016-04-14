var React = require("react");
var UndealtOrderItem = require("./UndealtOrderItem");
var DealtOrderItem = require("./DealtOrderItem");
var Api = require("../utils/api");

module.exports = React.createClass({

  getInitialState: function() {
    return {
      show: false,
      items: [],
      modified: false ,
      borrowingInfo: {} 
    }
  },

  componentWillUpdate: function(nextProps, nextState) {
    if (this.props.order_type != nextProps.order_type || this.props.dealt != nextProps.dealt) {
      this.setState({
        show: false
      })
    }
  },

  getItems: function(orderNum) {
    Api.get("api/admin/order", {m: "getOrderDetail", orderNum: orderNum}, function(json) {
      if ( json.errno == 0 ) {
        this.setState({
          items: json.data,
          show: true
        })
      } else {
        alert(json.errmsg)
      }
    }.bind(this))

    if (this.props.order_type == "borrow") {
      Api.post("api/admin/order", {m: "getToBeReturnOrderList"}, {order_num: this.props.order_num}, function(json) {
        if (json.errno == 0) {
          this.setState({
            borrowingInfo: json.data
          })
        } else {
          alert(json.errmsg);
        }
      }.bind(this))
    }
  },

  render: function() {
    var content = this.state.show ? (<div className="order-content">
        <ul>{this.renderItems()}</ul>
        <p className="remark">{"备注：" + this.props.remark}</p>
        <div className="footer">
          {this.renderFooter()}
        </div>
      </div>) : null;
    var dealStateClass = this.props.dealt == 0 ? "undealt" : (this.props.dealt == 1 ? "accepted" : "refused");
    return <div className={"order " + dealStateClass + " " + (this.state.show ? "show" : "")} data-num={this.props.order_num}>
      <div className="header clearfix" onClick={this.handleHeaderClicked}>
        <h2 className="user">{this.props.u_name}</h2>
        <time>{this.props.dealt == 0 ? this.props.create_time : this.props.deal_time}</time>
      </div>
      {content}
    </div>
  },

  renderItems: function() {
    if (this.props.dealt == 0) {
      //未处理
      return this.state.items.map(function(item,i) {
        return <UndealtOrderItem {...item} key={i} orderType={this.props.order_type} onItemUpdated={this.afterSomeItemChange} afterModified={this.afterSomeItemModified}/>
      }.bind(this))
    } else {
      //已处理
      return this.state.items.map(function(item,i) {
        return <DealtOrderItem {...item} key={i} orderType={this.props.order_type} dealt={this.props.dealt} borrowingInfo={this.state.borrowingInfo} onItemUpdated={this.afterSomeItemChange}/>
      }.bind(this))
    }
  },

  afterSomeItemChange: function() {
    this.getItems(this.props.order_num)
  },

  afterSomeItemModified: function(modified) {
    this.setState({
      modified: modified
    })
  },

  renderFooter: function() {
    var dealBtns = (<div className="btn-wrap deal-btns">
        <button className="accept" onClick={this.accept}>通过</button>
        <button className="refuse" onClick={this.refuse}>拒绝</button>
      </div>)

   /* var saveBtns = (<div className="btn-wrap save-btns">
        <button className="accept">保存修改</button>
        <button className="refuse">重置</button>
      </div>)*/
    return <div className="footer">
      {this.props.dealt == 0 ? dealBtns : null}
    </div>;
  },

  accept: function(evt) {
    if (this.state.modified) {
      alert("还有已修改的数据没保存呐");
      return;
    }

    var data = {
      orderNum: this.props.order_num,
      deal: 1
    }
    Api.post("api/admin/order", {m: "deal"}, data, function(json) {
      if (json.errno == 0) {
        alert("订单已通过");
        this.props.onOrderDealt();
        this.setState({
          show: false
        })
      } else {
        alert(json.errmsg);
      }
    }.bind(this))
  },

  refuse: function(evt) {
    if (this.state.modified) {
      alert("还有已修改的数据没保存呐");
      return;
    }

    var data = {
      orderNum: this.props.order_num,
      deal: -1
    }
    Api.post("api/admin/order", {m: "deal"}, data, function(json) {
      if (json.errno == 0) {
        alert("订单已拒绝");
        this.props.onOrderDealt()
        this.setState({
          show: false
        })
      } else {
        alert(json.errmsg);
      }
    }.bind(this))
  },

  handleHeaderClicked: function(evt) {
    if (this.state.show) {
      this.toggleContent()
    } else {
      this.getItems(this.props.order_num)
    }
  },

  toggleContent: function() {
    this.setState({
      show: !this.state.show
    })
  }
})