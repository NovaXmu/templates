var React = require("react");
var CommonMixins = require("./common");
/*
	@prop Boolean horizontal (from parentE)
	@prop String colLabel (from parentE)
	@prop String colMain (from parentE)
	@prop String initialValue
	@prop String id
	@prop String label
	@prop String placeholder
	@prop Number rowNum
	@prop Boolean disable
	@prop Function changeHandler([event])
*/

module.exports = React.createClass({
	mixins: [CommonMixins],
	
	renderMain: function() {
		if ( this.props.horizontal ) {
			return <div className={this.props.colMain}>
				<textarea className="form-control" 
							id={this.props.id} 
							value={this.state.value}
							rows={this.props.rowNum ? this.props.rowNum : 3}
							placeholder={this.props.placeholder}
							onChange={this.handleChange} 
							disabled={this.props.disable} />
			</div>
		} else {
			return <textarea Name="form-control" 
							id={this.props.id} 
							value={this.state.value}
							rows={this.props.rowNum ? this.props.rowNum : 3}
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