var React = require("react");
var CommontMixins = require("./common");

/*
	@prop Boolean horizontal (from parentE)
	@prop String colLabel (from parentE)
	@prop String colMain (from parentE)
	@prop String initialValue
	@prop String id
	@prop String label
	@prop String type (text, password, datetime, datetime-local, date, month, time, week, number, email, url, search, tel, color)
	@prop String placeholder
	@prop Boolean disable
	@prop Function changeHandler([event])
*/

module.exports = React.createClass({
	mixins: [CommontMixins],
	
	renderMain: function() {
		if ( this.props.horizontal ) {
			return <div className={this.props.colMain}>
				<input type={this.props.type} 
							className="form-control" 
							id={this.props.id} 
							value={this.state.value}
							placeholder={this.props.placeholder}
							onChange={this.handleChange}
							disabled={this.props.disable} />
			</div>
		} else {
			return <input type={this.props.type} 
							className="form-control" 
							id={this.props.id} 
							value={this.state.value}
							placeholder={this.props.placeholder}
							onChange={this.handleChange}
							disabled={this.props.disable} />
		}
	},
	
	handleChange: function(evt) {
		this.setState({
			value: evt.target.value
		})
		if ( this.props.changeHandler ) {
			this.props.changeHandler(evt);	
		}
	}
});