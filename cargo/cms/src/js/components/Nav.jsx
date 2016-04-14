var React = require("react");

/*
	@prop String type ("tab" | "pill")
	@prop Array[Object] items
		[Object] {
			Boolean active
			Boolean disabled
			ReactElement content
			String hook
			
			Boolean withDropdown
			ReactElement dropdownBtn
			ReactElement dropdown
		}
	@prop Boolean stacked
	@prop Boolean justified
	@prop Function onSwitch(activeIndex) //trigger when active tab changes
*/

module.exports = React.createClass({
	getInitialState: function() {
		return {
			activeIndex: 0
		}	
	},
	
	componentDidUpdate: function(prevProps, prevState) {
		if ( prevState.activeIndex != this.state.activeIndex && this.props.onSwitch	 ) {
			this.props.onSwitch(this.state.activeIndex);
		}
	},
	
	render: function() {
		var styleClass = this.props.type == "pill" ? "nav-pills" : "nav-tabs";
		var stackedClass = this.props.stacked ? "nav-stacked" : "";
		var justifiedClass = this.props.justified ? "nav-justified" : "";
		return <ul className={"nav " + styleClass + " " + stackedClass + " " + justifiedClass}>
			{this.renderItems()}
		</ul>
	},
	
	renderItems: function() {
		return this.props.items.map(function(item,i) {
			if ( !item.withDropdown ) {
				var content = <a href={"#" + (item.hook ? item.hook : "")}>{item.content}</a>
			} else {
				var content = [item.dropdownBtn, dropdown];
			}
			return <li key={i} data-index={i} className={(this.state.activeIndex == i ? "active" : "") + " " + (item.disabled ? "disabled" : "") + " " + (item.withDropdown ? "dropdown" : "")}
									onClick={this.handleItemClick}>
				{content}
			</li>
		}.bind(this))
	},
	
	handleItemClick: function(evt) {
		if ( !evt.currentTarget.matches(".disabled") ) {
			this.setState({
				activeIndex: evt.currentTarget.dataset.index
			})
		}
	}
});