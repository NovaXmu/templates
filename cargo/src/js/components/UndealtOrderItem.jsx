var React = require("react");
var Op = require("./Op");
var Reflux = require("reflux");
var HorizontalForm = require("./HorizontalForm");
var StockInNew = require("./StockInNew");
var Actions = require("../actions");
var Api = require("../utils/api");
var CategoryStore = require("../stores/category-store");
var Reflux = require("reflux");
var moment = require("moment");
var DatePicker = require("react-datepicker");

/*
 *老物品，新物品
 *已处理，未处理
 *已通过，未通过
 *已归还，未归还
 *申领，借用，补购
*/

module.exports = React.createClass({

  mixins: [
    Reflux.listenTo(CategoryStore, "onGotCategories")
  ],

  getInitialState: function() {
      return {
        remain: this.props.i_amount ? this.props.i_amount : 0,
        modified: false,
        real_amount: this.props.real_amount > 0 ? this.props.real_amount : this.props.apply_amount,
        back_time: this.props.back_time,
        creatingModeItemType: -1,
        creatingModeCategoryOptions: []
      }
  },

  componentWillUpdate: function(nextProps, nextState) {
    if (this.state.creatingModeItemType != nextState.creatingModeItemType) {
      Actions.getCategories(nextState.creatingModeItemType);
    }
  },

  componentDidUpdate: function(prevProps, prevState) {
    if (this.state.modified != prevState.modified) {
      this.props.afterModified(this.state.modified);
    }
  },

  render: function() {
    return <li className={"order-item clearfix " + ( this.props.i_type == 0 ? "take " : "borrow " ) }>
      {this.props.item_id <= 0 ? this.renderCreateNew() : this.renderOld()}
    </li>
  },

  renderOld: function() {
    return <div className="old-item">
      <div className="name">{ (this.state.modified ? "*" : "") + (this.props.item_id <= 0 ? this.props.item_name : this.props.i_name) }</div>
      <div className="remain">{"剩余数量：" + this.state.remain}</div>
      <div className="op">
        <section data-type="amount">
          请求数量
          <Op min={0} max={Number(this.state.remain) + Number(this.state.real_amount)} style={"input"} num={this.state.real_amount} onNumChange={this.onAmountChange} />
        </section>
      </div>
      <div className="extra">
        {this.props.i_type == 1 ? this.renderBorrowDaysOp() : null} 
      </div>
      {this.renderFooter()}
    </div>
  },

  renderBorrowDaysOp: function() {
    return <section data-type="days">
      归还日期
      <DatePicker selected={moment(this.state.back_time)} onChange={this.onBackTimeChange} />
    </section>
  },

  onBackTimeChange: function(date) {
    this.setState({
      back_time: date.format("YYYY-MM-DD"),
      modified: true
    })
  },

  onAmountChange: function(num) {
    var remain = this.state.remain - (num - this.state.real_amount);
    this.setState({
      real_amount: num,
      modified: true,
      remain: remain
    })
  },

  renderFooter: function() {
    var footer = this.state.modified ? (<div className="item-footer btn-wrap">
      <button onClick={this.save}>保存修改</button>
      <button onClick={this.reset}>重置</button>
    </div>) : null;
    return footer;
  },

  save: function(evt) {
    var data = {
      orderNum: this.props.order_num,
      itemId: this.props.item_id,
      realAmount: this.state.real_amount,
      back_time: this.state.back_time || ""
    }
    Api.post("api/admin/order", {m: "modify"}, data, function(json) {
      if (json.errno == 0) {
        this.setState({
          modified: false
        })
      } else {
        alert(json.errmsg);
      }
    }.bind(this))
  },

  reset: function() {
    this.setState(this.getInitialState())
  },

  renderCreateNew: function() {
    var basicFormRows = [
      {
        label: "申请模式",
        type: "select",
        placeholder: {
          value: "-1",
          text: "请选择"
        },
        options: [
          {
            value: 0,
            text: "申领"
          },
          {
            value: 1,
            text: "借用"
          }
        ],
        properties: {
          value: this.state.creatingModeItemType == -1 ? "-1" : this.state.creatingModeItemType
        },
        handleChange: function(evt) {
          this.setState({
            creatingModeItemType: evt.target.value 
          });
          
        }.bind(this)
      }
    ];
    
    return <div className="create-new">
      <h3>请求物品不存在，请先在数据库中录入相关信息</h3>
      <HorizontalForm rows={basicFormRows} flexRatio={2} />
      <StockInNew type={this.state.creatingModeItemType} 
                  categories={this.state.creatingModeCategoryOptions}
                  initialName={this.props.item_name}
                  initialAmount={this.props.apply_amount}
                  hideCats={this.state.creatingModeItemType == -1}
                  onStockedIn={this.afterCreated} />
    </div>
  },

  afterCreated: function(id) {
    var data = {
      log_id: this.props.id,
      item_id: id
    }
    Api.post("api/admin/order",{m:"modifyBuyLog"}, data, function(json) {
      if ( json.errno == 0 ) {
        //订单更新
        this.props.onItemUpdated();
      } else {
        alert(json.errmsg);
      }
    }.bind(this))
  },

  onGotCategories: function(data) {
    this.setState({
      creatingModeCategoryOptions: data
    });
  }
})