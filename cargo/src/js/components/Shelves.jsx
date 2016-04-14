var React = require("react");
var Menu = require("./Menu");
var GoodsList = require("./GoodsList");
var SearchBar = require("./SearchBar");
var AskForNewPanel = require("./AskForNewPanel");
var Reflux = require("reflux");
var Actions = require("../actions");
var CategoryStore = require("../stores/category-store");
var StockInNew = require("./StockInNew");
var CategoryManagePanel = require("./CategoryManagePanel");
var Api = require("../utils/api");

module.exports = React.createClass({
  mixins: [
    Reflux.listenTo(CategoryStore, 'onCategoryUpdate')
  ],
  getInitialState: function () {
    return {
      categories: [],
      currentCategory: 0,
      searchMode: false,
      searchKey: ""
    }
  },

  componentWillMount: function () {
    var timestamp, nonceStr, signature;
    
    Actions.getCategories(this.props.type);
    Api.post("api/public/jssdk", null, null, function(json) {
      if ( json.errno == 0 ) {
        timestamp = json.data.timestamp;
        nonceStr = json.data.noncestr;
        signature = json.data.signature; 
				appId = json.data.appId;
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: appId, // 必填，公众号的唯一标识
            timestamp: timestamp, // 必填，生成签名的时间戳
            nonceStr: nonceStr, // 必填，生成签名的随机串
            signature: signature,// 必填，签名，见附录1
            jsApiList: ["chooseImage","uploadImage"] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        });
      } else {
        alert(json.errmsg); 
      }
    })
    
    
  },
  
  componentWillReceiveProps: function(nextProps) {
    if ( nextProps.type !== this.props.type ) {
      Actions.getCategories(nextProps.type)
    }
  },

  render: function () {
    var menuItems = this.state.categories.concat({
      name: this.props.client == "user" ? "新品申请" : "新增物资",
      id: "new",
      highlight: true
    });
    if ( this.props.client == "manager" ) {
      menuItems = menuItems.concat({
        name: "分类管理",
        id: "cat_mng",
        highlight: true
      })
    }
    return <div className="shelves">
      <Menu items={menuItems} itemClickHandler={this.handleMenuClick} classes={this.state.searchMode? "freeze" : ""}
            current={[this.state.currentCategory]}/>
      {this.renderRight()}
    </div>
  },

  renderRight: function () {
    if (this.state.currentCategory == "new") {
      var create;
      if ( this.props.client == "user" ) {
        create = <AskForNewPanel type={this.props.type} />;
      } else if ( this.props.client == "manager" ) {
         create = <StockInNew type={this.props.type} categories={this.state.categories} />
      }
      return <div>
        {create}
      </div>
    } else if ( this.state.currentCategory == "cat_mng" ) {
      return <div>
        <CategoryManagePanel cats={this.state.categories} type={this.props.type} />
      </div>
    } else {
      return <div>
        <SearchBar changeHandler={this.handleSearchBarChange} value={this.state.searchKey}/>
        <GoodsList category={this.state.currentCategory} categoryList={this.state.categories} searchKey={this.state.searchKey} type={this.props.type} client={this.props.client}/>
      </div>
    }
  },

  handleMenuClick: function (catId) {
    this.setState({
      currentCategory: catId,
      searchMode: false,
      searchKey: ""
    });
  },

  handleSearchBarChange: function (value) {
    if (value) {
      this.setState({
        searchMode: true,
        searchKey: value
      });
    } else {
      this.setState({
        searchMode: false,
        searchKey: ""
      });
    }
  },
  
  onCategoryUpdate: function (data) {
    this.setState({
      categories: data
    }, function() {
      this.setState({
        currentCategory: ( this.state.categories && this.state.categories.length > 0 ) ? this.state.categories[0].id : 0
      });
    }.bind(this));
  }

});