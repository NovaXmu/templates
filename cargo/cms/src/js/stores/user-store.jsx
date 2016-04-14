var Reflux = require("reflux");
var Actions = require("../actions");
var Api = require("../api");

module.exports = Reflux.createStore({
	listenables: [Actions],
	
	getUsers: function() {
		Api.get("user", {m: "userList"}, function(json) {
			if ( json.errno == 0 ) {
				this.users = json.data;
				this.triggerUpdate();
			} else {
				alert( json.errmsg );
			}
		}.bind(this))		
	},
	
	triggerUpdate: function() {
		this.trigger(this.users);
	}
});