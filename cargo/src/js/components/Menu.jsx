var React = require("react");
var MenuPill = require("./MenuPill");

module.exports = React.createClass({
	
	render: function() {
		/*var cartHeight = document.querySelector("#cart .icon") ? document.querySelector("#cart .icon").getBoundingClientRect().height : 0; 
		var height = window.innerHeight - 40 - cartHeight;
		var style = {
			height: height + "px"
		}*/
		return <ul className={"menu " + (this.props.classes ? this.props.classes : null)}>
			{this.renderPills()}
		</ul>
	},
	
	renderPills: function() {
		return this.props.items.map(function(item,i) {
			return <MenuPill {...item} key={i} active={this.props.current.indexOf(item.id) >= 0} afterClicked={this.handleItemClick} />
		}.bind(this));
	},
	
	handleItemClick: function(event) {
		var id = event.currentTarget.dataset.id;
		if ( this.props.itemClickHandler ) {
			this.props.itemClickHandler(id);
		}
	}
});