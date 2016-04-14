var React = require('react');
var ActItem = require('../ActItem/ActItem')
var Api = require('../../utils/api')

module.exports = React.createClass({
  getInitialState: function() {
    return {
      items: [],
      showTip: true,
      noitem: false,
      firstVisit: true 
    };
  },

  componentDidMount: function() {
    this.getItems();  
    this.markVisited()
  },

  getItems: function() {
    Api.get("api/user/participant?m=getTicketList", null, function(json) {
      if (json.errno == 0) {
        this.setState({
          items: json.data
        })
        if (json.data.length <= 0) {
          this.setState({
            noitem: true
          })
        }
      } else {
        alert(json.errmsg)
      }
    }.bind(this))
  },

  render: function() {
    return <div id="game-sec" className="section">
      {this.state.firstVisit && this.state.items.length >= 1 ? this.renderTip() : null}
      <ul>
        {this.renderItems()}
      </ul>
    </div>
  },

  renderItems: function() {
    if (this.state.noitem) {
      return <div className="no-item">暂时没有抢票活动，下次再来吧~</div>
    }
    return this.state.items.map(function(item,i) {
      return <ActItem key={i} {...item} />
    })
  },

  renderTip: function() {
    if (this.state.showTip) {
      return <div className="mask all" onClick={this.hideTip}>
        <img src="images/guide.png" />
      </div>
    }
  },

  hideTip: function() {
    this.setState({
      showTip: false
    })
  },

  markVisited: function() {
    if (!localStorage["m_game"]) {
      localStorage["m_game"] = true
    } else {
      this.setState({
        firstVisit: false
      })
    }
  }
})