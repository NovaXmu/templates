var React = require('react')
var Nav = require('../Nav/Nav')
var UserPanel = require('../UserPanel/UserPanel');
var GameSec = require('../GameSec/GameSec');
var RecordSec = require('../RecordSec/RecordSec');
var InspectSec = require('../InspectSec/InspectSec');
var Api = require('../../utils/api');

module.exports = React.createClass({

  getInitialState: function() {
    return {
      userInfo: {}
    };
  },

  componentDidMount: function() {
    this.getInfo()
  },

  getInfo: function() {
    Api.get("api/user/participant?m=getUserInfo", null, function(json) {
      if (json.errno == 0) {
        if (!json.data) {
          alert("用户信息出错")
          return;
        }
        this.setState({
          userInfo: json.data
        })
      } else {
        alert(json.errmsg)
      }
    }.bind(this))

  },

  render: function() {
    return <div id="app">
      <div id="header">易抢票</div>
      <UserPanel userInfo={this.state.userInfo} onInfoUpdate={this.getInfo}/>
      {this.renderContent()}
      <div className="content-mask mask"></div>
      <Nav userInfo={this.state.userInfo} />
    </div>
  },

  renderContent: function() {
    switch(this.props.params.section) {
      case 'game':
        return this.renderGameSec();
        break;
      case 'record':
        return this.renderRecordSec();
        break;
      case 'inspect':
        return this.renderInspectSec();
        break;
    }
  },

  renderGameSec: function() {
    return <GameSec />
  },

  renderRecordSec: function() {
    return <RecordSec />
  },

  renderInspectSec: function() {
    return <InspectSec />
  }

  
})