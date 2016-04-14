var React = require("react");
var Api = require("../utils/api");
var Modal = require("./Modal");

module.exports = React.createClass({
	getInitialState: function() {
		return {
			name: this.props.initialName,
			inputVal: this.props.initialName,
			modifyMode: false,
			showModal: false
		}	
	},
	
	render: function() {
		if ( this.state.modifyMode ) {
			return <div className="cat-label">
				<input value={this.state.inputVal} onChange={this.onInputChange} />
				<button onClick={this.onModified}>确定</button>
				<button onClick={this.onCancelModify}>取消</button>
			</div>
		}
		return <div className="cat-label">
			<span>{this.state.name}</span>
			<a onClick={this.onModify}>修改</a>
			<a onClick={this.showConfirmModal}>删除</a>
			{this.renderConfirmModal()}
		</div>
	},

	renderConfirmModal: function() {
		return <Modal isOpen={this.state.showModal}>
			<p>确定删除该分类及其下所有物品吗？</p>
			<div className="btn-wrap">
				<button onClick={this.onDelete}>确定</button>
				<button onClick={this.closeModal}>取消</button>
			</div>
		</Modal>
	},

	showConfirmModal: function(evt) {
		evt.preventDefault();
		this.setState({
			showModal: true
		})
	},

	closeModal: function(evt) {
		evt.preventDefault()
		this.setState({
			showModal: false
		})
	},
	 
	onInputChange: function(evt) {
		this.setState({
			inputVal: evt.target.value
		})
	},
	
	onModify: function(evt) {
		evt.preventDefault();
		this.setState({
			modifyMode: true
		})
	},
	
	onModified: function(evt) {
		evt.preventDefault();
		var data = {
			name: this.state.inputVal,
			id: this.props.cat_id
		}
		Api.post("api/admin/category", {m: "modify"}, data, function(json) {
			if ( json.errno == 0 ) {
				this.setState({
					name: this.state.inputVal,
					modifyMode: false
				})
				alert("修改成功");
				this.props.onListChange();
			} else {
				alert(json.errmsg);
			}
		}.bind(this))
		
	},
	
	onCancelModify: function(evt) {
		evt.preventDefault();
		this.setState({
			inputVal: this.state.name,
			modifyMode: false
		})
	},
	
	onDelete: function() {
		var data = {
			id: this.props.cat_id,
			deleted: 1
		}
		Api.post("api/admin/category", {m: "modify"}, data, function(json) {
			if ( json.errno == 0 ) {
				this.props.onListChange();
			} else {
				alert(json.errmsg);
			}
		}.bind(this))
	}
})