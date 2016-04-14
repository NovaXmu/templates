var React = require('react');
var Api = require('../../utils/api');

module.exports = React.createClass({
  getInitialState: function() {
    return {
      showContent: false
    };
  },
  render: function() {
    return <li className="inspect-item" onClick={this.onItemClicked}>
      <header>{this.props.name}</header>
      <p>联系电话：{this.props.owner}</p>
      <p>抢票方式：{this.props.chance == 100 ? "先到先得" : "随机抢票"}
        <br/>
        总票数：{this.props.total}
      </p>
      <p>
        开抢时间：{this.props.startTime}
        <br/>
        停抢时间：{this.props.endTime}
      </p>
      <p>
        抢票人数：{this.props.count}
        <br/>
        中奖人数：{this.props.resultCount}
      </p>
      <section className={this.state.showContent ? "" : "hide"} dangerouslySetInnerHTML={{__html: this.props.content}}></section>
      {this.renderFooter()}
    </li>
  },

  onItemClicked: function() {
    this.setState({
      showContent: !this.state.showContent
    })
  },

  renderFooter: function() {
    if (this.props.category == "needReview") {
      return <p className="footer btn-wrap">
        <span><button onClick={this.accept}>通过</button></span>
        <span><button onClick={this.refuse}>拒绝</button></span>
      </p>
    } else {
      return <p className="footer">
        <button onClick={this.rereview}>重审</button>
      </p>
    }
  },

  accept: function(evt) {
    evt.stopPropagation();
    var data = {
      actID: this.props.actID,
      isPassed: 1
    }
    this.review(data, function() {
      alert("已通过")
    })
  },

  refuse: function(evt) {
    evt.stopPropagation();
    var data = {
      actID: this.props.actID,
      isPassed: -1
    }
    this.review(data, function() {
      alert("已拒绝")
    })
  },

  rereview: function(evt) {
    evt.stopPropagation();
    var data = {
      actID: this.props.actID,
      isPassed: 0
    }
    this.review(data, function() {
      alert("已提交重审")
    })
  },

  review: function(data, onsuccess) {
    Api.post("api/admin/admin?m=review", null, data, function(json) {
      if (json.errno == 0) {
        onsuccess();
        this.props.onOp();
      } else {
        alert(json.errmsg)
      }
    }.bind(this))
  }
})