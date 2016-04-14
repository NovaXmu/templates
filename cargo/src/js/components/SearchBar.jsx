var React = require("react");

module.exports = React.createClass({
	render: function() {
		return <div id="search-bar">
			<input type="text" placeholder="&#xe600;按名称搜索" onChange={this.handleChange} value={this.props.value} />
		</div>
	},
	
	handleChange: function(e) {
		var t = e.currentTarget;
		var value = t.value;
		this.props.changeHandler(value);
	}
});