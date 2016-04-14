var React = require("react");
var CategoryLabel = require("./CategoryLabel");
var Actions = require("../actions");
var Reflux = require("reflux");
var Api = require("../utils/api");

module.exports = React.createClass({
	getInitialState: function() {
		return {
			addMode: false,
			newCatName: ""
		}
	},
	
	render: function() {
		var addComponent = <div className="add-comp">
			<input type="text" value={this.state.newCatName} onChange={this.onCreateInputChange} />
			<div className="btn-wrap">
				<button onClick={this.onAdded}>确定</button>
				<button onClick={this.onCancelAdd}>取消</button>
			</div>
		</div>
		return <div className="cat-mng">
			<h1>{this.props.type == 0 ? "申领" : "借用"}分类管理</h1>
			<div>
				{this.renderCategories()}
			</div>
			<i className="add" onClick={this.onAdd}>+</i>
			{this.state.addMode ? addComponent : null}
		</div>
	},
	
	renderCategories: function() {
		return this.props.cats.map(function(cat, i) {
			return <CategoryLabel key={i} initialName={cat.name} cat_id={cat.id} onListChange={this.handleChange} />
		}.bind(this))
	},
	
	handleChange: function() {
		Actions.getCategories(this.props.type);
	},
	
	onCreateInputChange: function(evt) {
		this.setState({
			newCatName: evt.target.value
		});
	},
	
	onAdd: function() {
		this.setState({
			addMode: true
		})
	},
	
	onCancelAdd: function() {
		this.setState({
			addMode: false
		})
	},
	
	onAdded: function() {
		var data = {
			name: this.state.newCatName,
			type: this.props.type
		}
		Api.post("api/admin/category", null, data, function(json) {
			if ( json.errno == 0 ) {
				alert("创建成功！");
				Actions.getCategories(this.props.type);
			} else {
				alert(json.errmsg);
			}
		}.bind(this))
	}
})