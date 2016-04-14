var React = require("react");
var Reflux = require("reflux");
var Tabs = require("./Tabs");
var MainSecDispatcher = require("./MainSecDispatcher");
var Cart = require("./Cart");
var UserInfoStore = require("../stores/user-info-store");
var Actions = require("../actions");

module.exports = React.createClass({
  mixins: [
    Reflux.listenTo(UserInfoStore, "onUserInfoUpdate")
  ],
  getInitialState: function() {
    return {
      auth: 1
    }  
  },
  
  componentWillMount: function() {
    Actions.getUserInfo();
  },
  render: function() {
    var tabList = [
        {
            name: "物资申领",
            value: "take"
        },
        {
            name: "物资借用",
            value: "borrow"
        },
        {
            name: "管理者专区",
            value: "manage"
        }
    ]
     
    if ( this.state.auth == 0 ) {
      tabList.pop();
    }
		
		var style = this.state.masked ? {display: "none"} : {display: "block"};
    return <div id="page">
        <Tabs tabList={tabList} path={"section/"} route={true} />
        <MainSecDispatcher section={this.props.params.secName} maskSwitchHandler={this.onMaskSwitch} />
				<div id="mask"></div>
        {this.renderCart()}
    </div>
  },
  
  renderCart: function() {
    if ( this.props.params.secName == "manage" ) {
      return null;
    } else {
      return <Cart section={this.props.params.secName} />
    }
  },
  
  onUserInfoUpdate: function(auth) {
    this.setState({
      auth: auth
    })
  },
	
	onMaskSwitch: function() {
		
	}
});