var React = require("react");
var Tabs = require("./Tabs");
var ManagePanelDispatcher = require("./ManagePanelDispatcher");
var Tools = require("../utils/tools");

module.exports = React.createClass({
    mixins: [Tools],
    getInitialState: function() {
      return {
        currentSec: 1
      }
    },
    render: function() {
        return <div id="sec-manage">
        	<Tabs tabList={this.tabs} 
                path={"/section/manage/"} 
                route={false} 
                tabClickHandler={this.handleTabClick}
                className={"sub-tabs"}
                currentTab={1} />
          <ManagePanelDispatcher section={this.state.currentSec} />
        </div>
    },
    
    handleTabClick: function(evt) {
      evt.preventDefault();
      var target = evt.currentTarget;
      var ul = this.findAncestor(target, "ul");
      var links = this.findChildren(ul, "li.tab a");
      for ( var i = 0; i < links.length; i++ ) {
        var link = links[i];
        if ( this.hasClass( link, "active" ) ) {
          link.className = this.spliceString(link.className, link.className.indexOf("active"), 6);
        }
      }
      this.setState({
        currentSec: target.dataset.value
      });
      target.className += " active"
    },
		
		tabs: [
      {
        name: "申领入库",
        value: 1
      },
      {
        name: "借用入库",
        value: 2
      },
      {
        name: "订单管理",
        value: 3
      },
      {
        name: "贵重物品",
        value: 4
      }
    ]
});