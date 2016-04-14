var _ = require("lodash");
var Actions = require("../actions");
var CartStore = require("../stores/cart-store");

module.exports = {

	componentDidMount: function() {
		this.setState( (this.props.id == 0 ? CartStore.findByName(this.props.name) : CartStore.find(this.props.id) ) || {});
	},

	onTakeAmountMax: function() {
		alert('已达库存上限，你可以点击"补购"告知管理员需要补购的数量');
	},

	onTakeAmountChange: function(num) {
		if (this.props.inNew) {
			return;
		}
		var p = this.state;
		p["amount_take"] = num;
		var q = {};
		_.assign(q, this.props, p);
		Actions.updateItemInCart(q);
	},

	onBuyAmountChange: function(num) {
		var p = this.state;
		p["amount_buy"] = num;
		var q = {};
		_.assign(q, this.props, p);
		Actions.updateItemInCart(q);
	},

	onBorrowDayChange: function(num) {
		var p = this.state;
		p["real_borrow_days"] = num;
		var q = {};
		_.assign(q, this.props, p);
		Actions.updateItemInCart(q);
	},

	onCartUpdate: function(data) {
		if ( !data.length ) {
			this.setState({
				amount_take: this.getInitialState().amount_take,
				amount_buy: this.getInitialState().amount_buy,
				need_buy: this.getInitialState().need_buy,
				real_borrow_days: this.getInitialState().real_borrow_days
			});
		} else {
			var item = this.props.id == 0 ? CartStore.findByName(this.props.name) : CartStore.find(this.props.id);
			if ( !item ) return;
			this.setState({
				amount_take: item.amount_take,
				amount_buy: item.amount_buy,
				need_buy: item.need_buy,
				real_borrow_days: item.real_borrow_days
			});
		}
	},

	onBorrowDayMax: function() {
		alert("已达可借用天数上限")
	}
}