var React = require("react");
var Reflux = require("reflux");
var UserStore = require("../stores/user-store");
var CategoryStore = require("../stores/category-store");
var Actions = require("../actions");
var Api = require("../api");

var Table = require("./Table");
var Panel = require("./Panel");
var Button = require("./Button");
var Modal = require("./Modal");
var Form = require("./Form");
var Input = require("./form-groups/Input");
var Checkbox = require("./form-groups/Checkbox");
var CheckboxGroup = require("./form-groups/CheckboxGroup");

module.exports = React.createClass({
	
	mixins: [
		Reflux.listenTo(UserStore, "onUserListUpdate")
	],
	
	getInitialState: function() {
		return {
			userList: [],
			applyCats: [],
			borrowCats: [],
			authOwned: [],
			currentUserId: null,
			currentUserName: "",
			add_username: "",
			add_phone: "",
			add_email: "",
			mod_username: "",
			mod_phone: "",
			mod_email: ""
		}	
	},
	
	componentWillMount: function() {
		Actions.getUsers();
		this.getAllCats();
	},
	
	getAllCats: function() {
		Api.get('category', {m: "apply"}, function(json) {
			if ( json.errno == 0 ) {
				this.setState({
					applyCats: json.data || []
				})
			} else {
				alert(json.errmsg);
			}
		}.bind(this));
		Api.get('category', {m: "borrow"}, function(json) {
			if ( json.errno == 0 ) {
				this.setState({
					borrowCats: json.data || []
				})
			} else {
				alert(json.errmsg);
			}
		}.bind(this));
	},
	
	render: function() {
		var userTable = [
				{
					isHead: true,
					cells: [
						{
							content: "姓名"
						},
						{
							content: "手机号"
						},
						{
							content: "Email"
						},
						{
							content: "操作"
						}
					]
				}
			]
			for ( var i = 0; i < this.state.userList.length; i++ ) {
				var user = this.state.userList[i];
				var isAdmin = user.isAdmin == 1;
				var cells = [
					{
						className: "username",
						content: user.name
					},
					{
						className: "phone",
						content: user.mobile_phone
					},
					{
						className: "email",
						content: user.email
					},
					{
						content: <div className="btn-group">
							<Button style="primary" size="sm" onClick={this.manageAuth}>权限管理</Button>
							<Button style="info" size="sm" onClick={this.modifyUser}>修改用户</Button>
							<Button style="danger" size="sm" onClick={this.deleteUser}>删除用户</Button>
						</div>
					}
				]
				userTable.push({
					className: isAdmin ? "admin" : null,
					id: user.id,
					cells: cells
				})
			}
		return <Panel heading={this.renderPanelHeading()}>
			<Table rows={userTable} hover={true} responsive={true} className="user-table"/>
			{this.renderModal("auth")}
			{this.renderModal("add-user")}
			{this.renderModal("modify-user")}
		</Panel>
	},
	
	renderPanelHeading: function() {
		return [<h2>
			用户管理
			<div className="sec-ops">
				{/*<Button style="info">用户导入</Button>*/}
				<Button style="success" onClick={this.onAddUserClick}>新增用户</Button>
			</div>
		</h2>]
	},
	
	onAddUserClick: function() {
		$("#add-user").on("hidden.bs.modal", function() {
			this.setState({
				add_username: "",
				add_phone: "",
				add_email: ""
			})
		}.bind(this))
		$("#add-user").modal("show");
	},
	
	modifyUser: function(evt) {
		var tr = $(evt.target).parents("tr");
		var id = tr.data("id");
		var name = tr.find(".username").text();
		var phone = tr.find(".phone").text();
		var email = tr.find(".email").text();
		
		$("#modify-user").on("show.bs.modal", function() {
			this.setState({
				currentUserId: id,
				mod_username: name,
				mod_phone: phone,
				mod_email: email
			})
		}.bind(this)).on("hidden.bs.modal", function() {
			this.setState({
				currentUserId: null,
				mod_username: "",
				mod_phone: "",
				mod_email: ""
			})
		}.bind(this))
		$("#modify-user").modal("show");
	},
	
	renderModal: function(kind) {
		if ( kind == "auth" ) {
			var applyPanelBody = <CheckboxGroup inline={true} initialValue={this.state.authOwned} changeHandler={this.handleCheckboxChange}>
				{this.renderApplyCats()}
			</CheckboxGroup>
			var borrowPanelBody = <CheckboxGroup inline={true} initialValue={this.state.authOwned} changeHandler={this.handleCheckboxChange}>
				{this.renderBorrowCats()}
			</CheckboxGroup>
			return <Modal id="auth" fade={true} size="lg" mainTitle={ "权限管理：" + (this.state.currentUserName || "未知用户名") }>
				<Panel heading={"申领类"} body={applyPanelBody}/>
				<Panel heading={"借用类"} body={borrowPanelBody}/>
			</Modal>
		} else if ( kind == "add-user" ) {
			var footer = <div>
				<Button style="success" onClick={this.onAddUserSubmit}>提交</Button>
				<Button dataDismiss="modal">关闭</Button>
			</div>
			return <Modal id="add-user" fade={true} mainTitle="新增用户" footer={footer}>
				<Form inline={false} horizontal={true} colLabel="col-xs-3" colMain="col-xs-9" >
					<Input type="text" label="用户名" id="add_username" initialValue={this.state.add_username} changeHandler={this.onAddInputChange}/>
					<Input type="text" label="手机号" id="add_phone" initialValue={this.state.add_phone} changeHandler={this.onAddInputChange}/>
					<Input type="email" label="Email" id="add_email" initialValue={this.state.add_email} changeHandler={this.onAddInputChange}/>
				</Form>
			</Modal>
		} else if ( kind == "modify-user" ) {
			var footer = <div>
				<Button style="success" onClick={this.onModUserSubmit}>提交</Button>
				<Button dataDismiss="modal">关闭</Button>
			</div>
			return <Modal id="modify-user" fade={true} mainTitle="修改用户" footer={footer}>
				<Form inline={false} horizontal={true} colLabel="col-xs-3" colMain="col-xs-9" >
					<Input type="text" label="用户名" id="mod_username" initialValue={this.state.mod_username} changeHandler={this.onModInputChange}/>
					<Input type="text" label="手机号" id="mod_phone" initialValue={this.state.mod_phone} changeHandler={this.onModInputChange}/>
					<Input type="email" label="Email" id="mod_email" initialValue={this.state.mod_email} changeHandler={this.onModInputChange}/>
				</Form>
			</Modal>
		}
	},
	
	onAddUserSubmit: function() {
		if ( !this.state.add_username || !this.state.add_phone || !this.state.add_email ) {
			alert("信息不完整");
			return;
		}
		var data = {
			name: this.state.add_username,
			mobile_phone: this.state.add_phone,
			email: this.state.add_email
		}
		Api.post("api/user", null, data, function(json) {
			if ( json.errno == 0 ) {
				alert("成功添加新用户！");
				this.setState({
					add_username: "",
					add_phone: "",
					add_email: ""
				})
			} else {
				alert( json.errmsg );
			}
		}.bind(this));
	},
	
	onModUserSubmit: function(evt) {
		if ( !this.state.mod_username || !this.state.mod_phone || !this.state.mod_email ) {
			alert("信息不完整");
			return;
		}
		
		var data = {
			name: this.state.mod_username,
			mobile_phone: this.state.mod_phone,
			email: this.state.mod_email,
			user_id: this.state.currentUserId
		}
		
		Api.post("api/user", null, data, function(json) {
			if ( json.errno == 0 ) {
				alert("信息修改成功！");
				Actions.getUsers();
			} else {
				alert(json.errmsg);
			}
		})
	},
	
	onAddInputChange: function(evt) {
		var stt = {};
		stt[evt.target.getAttribute("id")] = evt.target.value;
		this.setState(stt);
	},
	
	onModInputChange: function(evt) {
		var stt = {};
		stt[evt.target.getAttribute("id")] = evt.target.value;
		this.setState(stt);
	},
	
	renderApplyCats: function() {
		return this.state.applyCats.map(function(cat, i) {
			return <Checkbox key={i} id={cat.id} label={cat.name} value={cat.id} />
		})
	},
	
	renderBorrowCats: function() {
		return this.state.borrowCats.map(function(cat, i) {
			return <Checkbox key={i} id={cat.id} label={cat.name} value={cat.id} />
		})
	},
	
	handleCheckboxChange: function(evt) {
		var target = evt.target;
		var catId = target.value;
		var data = {
			category_id: catId,
			user_id: this.state.currentUserId
		}
		Api.post("api/admin", {m: "changePrivilege"}, data, function(json) {
			if ( json.errno == 0 ) {
			} else {
				alert( json.errmsg );
			}
		})
	},
	
	manageAuth: function(evt) {
		var tr = $(evt.target).parents("tr");
		var id = tr.data("id");
		var name = tr.find(".username").text();
		
		Api.get("admin", {user_id: id}, function(json) {
			if ( json.errno == 0 ) {
				if ( json.data && json.data.length > 0 ) {
					var auth = json.data.map(function(cat) {
						return cat.category_id;
					})
				} else {
					auth = [];
				}
				this.setState({
					currentUserId: id,
					currentUserName: name,
					authOwned: auth
				}, function() {
					$("#auth").modal("show");
				})
				$("#auth").on("show.bs.modal", function() {
					
				}.bind(this))
				.on("hidden.bs.modal", function() {
					this.setState({
						currentUserId: null,
						currentUserName: "",
						authOwned: []
					})
					Actions.getUsers();
				}.bind(this));
				
			} else {
				alert( json.errmsg );
			}
		}.bind(this))
		
	},
	
	deleteUser: function(evt) {
		var tr = $(evt.target).parents("tr");
		var id = tr.data("id");
		var name = tr.find(".username").text();
		
		if ( confirm("确定要删除用户" + name + "吗？") ) {
			Api.post("api/user", null, {user_id: id, deleted: true}, function(json) {
				if ( json.errno == 0 ) {
					alert( "成功删除用户" + name );
					Actions.getUsers();
				} else {
					alert(json.errmsg);
				}
			})
		}
	},

	onUserListUpdate: function(data) {
		this.setState({
			userList: data
		})
	}
});