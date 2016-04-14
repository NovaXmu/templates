var React = require("react");

/*
	@prop Boolean open
	@prop Array[Object] items
		[Object] {
			Boolean isHeader,
			Boolean isDivider,
			Boolean isDisabled,
			ReactElement content
		}
*/

module.exports = React.createClass({
	render: function() {
		return <ul className="dropdown-menu">
			{this.renderItems()}
		</ul>
	},
	
	renderItems: function() {
		return this.props.items.map(function(item, i) {
			return <li key={i} className={(item.isHeader ? "dropdown-header" : "") + (item.isDivider ? " divider" : "") + (item.isDisabled ? "disabled" : "")}>
				{item.content ? (item.isHeader ? item.content : <a href="#">{item.content}</a>) : null}
			</li>
		});
	}
});