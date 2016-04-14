var React = require("react");
var CommontMixins = require("./common");

/*
	@prop Boolean horizontal (from parentE)
	@prop String colLabel (from parentE)
	@prop String colMain (from parentE)
	@prop String initialValue
	@prop String id
	@prop String label
*/

module.exports = React.createClass({
	mixins: [CommontMixins],
	
	renderMain: function() {
		if ( this.props.horizontal ) {
			return <div className={this.props.colMain}>
				<p type={this.props.type} 
							className="form-control-static" 
							id={this.props.id} >
					{this.state.value}
				</p>
			</div>
		} else {
			return <p type={this.props.type} 
							className="form-control-static" 
							id={this.props.id} >
					{this.state.value}
				</p>
		}
	}
});