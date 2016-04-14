var React = require("react");
var Item = require("./Item");
var Actions = require("../actions");
var ItemStore = require("../stores/item-store");
var Reflux = require("reflux");

module.exports = React.createClass({
	mixins: [
		Reflux.listenTo(ItemStore, "onItemStoreUpdate")
	],

	//当前列表所属分类：this.props.category 
	getInitialState: function() {
		return {
			items: [],
			searchKey: "",
			warning: "加载中...",
			loaded: false
		}
	},
	
	componentWillMount: function() {
		Actions.getItemsInCategory();
	},
	
	componentWillReceiveProps: function(nextProps) {
		if (nextProps.searchKey) {
			var searchResult = ItemStore.searchItemsByKeyword(nextProps.searchKey, nextProps.type);
			this.setState({
				items: searchResult || []
			});
		} else {
			this.setState({
				items: ItemStore.findByCat(nextProps.category)
			});
		}
	},
	
	componentDidUpdate: function(prevProps, prevStates) {
		if ( prevStates.items !== this.state.items && this.state.items.length <= 0 && this.state.loaded ) {
				this.setState({
					warning: "没有找到相应物品"
				})
			}
	},
	
	//this.props.category: 所请求的列表所属分类的id
	render: function() {
		return <ul className="goods-list">
			{ this.state.items.length > 0 ? this.renderGoodsItems() : this.state.warning }
		</ul>
	},
	
	renderGoodsItems: function() {
		return this.state.items.map(function(item) {
			return <Item className="item" 
									 key={item.id} {...item} 
									 {...this.props}
									 onUpdate={this.onItemUpdate} />
		}.bind(this));
	},
	
	onItemUpdate: function() {
		Actions.getItemsInCategory();
	},
	
	onItemStoreUpdate: function(data) {
		this.setState({
			items: ItemStore.findByCat(this.props.category),
			loaded: true
		});
	}
});