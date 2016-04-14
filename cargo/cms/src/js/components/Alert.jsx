var React = require("react");

/*
	@prop String style 
	@prop Boolean dismissible
	
	@children
*/

module.exports = React.createClass({
	render: function() {
		var dismissBtn = this.props.dismissible ? (<button type="button" className="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>) : null;
		return <div className={"alert alert-warning" + " " + (this.props.dismissible ? " alert-dismissible" : "")} role="alert">
			{dismissBtn}
			{this.props.children}
		</div>
	}
});