var React = require("react");
var Manager = require("./Manager");
var Shelves = require("./Shelves");
var ValuableManager = require("./ValuableManager")

module.exports = React.createClass({
	
	render: function() {
		return <div id="manage-panel">
			{this.renderSection()}
		</div>
	},
	
	renderSection: function() {
		switch(this.props.section) {
			case "1":
				return <Shelves type={0} client="manager" />;
			case "2":
				return <Shelves type={1} client="manager" />;
			case "3": 
				return <Manager type={"take"} />; 
			case "4":
				return <ValuableManager />;
			default:
				return <Shelves type={0} client="manager" />;
		}
	}
});