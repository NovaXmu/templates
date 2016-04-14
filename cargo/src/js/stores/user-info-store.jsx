var Reflux = require("reflux");
var Actions = require("../actions");
var _ = require("lodash");

module.exports = Reflux.createStore({
	listenables: [Actions],
	
	getUserInfo: function() {
		this.triggerUpdate();
	},
	
	setUserInfo: function(auth) {
		this.auth = auth;
		this.triggerUpdate();
	},
	
	triggerUpdate: function() {
		this.trigger(this.auth);
	}
});