var React = require("react");
var CommonMixins = require("./common");

/*
	@prop Boolean horizontal (from parentE)
	@prop String colLabel (from parentE)
	@prop String colMain (from parentE)
	@prop String | Array[String] initialValue (Array when {multiple: true})
	@prop String id
	@prop String label
	@prop String type
	@prop String placeholder
	@prop Boolean multiple
	@prop Boolean disable
	@prop Function changeHandler([event])
*/

module.exports = React.createClass({
	mixins: [CommonMixins],
	
	renderMain: function() {
		if ( this.props.horizontal ) {
			return <div className={this.props.colMain}>
				<select className="form-control" 
							id={this.props.id} 
							value={this.state.value}
							placeholder={this.props.placeholder}
							multiple={this.props.multiple}
							onChange={this.handleChange}
							disabled={this.props.disable} >
					{this.renderOptions()}
				</select>
			</div>
		} else {
			return <select className="form-control" 
							id={this.props.id} 
							value={this.state.value}
							placeholder={this.props.placeholder}
							onChange={this.handleChange}
							disabled={this.props.disable} >
				{this.renderOptions()}
			</select>
		}
	},
	
	renderOptions: function() {
		return this.props.options.map(function(option, i) {
			return <option value={option.value} key={i}>{option.text}</option>
		}.bind(this))
	},
	
	handleChange: function(evt) {
		if ( !this.props.multiple ) {
			this.setState({
				value: evt.target.value
			})
		} else {
			var value = [];
			var options = evt.target.options;
			for ( var i = 0; i < options.length; i++ ) {
				if ( options[i].selected ) {
					value.push(options[i].value);
				}
			}
			this.setState({
				value: value
			})
		}
		if ( this.props.changeHandler ) {
			this.props.changeHandler(evt);	
		}
	}
});