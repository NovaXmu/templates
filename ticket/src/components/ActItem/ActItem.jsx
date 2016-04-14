var React = require('react');
var ProcessBar = require('../ProcessBar/ProcessBar')
var Action = require('../../action');
var Api = require('../../utils/api');
var interval;
window.countdownInterval = null;
module.exports = React.createClass({

  getInitialState: function() {
    return {
      active: false,
      showDetail: false,
      countdown: "0 day 00:00:00",
      stage: -1, //-1活动前，0活动中，1活动后
      result: this.props.result || "未参与", //"未参与","票据已使用","已抢中","已退票","未抢中"
      token: this.props.accessToken,
      usedTimes: this.props.userUsedTimes || 0,
      process: 0,
      countdownInterval: 0,
      processInterval: 0,
      content:"",
      handAnimation: false,
      allowAction: true,
      failMessage: ""
    };
  },

  componentDidMount: function() {
    this.countdown();
  },

  componentWillUnmount: function() {
    clearInterval(this.state.countdownInterval)  
  },

  render: function() {
    return <div className={"act-item" + " " + (this.state.active ? "active" : null)} onClick={this.onItemClicked}>
      <header>{this.props.name}</header>
      <div className="body clearfix">
        {this.renderCountdownSec()}
        <section className="clearfix">
          <div className="left">
            开抢时间：
            <p>{this.props.startTime}</p>
          </div>
          <div className="center">至</div>
          <div className="right">
            停抢时间：
            <p>{this.props.endTime}</p> 
          </div>
        </section>
        <section className="clearfix">
          <ProcessBar ratio={this.state.stage == -1 ? 1 : (this.props.leftTickets != undefined ?  this.props.leftTickets : this.props.total) / this.props.total} />
                    {"余票" + (this.state.stage == -1 ? this.props.total : (this.props.leftTickets != undefined ?  this.props.leftTickets : this.props.total)) + "张"}
        </section>
        <section className={"detail " + (this.state.showDetail ? "" : "hide")} dangerouslySetInnerHTML={this.contentHtml()}>
        </section>
      </div>
      <footer>
        {this.renderTimes()}
        { this.state.stage == -1 ? this.notStartedYet() : this.showResult()}
      </footer>
    </div>
  },

  notStartedYet: function() {
    return <button className="disabled">未开抢</button>
  },

  renderTimes: function() {
    return <div className="times">
      <div className={"hand " + (this.state.handAnimation ? "ani" : "")}></div>
      X {this.props.times - this.state.usedTimes}
    </div>
  },

  contentHtml: function() {
    return {
      __html: this.state.content
    }
  },

  showButton: function() {
    if (this.state.process == 0) {
      return <button onClick={this.play}>抢票</button>
    } else {
      return <button className="onprocess">抢票中... {/*{this.state.process * 100 + "%"}*/}</button>
    }
  },

  showResult: function() {
    var success = (<div className="success">
        <h3>抢票成功！</h3>
        <p className="token">{"兑换密钥：" + this.formatToken(this.state.token)}</p>
        <p>具体取票地点请点击查看活动详情</p>
      </div>);

    if (this.state.result == "未参与") {
      if  (this.props.leftTickets == 0) {
        return <div className="failure">
          <h3>票被抢完了</h3>
          <p>你可以关注首页其他抢票活动</p>
        </div>
      } else {
        return this.showButton();
      }
    } else if (this.state.result == "票据已使用" || this.state.result == "已抢中") {
      return success;
    } else if (this.state.result == "已退票") {
      if (this.state.usedTimes < this.props.times) {
        if  (this.props.leftTickets == 0) {
          return <div className="failure">
            <h3>票被抢完了</h3>
            <p>你可以关注首页其他抢票活动</p>
          </div>
        } else {
          return this.showButton();
        }
      } else {
        return this.renderFailure();
      }
    } else if (this.state.result == "未抢中") {
      return this.renderFailure();
    } else {
      return null;
    }

  },

  renderFailure: function() {
    var btn;
    if (this.state.process == 0) {
      btn = <button onClick={this.play}>再抢一次</button>
    } else {
      btn = <button className="onprocess">抢票中... {/*{this.state.process * 100 + "%"}*/}</button>
    }
    if (this.state.failMessage) {
      if (this.state.failMessage == "没抢中") {
        //还有机会
        return <div className="failure">
          <h4>{this.state.failMessage}</h4>
          {btn}
        </div>
      } else {
        return <div className="failure">
          <h3>抢票失败<br />{this.state.failMessage}</h3>
          <p>你可以关注首页其他抢票活动</p>
        </div>
      }
    } else {
      if (this.state.usedTimes < this.props.times) {
        //还有机会
        return <div className="failure">
          <h4>上次抢票失败！</h4>
          {btn}
        </div>
      } else {
        return <div className="failure">
          <h3>抢票失败<br />可抢次数已用完</h3>
          <p>你可以关注首页其他抢票活动</p>
        </div>
      }
    }
  },

  formatToken: function(t) {
    if (!t) return "无";
    return t.substr(0,4) + " " + t.substr(4,4) + " " + t.substr(8,4) + " " + t.substr(12, 4);
  },

  renderCountdownSec: function() {
    switch(this.state.stage) {
      case -1:
        return <section>
          <p>距离抢票开始还有：</p>
          <span>{this.state.countdown}</span>
        </section>
      case 0:
        return <section>
          <p>距离抢票结束还有：</p>
          <span>{this.state.countdown}</span>
        </section>
      case 1:
        return <section>
          <span>活动已结束</span>
        </section>
    }
  },

  loseChance: function() {
    this.setState({
      handAnimation: true,
      usedTimes: this.state.usedTimes+1
    })

    setTimeout(function() {
      this.setState({
        handAnimation: false
      })
    }.bind(this), 1000)
  },

  action: function() {
    if (!this.state.allowAction) return;
    Api.post("api/user/participant", {m: "ticket"}, {actID: this.props.actID}, function(json) {
      if (json.errno == 0) {
        this.setState({
          result: "已抢中",
          token: json.data
        })
      } else {
        this.setState({
          result: "未抢中",
          failMessage: json.errmsg
        })
      }
      clearInterval(this.state.processInterval)
      this.setState({
        process: 0,
        allowAction: true
      })
      this.loseChance()
      Action.addNewRecordCount();
    }.bind(this))
  },

  play: function(evt) {
    var waitSec = 3;
    if (this.state.process > 0) {
      return;
    }
    this.setState({
      process: 1 / waitSec
    })
    var c = 2;
    interval = setInterval(function() {
      if (c > waitSec) {
        this.action()
        this.setState({
          allowAction: false
        })
      } else {
        this.setState({
          process: c / waitSec
        })
        c+=1
      }
    }.bind(this), 1000)
    this.setState({
      processInterval: interval
    })
    evt.stopPropagation();
  },

  onItemClicked: function() {
    this.state.content ? this.activate() : this.getContent();
  },

  getContent: function() {
    Api.get("api/user/participant", {m: "getTicketContent", actID: this.props.actID}, function(json) {
      if (json.errno == 0) {
        this.setState({
          content: json.data
        })
        this.activate()
      } else {
        alert(json.errmsg)
      }
    }.bind(this))
  },

  activate: function() {
    this.setState({
      active: !this.state.active
    })

    this.setState({
      showDetail: !this.state.showDetail
    })
  },

  countdown: function() {
    this.setNow();
    countdownInterval = setInterval(this.setNow, 1000);
    this.setState({
      countdownInterval: countdownInterval
    })
  },

  setNow: function() {
    //"1111-11-11T11:11:11"这种形式的字符串parse后会有时差，为标准时，与北京时间差8个小时
    var startTime = new Date(this.props.startTime.split(" ").join("T"));
    startTime = new Date(startTime.valueOf() - 8 * 60 * 60 * 1000);
    var endTime = new Date(this.props.endTime.split(" ").join("T"));
    endTime = new Date(endTime.valueOf() - 8 * 60 * 60 * 1000);

    var now = new Date();
    
    var targetDate = now > endTime ? null : (now >= startTime ? endTime : startTime);
    this.setState({
      stage: now > endTime ? 1 : (now >= startTime ? 0 : -1)
    })

    if (targetDate) {
      var millis = targetDate.valueOf() - now.valueOf();
      var days = Math.floor(millis / (24 * 60 * 60 * 1000));
      millis = millis % (24 * 60 * 60 * 1000);
      var hours = Math.floor(millis / (60 * 60 * 1000));
      millis = millis % (60 * 60 * 1000);
      var mins = Math.floor(millis / (60 * 1000));
      millis = millis % (60 * 1000);
      var seconds = Math.floor(millis / 1000);
      hours = hours <= 9 ? "0" + hours : hours;
      mins = mins <= 9 ? "0" + mins : mins;
      seconds = seconds <= 9 ? "0" + seconds : seconds;
      this.setState({
        countdown: days + (days > 1 ? " days " : " day ") + hours + ":" + mins + ":" + seconds
      })
    }
  }
})