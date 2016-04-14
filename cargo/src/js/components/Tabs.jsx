var React = require("react");
var ReactRouter = require("react-router");
var Link = ReactRouter.Link;

module.exports = React.createClass({
    render: function() {
        return <div className={(this.props.className || "") + " tabs"}>
            <ul>
                {this.makeList()}
            </ul>
        </div>
    },

    makeList: function() {
        var style = {
            width: (100 / this.props.tabList.length) + "%"
        };
        return this.props.tabList.map(function(tab,i) {
            return <li className="tab" key={i} style={style}>
                <Link to={this.props.path + ( this.props.route ? tab.value : "" )} 
                      activeClassName={ this.props.route ? "active" : "" }
                      data-value={tab.value}
                      onClick={this.onTabClick}
                      className={ this.props.currentTab == tab.value ? "active" : "" }>{tab.name}</Link>
            </li>
        }.bind(this));
    },
    
    onTabClick: function(event) {
      if ( this.props.tabClickHandler ) {
        this.props.tabClickHandler(event);
      }
    }
});