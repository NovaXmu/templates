var React = require("react");

/*
	@prop String id
	@prop Boolean fade
	@prop String size ("lg" || "sm")
	@prop String mainTitle
	@prop ReactElement footer
	
	@children
*/

module.exports = React.createClass({
	
	render: function() {
		var sizeClass = this.props.size == "lg" ? "modal-lg" : "modal-sm";
	
		return <div className={"modal" + " " + (this.props.fade ? "fade" : "")} id={this.props.id} role="dialog">
			<div className={"modal-dialog" + " " + sizeClass}>
				<div className="modal-content">
					<div className="modal-header">
						<button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 className="modal-title">{this.props.mainTitle}</h4>
					</div>
					<div className="modal-body">
						{this.props.children}
					</div>
					{this.renderFooter()}
				</div>
			</div>
		</div>
	},
	
	renderFooter: function() {
		if ( this.props.footer ) {
			return <div className="modal-footer">
				{this.props.footer}
			</div>
		} else {
			return null;
		}
	}
})