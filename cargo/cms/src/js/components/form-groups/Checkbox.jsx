var React = require("react");

/*
	@prop Boolean checked (from parentE)
	@prop String name (from parentE)
	@prop String id
	@prop String value
	@prop String label
	@prop Boolean disable
	@prop Boolean inline (from parentE)
	@prop Function changeHandler([event]) (from parentE)
*/

module.exports = React.createClass({
	
	render: function() {
		return <div className={"checkbox" + " " + ( this.props.disable ? "disabled" : "" ) + " " + ( this.props.inline ? "checkbox-inline" : "" ) + " " + (this.props.checked ? "checked" : "")}>
			<label>
				<input type="checkbox" name={this.props.name} id={this.props.id || ""} value={this.props.value} 
								checked={this.props.checked} 
								disabled={Boolean(this.props.disable)}
								onChange={this.handleChange} />
				{this.props.label}
			</label>
		</div>
	},
	
	handleChange: function(evt) {
		if ( this.props.changeHandler ) {
			this.props.changeHandler(evt);	
		}
	}
});