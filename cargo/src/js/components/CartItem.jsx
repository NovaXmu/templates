var React = require("react");
var Reflux = require("reflux");
var Actions = require("../actions");
var CartStore = require("../stores/cart-store");
var Tools = require("../utils/tools");
var Item_Cart_Op = require("../utils/item_cart_op");
var Op = require("./Op");

module.exports = React.createClass({

	mixins: [
		Tools,
		Item_Cart_Op,
		Reflux.listenTo(CartStore, "onCartUpdate")
	],
	
	getInitialState: function() {
		return {
			amount_take: this.props.amount_take,
			amount_buy: this.props.amount_buy,
			real_borrow_days: this.props.real_borrow_days	
		}
	},
	
	componentWillReceiveProps: function(nextProps) {
		if (nextProps.amount_buy != this.props.amount_buy || nextProps.amount_take != this.props.amount_take) {
			var totalAmount = Number(nextProps.amount_take ? nextProps.amount_take : 0) + Number(nextProps.amount_buy ? nextProps.amount_buy : 0);
			if ( nextProps.amount_take !== "" && nextProps.amount_buy !== "" && totalAmount === 0 ) {
				if (nextProps.id > 0) {
					Actions.removeItemFromCart(nextProps.id);
				} else {
					Actions.removeItemFromCartByName(nextProps.name);
				}
			} else {
				this.setState(nextProps);
			}
		}    
	},
	
	render: function() {
		return <li className={"cart-item clearfix " + ( this.props.type == 0 ? "take " : "borrow " ) + (this.props.isNew ? "is-new" : "")}>
			<div className="name">{this.props.name}</div>
			<div className="op">
				<section data-type="take">
					数量
					<Op min={0} style={"input"} max={this.props.isNew ? 0 : this.props.amount} onMax={this.props.isNew ? this.onTakeNew : this.onTakeAmountMax} num={this.state.amount_take} onNumChange={this.onTakeAmountChange} />
				</section>
				<section data-type="buy">
					补购
					<Op min={0} style={"input"} num={this.state.amount_buy} onNumChange={this.onBuyAmountChange} />
				</section>
				{this.props.type == 1 && !this.props.isNew ? this.renderBorrowDaysOp() : null}	
			</div>
		</li>
	},

	onTakeNew: function() {
		alert("新物品无法申领或借用，只能申请补购");
	},

	renderBorrowDaysOp: function() {
		return <section data-type="brw-days">
			天数
			<Op style={"input"} min={1} num={this.state.real_borrow_days}  max={this.props.borrow_days} onMax={this.onBorrowDayMax} onNumChange={this.onBorrowDayChange} />
		</section>
	}
	
});