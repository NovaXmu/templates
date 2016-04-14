var React = require('react')
var Link = require('react-router').Link
var RecordCountStore = require('../../stores/record-count-store');
var Reflux = require('reflux');
var Action = require('../../action');

var activeClass = "active"

module.exports = React.createClass({

  mixins: [Reflux.listenTo(RecordCountStore, "onRecordCountUpdate")],

  getInitialState: function() {
    return {
      newRecordCount: 0
    };
  },

  render: function() {
    return <div className="nav">
      <ul>
        <li><Link to="/game" activeClassName={activeClass}>抢票</Link></li>
        <li>
          <Link to="/record" activeClassName={activeClass} onClick={this.clearCount}>记录</Link>
          {this.renderBadge()}
        </li>
        {this.props.userInfo.isAdmin == 1 ? (<li><Link to="/inspect" activeClassName={activeClass}>审核</Link></li>) : null}
      </ul>
    </div>
  },

  renderBadge: function() {
    return this.state.newRecordCount > 0 ? (<i>{this.state.newRecordCount}</i>) : null;
  },

  clearCount: function() {
    Action.clearNewRecordCount();
  },

  onRecordCountUpdate: function(num) {
    this.setState({
      newRecordCount: num
    })
  }
})