var React = require('react');

module.exports = React.createClass({
  render: function() {
    var style = {
      width: this.props.ratio * 100 + "%"
    }
    return <div className="bar-outer">
      <div className="bar-inner" style={style}></div>
    </div>
  }
})