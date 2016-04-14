var React = require('react');
var Api = require('../../utils/api');

module.exports = React.createClass({

  getInitialState: function() {
    return {
      show: false,
      name: this.props.userInfo.realName,
      college: this.props.userInfo.college,
      phone: this.props.userInfo.telephone,
      identity: this.props.userInfo.identity,
      grade: this.props.userInfo.grade,
      sex: this.props.userInfo.sex,
      incomplete: false,
      confirmMode: false,
      colleges: [],
      disableName: false,
      disableCollege: false,
      disabledIdentity: false,
      disabledGrade: false,
      disabledSex: false
    };
  },

  componentDidMount: function() {
    this.getColleges()
    this.checkInfoComplete(this.props.userInfo.id, this.props.userInfo);
  },

  componentWillReceiveProps: function(nextProps) {
    if (nextProps.userInfo != this.props.userInfo) {
      this.checkInfoComplete(nextProps.userInfo.id, nextProps.userInfo);
      this.setState({
        name: nextProps.userInfo.realName,
        college: nextProps.userInfo.college,
        phone: nextProps.userInfo.telephone,
        identity: nextProps.userInfo.identity,
        grade: nextProps.userInfo.grade,
        sex: nextProps.userInfo.sex
      })
    }
  },

  getColleges: function() {
    Api.get("api/public/xmu?m=getColleges", null, function(json) {
      if (json.errno == 0) {
        var arr = [""];
        arr = arr.concat(json.data)
        arr.push("机关部处")
        this.setState({
          colleges: arr
        })
        if (!this.state.college) {
          this.setState({
            college: arr[0]
          })
        }
      } else {
        alert(json.errmsg)
      }
    }.bind(this))
  },

  checkInfoComplete: function(id, userInfo) {
    this.setState({
      incomplete: (id && !userInfo.college) || (id && !userInfo.telephone) || (id && !userInfo.realName) || (id && !userInfo.sex) || (id && !userInfo.grade) || (id && !userInfo.identity),
      disableName: !!userInfo.realName,
      disableCollege: !!userInfo.college,
      disabledIdentity: !!userInfo.identity,
      disabledGrade: !!userInfo.grade,
      disabledSex: !!userInfo.sex
    })
  },

  render: function() {
    return <div className={"user-panel " + (this.state.show ? 'show': '') + " " + (this.props.userInfo.isAdmin == 1? "admin" : "") + " " + (this.state.incomplete ? "incomplete" : "")}>
      <div className="top">
        <div className="icon">{this.props.userInfo.isAdmin == 1? "管理员" : "用户"}</div>
        <div className="burger" onClick={this.toggleContent}> 
          <div></div>
          <div></div>
          <div></div>
          {/*this.state.incomplete ? <i>!</i> : null*/}
        </div>
      </div>
      {this.renderPanel()}
    </div>
  },

  renderPanel: function() {
    return <div className="content">
      {this.state.incomplete ? <p className="warning">请补充完整信息再抢票</p> : ""}
      <div className="container">
        <h3>个人信息</h3>
        <p>姓名：<input type="text" value={this.state.name} disabled={this.state.disableName} onChange={this.onNameChange} /></p>
        <p>性别：<input type="radio" checked={this.state.sex == "男"} onClick={this.onSexMaleChange} disabled={this.state.disabledSex}/>男
                 {"\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0"}
                 <input type="radio" checked={this.state.sex == "女"} onClick={this.onSexFemaleChange} disabled={this.state.disabledSex}/>女
        </p>
        <p>学号：{this.props.userInfo.xmuId}</p>
        <p>学院：<select value={this.state.college} disabled={this.state.disableCollege} onChange={this.onCollegeChange}>
          {this.renderCollegeList()}
        </select></p>
        <p>年级：<input type="number" value={this.state.grade || new Date().getFullYear()} disabled={this.state.disabledGrade} onChange={this.onGradeChange} /></p>
        <p>身份：<select value={this.state.identity} disabled={this.state.disabledIdentity} onChange={this.onIdentityChange}>
          <option value=""></option>
          <option value="本科生">本科生</option>
          <option value="研究生">研究生</option>
          <option value="博士生">博士生</option>
          <option value="教工">教工</option>
        </select></p>
        <p>电话：<input type="text" value={this.state.phone} onChange={this.onPhoneChange} /></p>
        <p>{this.state.confirmMode ? (<button className="confirm-btn" onClick={this.modify}>再点一次，确认修改</button>) : (<button onClick={this.toConfirm}>修改</button>)}</p>
      </div>
      {"* 姓名、性别、学院、年级、身份一经填写无法再次修改，如需修改，请联系厦大易班客服"}
    </div>
  },

  renderCollegeList: function() {
    return this.state.colleges.map(function(college, i) {
      return <option value={college} key={i}>{college}</option>
    })
  },

  toConfirm: function(evt) {
    evt.stopPropagation();
    this.setState({
      confirmMode: true
    })
  },

  modify: function(evt) {
    evt.stopPropagation();
    if (!this.state.name || !this.state.college || !this.state.identity || !this.state.grade || !this.state.sex) {
      alert("信息不完整!");
      return;
    }
    var data = {
      realName: this.state.name,
      college: this.state.college,
      telephone: this.state.phone,
      identity: this.state.identity,
      grade: this.state.grade,
      sex: this.state.sex
    }

    Api.post("api/public/participant", {m: "modifyUserInfo"}, data, function(json) {
      if (json.errno == 0) {
        alert("修改成功！");
        this.props.onInfoUpdate();
      } else {
        alert(json.errmsg);
      }
      this.setState({
        confirmMode: false
      })
    }.bind(this))
  },

  onNameChange: function(evt) {
    this.setState({
      name: evt.target.value
    })
  },

  onSexMaleChange: function(evt) {
    this.setState({
      sex: "男"
    })
  },

  onSexFemaleChange: function(evt) {
    this.setState({
      sex: "女"
    })
  },

  onGradeChange: function(evt) {
    this.setState({
      grade: evt.target.value
    })
  },

  onCollegeChange: function(evt) {
    this.setState({
      college: evt.target.value
    })
  },

  onIdentityChange: function(evt) {
    this.setState({
      identity: evt.target.value
    })
  },

  onPhoneChange: function(evt) {
    this.setState({
      phone: evt.target.value
    })
  },

  toggleContent: function() {
    if (this.state.show) {
      this.setState({
        confirmMode: false
      })
      document.querySelector(".content-mask").style.display = "none";
    } else {
      document.querySelector(".content-mask").style.display = "block";
    }
    this.setState({
      show: !this.state.show
    })
  }
})