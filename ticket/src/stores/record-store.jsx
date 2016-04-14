var React = require('react');
var Reflux = require('reflux');
var action = require('../action');
var Api = require('../utils/api');

module.exports = Reflux.createStore({
  listenables: action,

  getRecords: function() {
    Api.get("api/user/participant?m=getHistoryRecord", null, function(json) {
      if (json.errno == 0) {
        this.items = json.data;
        this.triggerUpdate();
      } else {
        this.items = [];
        alert(json.errmsg)
      }
    }.bind(this))
    
  },

  triggerUpdate: function() {
    this.trigger(this.items);
  }
})