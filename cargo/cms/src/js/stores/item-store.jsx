var Reflux = require("reflux");
var Actions = require("../actions");
var Api = require("../api");
var _ =  require("lodash");
var Fetch = require("whatwg-fetch");


module.exports = Reflux.createStore({
	listenables: [Actions],
	getItemsInCategory: function() {
		Api.get("item", null, function(json) {
			if ( json.errno == 0 ) {
				this.itemsInCategory = json.data || [];
			} else {
				this.itemsInCategory = [];
				alert(json.errmsg);
			}
			this.triggerUpdate();
		}.bind(this));	
	},
	
	findByCat: function(id) {
		if ( this.itemsInCategory ) {
			return this.itemsInCategory[id] || [] ;
		} else {
			return [];
		}
	},
	
	searchItemsByKeyword: function(key, type) {
		var list = [];
		if ( this.itemsInCategory ) {
			for ( var catid in this.itemsInCategory ) {
				var items = this.itemsInCategory[catid];
				var filtered = _.reject(items, function(item) {
					return item.name.indexOf(key) < 0 || item.type != type;
				});
				list = list.concat(filtered);
			}
			
			return list;
		}
	},
	
	triggerUpdate: function() {
		this.trigger(this.itemsInCategory);
	}
});