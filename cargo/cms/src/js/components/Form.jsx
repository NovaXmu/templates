var React = require("react");

/*
	@prop Boolean inline
	@prop Boolean horizontal
	@prop String colLabel
	@prop String colMain
	
	@children 
	
	@template
	{
		inline: false,
		horizontal: true,
		colLabel: "col-xs-3",
		colMain: "col-xs-9"
	}
*/

module.exports = React.createClass({
	render: function() {
		var inlineClass = this.props.inline ? "form-inline" : "";
		var horizontalClass = this.props.horizontal ? "form-horizontal" : "";
		return <form className={inlineClass + " " + horizontalClass + " "}>
			{this.renderChildren()}
		</form>
	},
	
	renderChildren: function() {
		return React.Children.map(this.props.children, function(child) {
			if ( this.props.horizontal ) {
				return React.cloneElement(child, {
					horizontal: true,
					colLabel: this.props.colLabel,
					colMain: this.props.colMain
				})
			} else {
				return child;
			}
		}, this)
	}
});