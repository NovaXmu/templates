var React = require('react');
var Reflux = require('reflux');
var action = require('../action');
var Api = require('../utils/api');

module.exports = Reflux.createStore({
  listenables: action,

  newRecordCount: 0,

  addNewRecordCount: function() {
    this.newRecordCount++;
    this.triggerUpdate();
  },

  clearNewRecordCount: function() {
    this.newRecordCount = 0;
    this.triggerUpdate();
  },

  triggerUpdate: function() {
    this.trigger(this.newRecordCount);
  }
})