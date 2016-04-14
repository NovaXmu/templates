var React = require('react');

module.exports = React.createClass({

	render: function() {
		return <li onClick={this.clickHandler}  
					   data-id={this.props.id} 
					   className={(this.props.isChild ? "sub " : "" ) + (this.props.active ? "active" : "") + " " + (this.props.highlight ? "highlight" : "") + " " + (this.props.classes ? this.props.classes : "")} 
					>
				{this.props.name}
			</li>
	},

	clickHandler: function(evt) {
		this.props.afterClicked(evt)
		if ( this.props.clickHandler ) {
			this.props.clickHandler(evt);
		}
	}
})