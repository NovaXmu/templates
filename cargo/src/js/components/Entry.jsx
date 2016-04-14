var React = require("react");
var Api = require("../utils/api");
var UserInfoStore = require("../stores/user-info-store");
var Actions = require("../actions");

module.exports = React.createClass({
	componentWillMount: function() {
		Api.post('api/public/user', null, null, function(json) {
			if ( json.errmsg == "普通用户" ) {
				Actions.setUserInfo(0)
			} else {
				Actions.setUserInfo(1)
			}
      if ( json.errno == 1 ) {
        window.location = '/templates/cargo/dist/index.html#/linkin';
      } else {
				window.location = '/templates/cargo/dist/index.html#/home';
			}
    })
	},
	render: function() {
		return <div id="entry">
			<p className="msg">身份认证中...</p>
		</div>
	}
});