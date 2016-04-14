var React = require("react");
var Table = require("./Table");
var Button = require("./Button");
var Form = require("./Form");
var Input = require("./form-groups/Input");
var Select = require("./form-groups/Select");
var Textarea =  require("./form-groups/Textarea");
var PlainText = require("./form-groups/PlainText");
var Radio = require("./form-groups/Radio");
var RadioGroup = require("./form-groups/RadioGroup");
var Checkbox = require("./form-groups/Checkbox");
var CheckboxGroup = require("./form-groups/CheckboxGroup");
var Dropdown = require("./Dropdown");
var DropdownMenu = require("./DropdownMenu");
var Nav = require("./Nav");
var Modal = require("./Modal");
var Panel = require("./Panel");

var Api = require("../api");

var UserManagePanel = require("./UserManagePanel");
var StuffManagePanel = require("./StuffManagePanel");

module.exports = React.createClass({
	
	getInitialState: function() {
		return {
			logedIn: false,
			username: "",
			password: "",
			panel: "user",
			activeMenu: "user"
		}	
	},
	
	render: function() {
		
		return <div id="page">
			{this.renderContent()}
		</div>
	},
	
	
	renderContent: function() {
		if ( this.state.logedIn ) {
			return <div className="row">
				<div className="col-sm-2">
					<Button block={true} style="primary" onClick={this.handleMenuClick} active={this.state.activeMenu == "user"} dataName="user">用户管理</Button>
					<Button block={true} style="primary" onClick={this.handleMenuClick} active={this.state.activeMenu == "stuff"} dataName="stuff">物资管理</Button>
				</div>
				<div className="col-sm-10">
					{this.renderPanel()}
				</div>
			</div>
		} else {
			var heading = <h2 className="text-center">超级管理员登录</h2>;
			var body = <Form colLabel="col-xs-3" colMain="col-xs-9">
				<Input id="username" lable="用户名" type="text" placeholder="请输入用户名" changeHandler={this.onUsernameChange} initialValue={this.state.username}/>
				<Input id="password" lable="密码" type="password" placeholder="请输入密码" changeHandler={this.onPasswordChange} initialValue={this.state.password}/>
			</Form>;
			var footer = <Button style="primary" onClick={this.handleLoginClick}>登录</Button>;
			return <div className="row">
					<Panel style="primary" className="col-sm-6 col-sm-offset-3 login-panel" heading={heading} body={body} footer={footer}>
				</Panel>
			</div>
		}
	},
	
	renderPanel: function() {
		switch( this.state.panel ) {
			case "stuff":
				return <StuffManagePanel />
			default:
				return <UserManagePanel />
		}
	},
	
	onUsernameChange: function(evt) {
		this.setState({
			username: evt.target.value
		})
	},
	
	onPasswordChange: function(evt) {
		this.setState({
			password: evt.target.value
		})
	},
	
	handleMenuClick: function(evt) {
		if ( evt ) {
			var name = evt.currentTarget.dataset.name;
			this.setState({
				panel: name,
				activeMenu: name
			});
		}
	},
	
	handleLoginClick: function(evt) {
		evt.preventDefault();
		var data = {
			username: this.state.username,
			password: this.state.password
		}
		Api.post("admin", {m: "login"}, data, function(json) {
			if ( json.errno == 0 ) {
				this.setState({
					logedIn: true
				})
			}	else {
				alert( json.errmsg );
			}
		}.bind(this))
	}
});