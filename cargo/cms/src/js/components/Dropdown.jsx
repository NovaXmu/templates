var React = require("react");
var DropdownMenu = require("./DropdownMenu");

/*
	@prop Boolean up
	@prop Array[Object] menuItems
		[Object] => See #DropdownMenu.props.items
	
	@children (only)
*/

module.exports = React.createClass({
	getInitialState: function() {
		return {
			open: false
		}
	},
	
	render: function() {
		var openClass = this.state.open ? "open" : "";
		return <div className={(this.props.up ? "dropup" : "dropdown") + " " + openClass}>
			{this.renderToggle()}
			<DropdownMenu items={this.props.menuItems} open={this.state.open}/>
		</div>
	},
	
	renderToggle: function() {
		if ( Array.isArray(this.props.children) ) {
			return null;
		} else {
			return React.cloneElement(this.props.children, {
				className: this.props.children.props.className + " dropdown-toggle",
				dataToggle: "dropdown",
				onClick: this.handleClick,
				clickHandler: this.handleClick 
			})
		}
	},
	
	handleClick: function() {
		this.setState({
			open: !this.state.open
		})
	}
});