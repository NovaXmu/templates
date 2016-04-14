var Reflux = require("reflux");
var Actions = require("../actions");
var Api = require("../api");
var _ = require("lodash");
var Fetch = require("whatwg-fetch");

module.exports = Reflux.createStore({
	listenables: [Actions],
	
	getCategories: function(type) {
		var m = type == 0 ? "apply" : "borrow";
	  Api.get('category', {m: m}, function(json) {
			if ( json.errno == 0 ) {
				this.data = json.data || [];
			} else {
				this.data = [];
				alert(json.errmsg);
			}
			this.triggerUpdate();
		}.bind(this));
		
	},
	
	findByType: function(type) {
		if ( this.data ) {
			return this.data.filter(function(item) {
				return item.type == type;
			});
		}
	},
	
	triggerUpdate: function() {
		this.trigger(this.data);
	}
});