var React = require("react");
var CommontMixins = require("./common");

/*
	@prop Boolean horizontal (from parentE)
	@prop String colLabel (from parentE)
	@prop String colMain (from parentE)
	@prop String initialValue
	@prop String id
	@prop String name
	@prop String label
	@prop Boolean inline
	@prop Function changeHandler()
	
	@children
*/

module.exports = React.createClass({
	mixins: [CommontMixins],
	
	renderMain: function() {
		if ( this.props.horizontal ) {
			return <div className={this.props.colMain}>
				<div className="radio-group" 
							id={this.props.id} >
					{this.renderRadios()}	
				</div>
			</div>
		} else {
			return <div className="radio-group" 
							id={this.props.id} >
				{this.renderRadios()}	
			</div>				
		}
	},
	
	renderRadios: function() {
		return React.Children.map(this.props.children, function(child) {
			return React.cloneElement(child, {
				name: this.props.name,
				changeHandler: this.handleChange,
				checked: child.props.value == this.state.value,
				inline: this.props.inline
			})
		}, this)
	},
	
	handleChange: function(evt) {
		if ( evt.target.checked ) {
			this.setState({
				value: evt.target.value
			})
		}
		if ( this.props.changeHandler ) {
			this.props.changeHandler();	
		}
	}
});