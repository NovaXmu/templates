var React = require("react");
var CommontMixins = require("./common");

/*
	@prop Boolean horizontal (from parentE)
	@prop String colLabel (from parentE)
	@prop String colMain (from parentE)
	@prop Array[String] initialValue
	@prop String id
	@prop String name
	@prop String label
	@prop Boolean inline
	@prop Function changeHandler([event])
	
	@children
*/

module.exports = React.createClass({
	mixins: [CommontMixins],
	
	renderMain: function() {
		if ( this.props.horizontal ) {
			return <div className={this.props.colMain}>
				<div className="checkbox-group" 
							id={this.props.id} >
					{this.renderCheckboxes()}	
				</div>
			</div>
		} else {
			return <div className="checkbox-group" 
							id={this.props.id} >
				{this.renderCheckboxes()}	
			</div>				
		}
	},
	
	renderCheckboxes: function() {
		return React.Children.map(this.props.children, function(child) {
			return React.cloneElement(child, {
				name: this.props.name,
				changeHandler: this.handleChange,
				checked: this.state.value? this.state.value.indexOf(child.props.value) != -1 : false,
				inline: this.props.inline
			})
		}, this)
	},
	
	handleChange: function(evt) {
		if ( evt.target.checked ) {
			var newArray = this.state.value.slice(0);
			newArray.push(evt.target.value);
			this.setState({
				value: newArray
			})
		} else {
			var newArray = this.state.value.slice(0);
			newArray.splice(this.state.value.indexOf(evt.target.value), 1);
			this.setState({
				value: newArray
			})
		}
		if ( this.props.changeHandler ) {
			var result = this.props.changeHandler(evt);	
			// if ( !result ) {
			// 	var newArray = this.state.value.slice(0);
			// 	newArray.splice(this.state.value.indexOf(evt.target.value), 1);
			// 	this.setState({
			// 		value: newArray
			// 	})
			// }
		}
	}
});