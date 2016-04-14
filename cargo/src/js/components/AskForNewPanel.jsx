var React = require("react");
var HorizontalForm = require("./HorizontalForm");
var Op = require("./Op");
var Api = require("../utils/api");
var CartStore = require("../stores/cart-store");
var Actions = require("../actions");

module.exports = React.createClass({

	getInitialState: function() {
		return {
			name: "",
			amount: 0,
			day: 1
		}
	},
	
	render: function() {
		var formData = [
			{
				type: "input-text",
				label: "名称",
				properties: {
					value: this.state.name
				},
				handleChange: function(evt) {
					this.setState({
						name: evt.target.value
					})
				}.bind(this)
			},
			{
				type: "component",
				label: "数量",
				getComponent: function() {
					return <Op min={0} num={this.state.amount} onNumChange={this.onAmountFromOpChange} />
				}.bind(this)
			}
		];

		/*if (this.props.type == 1) {
			//借用类型加上天数
			formData.push({
				type: "component",
				label: "天数",
				getComponent: function() {
					return <Op min={1} num={this.state.day} onNumChange={this.onDayFromOpChange} />
				}.bind(this)
			})
		}*/
		return <div className="ask-new">
			<h1>{"申请补购新的可" + (this.props.type == 0 ? "申领" : "借用") + "物品"}</h1>
			<HorizontalForm rows={formData} flexRatio="3" />
			<button onClick={this.onSubmit}>加入订单</button>
		</div>
	},
	
	onAmountFromOpChange: function(num) {
		this.setState({amount: num});
	},

	onDayFromOpChange: function(num) {
		this.setState({day: num});
	},
	
	onSubmit: function() {
		if (this.state.amount <= 0) {
			alert("请确保数量至少为1");
			return;
		}

		if ( !this.state.name ) {
			alert("请输入物品名");
			return;
		}
		var data = {
			id: 0,
			name: this.state.name,
			amount_buy: this.state.amount,
			borrow_days: this.state.day,
			type: this.props.type,
			isNew: true
		}
		CartStore.addItemToCart(data);
		this.setState(this.getInitialState());
	}
});