var React = require("react");
var HorizontalForm = require("./HorizontalForm");
var Api = require("../utils/api");

module.exports = React.createClass({
	getInitialState: function() {
		return {
			phone: ""
		}
	},
	
	
	render: function() {
		var formRows = [
			{
				type: "input-text",
				properties: {
					value: this.state.phone,
					placeholder: "请输入手机号"
				},
				handleChange: function(evt) {
					this.setState({
						phone: evt.target.value
					});
				}.bind(this)
			}
		];
		return <div id="linkin-page">
			<h2>账号绑定</h2>
			<div id="linkin">
				<HorizontalForm rows={formRows} flexRatio={null} />
				<div className="btn-wrap">
					<button onClick={this.onLinkinSubmit}>绑定</button>
				</div>
			</div>
		</div>
	},
	
	onLinkinSubmit: function() {
		var data = {
			mobile_phone: this.state.phone
		}
		Api.post("api/public/linkin", null, data, function(json) {
			if ( json.errno == 0 ) {
        alert("欢迎你，" + json.data.name);
				window.location = "/templates/cargo/dist/index.html";
			} else {
				alert(json.errmsg);
			}
		});
	}
});