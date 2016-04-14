var React = require("react");
var ReactDOM = require("react-dom");

module.exports = React.createClass({
	render: function() {
    return <div
      {...this.props}
      onInput={this.emitChange}
      onBlur={this.emitChange}
      contentEditable="true"
      dangerouslySetInnerHTML={{__html: this.props.html}}></div>;
  },

  shouldComponentUpdate: function(nextProps) {
    return nextProps.html !== ReactDOM.findDOMNode(this).innerHTML;
  },

  componentDidUpdate: function() {
    if ( this.props.html !== ReactDOM.findDOMNode(this).innerHTML ) {
     ReactDOM.findDOMNode(this).innerHTML = this.props.html;
    }
  },

  emitChange: function(evt) {
    var html = ReactDOM.findDOMNode(this).innerHTML;
    if (this.props.onChange && html !== this.lastHtml) {
      evt.target = { value: html };
      this.props.onChange(evt);
    }
    this.lastHtml = html;
  }
});