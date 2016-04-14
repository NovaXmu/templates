var React = require("react");

module.exports = {
	getInitialState: function() {
		return {
			value: this.props.initialValue
		}
	},
	
	componentWillReceiveProps: function(nextProps) {
		var initV1 = this.props.initialValue; 
		var initV2 = nextProps.initialValue; 
		var v = this.state.value;
		
		if ( this.isArray(initV1) && this.isArray(initV2) && this.isArray(v) ) {
			initV1 = JSON.stringify(initV1.sort());
			initV2 = JSON.stringify(initV2.sort());
			v = JSON.stringify(v.sort());
		}
			
		if ( initV1 !== initV2 || v !== initV2 ) {
			this.setState({
				value: nextProps.initialValue
			})
		}	
		
	},
	
	isArray: function(obj) {
		return Object.prototype.toString.call(obj) === "[object Array]";
	},
	
	render: function() {
		return <div className="form-group">
			<label htmlFor={this.props.id} className={this.props.horizontal ? "control-label " + this.props.colLabel : ""}>{this.props.label}</label>
    	{this.renderMain()}
		</div>
	}
}