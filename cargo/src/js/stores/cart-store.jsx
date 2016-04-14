var Reflux = require("reflux");
var Actions = require("../actions");
var _ = require("lodash");

module.exports = Reflux.createStore({
	listenables: [Actions],
	
	getCartItems: function() {
		try {
			this.items = JSON.parse(localStorage.getItem("wzgl_cart_items"));
		} catch(e) {
			this.items = [];
		}
		this.triggerUpdate();
	},
	
	addItemToCart: function(item) {
		if ( !this.items ) {
			this.items = [];
		}
		this.items.push(item);
		this.triggerUpdate();
	},
	
	updateItemInCart: function(item) {
		var i = item.id == 0 ? this.findByName(item.name) : this.find(item.id);
		if ( !i ) {
			this.addItemToCart(item);
			return;
		}
		i = item;
		i.need_buy = i.amount_buy > 0;
		this.items.forEach(function(each,index) {
			if ( ( item.id > 0 && each.id == item.id ) || each.name == item.name ) {
				_.assign(this.items[index], i);
				this.triggerUpdate();
			}
		}.bind(this));
	},
	
	removeItemFromCart: function(id) {
		this.items = _.reject(this.items, function(item) {
			return item.id == id;
		});
		this.triggerUpdate();
	},

	removeItemFromCartByName: function(name) {
		this.items = _.reject(this.items, function(item) {
			return item.name == name;
		});
		this.triggerUpdate();
	},
	
	clearCart: function(type) {
		var tCode = type == "take" ? 0 : 1;
		this.items = _.reject(this.items, function(item) {
			return item.type == tCode;
		});
		this.triggerUpdate();
	},
	
	find: function(id) {
		if ( !this.items ) return null;
		var result;
		this.items.forEach(function(item) {
			if ( item.id == id ) {
				result = item;
			}
		}.bind(this));
		
		return result;
	},

	findByName: function(name) {
		if ( !this.items ) return null;
		var result;
		this.items.forEach(function(item) {
			if ( item.name == name ) {
				result = item;
			}
		}.bind(this));
		
		return result;
	},
	
	findByType: function(type) {
		if ( !this.items ) return [];
		return this.items.filter(function(item) {
			switch( type ) {
				case "take":
					return item.type == 0;
				case "borrow":
					return item.type == 1;
			}
		})
	},
	
	triggerUpdate: function() {
		this.trigger(this.items);
		if ( window.localStorage ) {
			localStorage.setItem("wzgl_cart_items", JSON.stringify(this.items));
		}
	}
});