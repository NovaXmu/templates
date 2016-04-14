var React = require("react");

/*
	@prop String main
	@prop String sub
*/

module.exports = React.createClass({
	render: function() {
		return <div class="page-header">
			<h1>{this.props.main} <small>{this.props.sub}</small></h1>
		</div>
	}
});