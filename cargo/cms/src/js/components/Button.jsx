var React = require("react");

/*
	@prop String("default" | "primary" | "info" | "success" | "warning" | "danger" | "link") style
	@prop String("lg" | "sm" | "xs") size
	@prop Boolean block
	@prop Boolean active
	@prop Boolean disabled
	@prop Function onClick([event],[component])
	@prop Boolean inForm
	@prop String className
	@prop String dataToggle
	@prop String dataTarget
	@prop String dataDismiss
	@prop String dataName
	
	@children 
	
	@template
	{
		style: "primary",
		size: null,
		block: false,
		active: false,
		disabled: false,
		onClick: function(evt, cmpo) {
			alert("clicked");
		},
		inForm: false
	}
*/

module.exports = React.createClass({
	/*getInitialState: function() {
		return {
			style: this.props.style,
			size: this.props.size,
			active: Boolean(this.props.active),
			disabled: Boolean(this.props.disabled)
		}
	},*/
	render: function() {
		var styleClass = this.props.style ? "btn-" + this.props.style : "btn-default";
		var sizeClass = this.props.size ? "btn-" + this.props.size : "";
		var blockClass = this.props.block ? "btn-block" : "";
		var activeClass = this.props.active ? "active" : "";
		var className = this.props.className ? this.props.className : "";
		return <button className={"btn" + " " + styleClass + " " + sizeClass + " " + blockClass + " " + activeClass + className}
										disabled={this.props.disabled}
										onClick={this.handleClick} 
										type={this.props.inForm ? "submit" : ""} 
										data-toggle={this.props.dataToggle || ""}
										data-target={this.props.dataTarget || ""}
										data-dismiss={this.props.dataDismiss || ""}
										data-name={this.props.dataName || ""}>
			{this.props.children}
		</button>
	},
	
	handleClick: function(evt) {
		if ( this.props.onClick ) {
			this.props.onClick(evt, this);
		}
	}
});