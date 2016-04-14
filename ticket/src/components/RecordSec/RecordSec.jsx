var React = require('react');
var Reflux = require('reflux');
var RecordItem = require('../RecordItem/RecordItem');
var Action = require('../../action');
var RecordStore = require('../../stores/record-store');

module.exports = React.createClass({

  mixins: [Reflux.listenTo(RecordStore, "onRecordsUpdate")],

  getInitialState: function() {
    return {
      items: [],
      noitem: false
    }
  },

  componentDidMount: function() {
    Action.getRecords();
  },

  render: function() {
    return <div id="record-sec" className="section">
      <ul>{this.renderItems()}</ul>
    </div>
  },

  renderItems: function() {
    if (this.state.noitem) {
      return <div className="no-item">没有任何抢票记录</div>
    }
    return this.state.items.map(function(record, i) {
      return <RecordItem {...record} key={i} />
    })
  },

  onRecordsUpdate: function(data) {
    if (data.length <= 0) {
      this.setState({
        noitem: true
      })
    }
    this.setState({
      items: data
    })
  }
})