var Reflux = require("reflux");
var _ = require("lodash");
var Actions = require("../actions");
var Fetch = require("whatwg-fetch");
var Api = require("../utils/api");

module.exports = Reflux.createStore({
	listenables: [Actions],
	getOrdersByType: function(t) {  //t是管理type: "buy" | "take" | "borrow"
		Api.get("api/admin/order", {m: "getList", type: t}, function(json) {
			if ( json.errno == 0 ) {
				this.orders = json.data || [];
			} else {
				this.orders = [];
				alert(json.errmsg);
			}
			this.triggerUpdate();
		}.bind(this));
	}, 
	
	filterOrdersByState: function(dealt) {
		if ( this.orders ) {
			return _.reject(this.orders, function(each) {
				return each.dealt != dealt;
			});
		}
	},
	
	triggerUpdate: function() {
		this.trigger(this.orders);
	}
});