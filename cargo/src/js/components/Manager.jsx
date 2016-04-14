var React = require("react");
var OrderStore = require("../stores/order-store");
var Reflux = require("reflux");
var Actions = require("../actions");
var Menu = require("./Menu");
var LogItem = require("./LogItem");
var Order = require("./Order");

module.exports = React.createClass({
	mixins: [
		Reflux.listenTo(OrderStore, "onOrderListUpdate")
	],
	getInitialState: function() {
		return {
			orders: [],
			currentType: ['take'],
			showSubMenu: "",
			subMenuPos: 0
		}
	},
	
	componentDidMount: function() {
		this.updateOrders();
	},
	
	componentDidUpdate: function(prevProps, prevState) {
		if ( prevState.currentType != this.state.currentType ) {
			this.updateOrders();
		}
	},
	
	render: function() {
		var menuBtns = [
			{
				id: "take",
				name: "申领订单",
				clickHandler: function() {
					if (this.state.showSubMenu == "take") {
						this.setState({
							showSubMenu: "",
							subMenuPos: 0
						})
					} else {
						this.setState({
							showSubMenu: "take",
							subMenuPos: 1
						})
					}
				}.bind(this)
			},
			{
				id: "borrow",
				name: "借用订单",
				clickHandler: function() {
					if (this.state.showSubMenu == "borrow") {
						this.setState({
							showSubMenu: "",
							subMenuPos: 0
						})
					} else {
						this.setState({
							showSubMenu: "borrow",
							subMenuPos: 2
						})
					}
				}.bind(this)
			},
			{
				id: "buy",
				name: "补购订单",
				clickHandler: function() {
					if (this.state.showSubMenu == "buy") {
						this.setState({
							showSubMenu: "",
							subMenuPos: 0
						})
					} else {
						this.setState({
							showSubMenu: "buy",
							subMenuPos: 3
						})
					}
					
				}.bind(this)
			}
		]
		if ( this.state.showSubMenu ) {
			menuBtns.splice(this.state.subMenuPos, 0, 
				{
					id: "accepted",
					name: "已通过",
					isChild: true,
					clickHandler:function() {
						this.setState({
							currentType: [this.state.showSubMenu, "accepted"]
						})
					}.bind(this)
				},
				{
					id: "refused",
					name: "已拒绝",
					isChild: true,
					clickHandler:function() {
						this.setState({
							currentType: [this.state.showSubMenu, "refused"]
						})
					}.bind(this)
				}
			);
		}
		return <div id="manager">
			<Menu items={menuBtns} current={this.state.currentType} itemClickHandler={this.handleMenuClick} />
			<div className="content" style={this.state.orderListStyle}>
				{this.renderOrderList()}
			</div>
		</div>
	},

	handleMenuClick: function(id) {
		this.setState({
			currentType: [id]
		})
	},
	
	renderOrderList: function() {
		return this.state.orders.map(function(order, i) {
			return <Order {...order} key={i} onOrderDealt={this.updateOrders} />
		}.bind(this));
	},
	
	updateOrders: function() {
		Actions.getOrdersByType(this.state.currentType[0]);
	},
	
	onOrderListUpdate: function(data) {
		var dealt = this.state.currentType.length < 2 ? 0 : (this.state.currentType[1] == "accepted" ? 1 : -1);
		var data_ = OrderStore.filterOrdersByState(dealt);
		this.setState({
			orders: data_
		})
	}
});