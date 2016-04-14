var React = require("react");

/*
	@prop String style ("default" | "primary" | "info" | "success" | "warning" | "danger")
	@prop ReactElement body
	@prop ReactElement heading
	@prop ReactElement footer
	@prop String className
	
	@children
*/

module.exports = React.createClass({
	
	render: function() {
		var style = this.props.style ? "panel-" + this.props.style : "panel-default";
		return <div className={"panel " + style + " " + (this.props.className || "")}>
			{this.renderHeading()}
			{this.renderBody()}
			{this.props.children}
			{this.renderFooter()}
		</div>
	},
	
	renderHeading: function() {
		if ( this.props.heading ) {
			return <div className="panel-heading">
				{this.props.heading}
			</div>
		} else {
			return null;
		}
	},
	
	renderBody: function() {
		if ( this.props.body ) {
			return <div className="panel-body">
				{this.props.body}
			</div>
		} else {
			return null;
		}
	},
	
	renderFooter: function() {
		if ( this.props.footer ) {
			return <div className="panel-footer">
				{this.props.footer}
			</div>
		} else {
			return null;
		}
	}
});