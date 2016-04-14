var React = require("react");
var Reflux = require("reflux");
var CartItem = require("./CartItem");
var CartStore = require("../stores/cart-store");
var Actions = require("../actions");
var Api = require("../utils/api");
var Modal = require("./Modal");

module.exports = React.createClass({
	mixins: [
		Reflux.listenTo(CartStore, "onCartUpdate")
	],
	getInitialState: function() {
		return {
			items: [],
			comment: "",
			shown: false,
			showModal: false,
			allowSubmit: true
		}
	},
	
	componentWillMount: function() {
		Actions.getCartItems();
	},
	
	componentWillReceiveProps: function(nextProps) {
		if ( nextProps.section != this.props.section ) {
			this.setState({items: CartStore.findByType(nextProps.section)});
		}
	},
	
	render: function() {
		
		var badge = <span className="badge">{this.state.items.length}</span>;
		
		return <div id="cart" className={"clearfix " + (this.state.shown ? "show" : "")}>
			<div className="icon" onClick={this.handleIconClick}>
				{this.state.items.length > 0 ? badge : null}
			</div>
			
			<div className="content">
				<a href="" onClick={this.clearCartModal}>清空订单</a>
				<ul id="order-list">
					{this.renderOrderList()}
				</ul>
				<div id="order-comment">
					<input type="text" placeholder="订单备注" value={this.state.comment} onChange={this.onCommentChange}/>
					<button onClick={this.onSubmit}>提交订单</button>
				</div>
				
			</div>
			{this.state.showModal ? this.renderClearConfirmModal() : null}
		</div>
	},

	renderClearConfirmModal: function() {
		return <Modal isOpen={this.state.showModal}>
				<p>{"确定清空" + ( this.props.section == "take" ? "“申领”" : "“借用”" ) + "购物车吗？"}</p>
				<div className="btn-wrap">
					<button onClick={this.clearCart}>确定</button>
					<button onClick={this.hideModal}>取消</button>
				</div>
			</Modal>
	},

	clearCartModal: function(evt) {
		evt.preventDefault();
		this.setState({
			showModal: true
		})
	},

	hideModal: function() {
		this.setState({
			showModal: false
		})
	},
	
	onCommentChange: function(evt) {
		this.setState({
			comment: evt.target.value
		});
	},
	
	renderOrderList: function() {
		if ( this.state.items.length > 0 ) {
			return this.state.items.map(function(item, i) {
				return <CartItem {...item} key={i} />
			})
		} else {
			return <h3>{ ( this.props.section == "take" ? "“申领”" : "“借用”" ) + "购物车是空的"}</h3>
		}
	},
	
	handleIconClick: function() {
		this.setState({shown: !this.state.shown});
	},
	
	clearCart: function(evt) {
		//if ( confirm("确定清空" + ( this.props.section == "take" ? "“申领”" : "“借用”" ) + "购物车吗？") ) {
			Actions.clearCart(this.props.section);
			this.setState(this.getInitialState())
		//}
	},
	
	onSubmit: function() {
		if (!this.state.allowSubmit) return;
		if (!this.state.comment) {
			alert("备注不能为空");
			return;
		}
		//领取	
		var applyItems = this.state.items.filter(function(item) {
			return item.amount_take != 0 && item.id > 0;
		});
		var applyItemIds = applyItems.map(function(item) {
			return item.id;
		});
		var applyItemAmounts = applyItems.map(function(item) {
			return item.amount_take;
		});
		var backDays = this.props.section == "take" ? null : applyItems.map(function(item) {
			return item.real_borrow_days;
		})
		this.orderApply(applyItemIds, applyItemAmounts, backDays); 
	
		//补购
		var buyItems = this.state.items.filter(function(item) {
			return item.amount_buy != 0;
		});
		var buyItemIds = buyItems.map(function(item) {
			return item.id;
		});
		var buyItemNames = buyItems.map(function (item) {
			return item.name;
		});
		var buyItemAmounts = buyItems.map(function(item) {
			return item.amount_buy;
		});
		
		this.orderBuy(buyItemIds, buyItemNames, buyItemAmounts);
	},
	
	orderApply: function(ids, amounts, borrowDays) {
		var t = this.props.section == "take" ? "申领" : "借用";
		if ( !ids.length ) return;

		this.setState({
			allowSubmit: false
		})
		var data = {
			itemIds: JSON.stringify(ids),
			applyAmounts: JSON.stringify(amounts),
			borrowDays: JSON.stringify(borrowDays),
			remark: this.state.comment
		}
		Api.post('api/user/order', {m: this.props.section}, data, function(json) {
			if (json.errno == 0) {
				alert(t + "订单提交成功！");
			} else {
				alert(t + "订单提交失败！" + json.errmsg);
			}
			this.setState({
				allowSubmit: true
			})
		}.bind(this));
	}, 
	
	orderBuy: function(ids, names, amounts) {
		if ( !ids.length ) return;

		this.setState({
			allowSubmit: false
		})
		var data = {
			itemIds: JSON.stringify(ids),
			itemNames: JSON.stringify(names),
			applyAmounts: JSON.stringify(amounts),
			remark: this.state.comment
		}

		Api.post('api/user/order', {m: "buy"}, data, function(json) {
			if (json.errno == 0) {
				alert("补购订单提交成功！")
			} else {
				alert("补购订单提交失败！" + json.errmsg);
			}
			this.setState({
				allowSubmit: true
			})
		}.bind(this));
	},
	

	onCartUpdate: function(data) {
		this.setState({items: CartStore.findByType(this.props.section)});
	}
});