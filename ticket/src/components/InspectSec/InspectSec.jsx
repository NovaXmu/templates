var React = require('react');
var InspectItem = require('../InspectItem/InspectItem');
var Api = require('../../utils/api');

module.exports = React.createClass({
  categories: [
    {m: "needReview", text: "待审核"},
    {m: "ready",      text: "即将开始"},
    {m: "onGoing",    text: "正在进行"},
    {m: "end",        text: "已结束"},
    {m: "notPassed",  text: "未通过"}
  ],

  getInitialState: function() {
    return {
      categories: [],
      currentCategory: "needReview",
      currentCategoryTxt: "待审核",
      showMenu: false,
      items: [],
      showTip: true,
      firstVisit: true,
      noitem: false
    };  
  },

  componentDidMount: function() {
    this.filterMenuOptions(this.state.currentCategory);
    this.getItems();
    this.markVisited()
  },

  componentDidUpdate: function(prevProps, prevState) {
    if (this.state.currentCategory != prevState.currentCategory) {
      this.getItems()
    }  
  },

  getItems: function() {
    Api.get("api/admin/admin",{m: this.state.currentCategory}, function(json) {
      if (json.errno == 0) {
        this.setState({
          items: json.data
        })
        this.setState({
          noitem: json.data.length <= 0
        })
      } else {
        alert(json.errmsg)
      }
    }.bind(this))
  },

  filterMenuOptions: function(except) {
    this.setState({
      categories: this.categories.filter(function(item) {
        return item.m != except;
      }.bind(this))
    })
  },

  render: function() {
    return <div id="inspect-sec" className="section">
      <div className={"menu " + (this.state.showMenu ? "show" : "")}>
        <h2 onClick={this.toggleMenu}>{this.state.currentCategoryTxt}</h2>
        {this.state.firstVisit && this.state.items.length >= 1 ? this.renderTip() : null}
        <ul>
          {this.state.showMenu ? this.renderMenuItems() : null}
        </ul>
      </div>
      <ul>
        {this.renderItems()}
      </ul>
    </div>
  },

  renderItems: function() {
    if (this.state.noitem) {
      return <div className="no-item">该类别下暂无活动</div>
    }
    return this.state.items.map(function(item,i) {
      return <InspectItem {...item} key={i} category={this.state.currentCategory} onOp={this.getItems}/>
    }.bind(this))
  },

  renderMenuItems: function() {
    return this.state.categories.map(function(item, i) {
      return <li data-m={item.m} onClick={this.onMenuChange} key={i}>{item.text}</li>
    }.bind(this))
  },

  toggleMenu: function() {
    this.setState({
      showMenu: !this.state.showMenu
    })
  },

  onMenuChange: function(evt) {
    this.setState({
      currentCategory: evt.target.dataset.m,
      currentCategoryTxt: evt.target.innerHTML
    })

    this.toggleMenu()

    this.filterMenuOptions(evt.target.dataset.m)
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
    if (!localStorage["m_review"]) {
      localStorage["m_review"] = true
    } else {
      this.setState({
        firstVisit: false
      })
    }
  }
})