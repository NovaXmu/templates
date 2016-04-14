var React = require("react");
var Tools = require("../utils/tools");

module.exports = React.createClass({
	mixins: [Tools],
	getInitialState: function() {
		return {
			num: this.props.num || 0
		}
	},

	componentWillReceiveProps: function(nextProps) {
	    if ( this.props.num != nextProps.num )  {
	    	this.setState({
	    		num: nextProps.num
	    	})
	    }
	},

	render: function() {
		return <div className="num_op">
			<i className="sub" onClick={this.onOp}>-</i>
			{this.renderAmount()}
			<i className="add" onClick={this.onOp}>+</i>
		</div>
	},

	renderAmount: function() {
		if (this.props.style == "input") {
			return <input type="text" className="amount" value={this.state.num} onChange={this.handleInputChange} />
		} else {
			return <span className="amount">{this.state.num}</span>
		}
	},
	
	onOp: function(event) {
		if (this.props.onNumWillChange) {
			this.props.onNumWillChange(this.state.num);
		}
		var t = event.currentTarget;
		if ( this.hasClass(t, "sub") ) {
			if ( this.props.min != undefined && this.state.num <= this.props.min ) {
				if (this.props.onMin) {
					this.props.onMin()
				}
				return;
			}
			this.setState({
				num: --this.state.num
			});
		} else {
			if ( this.props.max != undefined && this.state.num >= this.props.max ) {
				if (this.props.onMax) {
					this.props.onMax()
				}
				return;
			}
			this.setState({
				num: ++this.state.num
			});
		}
		if ( this.props.onNumChange ) {
			this.props.onNumChange(this.state.num);
		}
	},

	handleInputChange: function(event) {
		var t = event.currentTarget;
		var value = t.value;
		if ( !/^\d*$/.test(value) ) {
			return;
		}
		this.setState({
			num: value
		})
		if ( this.props.onNumChange ) {
			this.props.onNumChange(value);
		}
	}
});