var React = require("react");
var Shelves = require("./Shelves");
var SecManage = require("./SecManage");


module.exports = React.createClass({
    getInitialState: function() {
      return {
        show: false,
        block: false
      }
    },

    componentDidMount: function() {
      this.setState({
        block: true
      });
      setTimeout(function() {
        this.setState({
          show: true
        });
      }.bind(this), 100);
    },
    
    componentDidUpdate: function(prevProps, prevState) {
//      if ( prevProps.section != this.props.section ) {
//        this.setState({
//          block: false
//        });
//        setTimeout(function() {
//          this.setState({
//            show: false
//          });
//        }.bind(this), 0);
//      }
//      
//      if ( !this.state.show && !this.state.block ) {
//        this.setState({
//          block: true
//        });
//        setTimeout(function() {
//          this.setState({
//            show: true
//          });
//        }.bind(this), 100);
//        
//      }
        // setTimeout(function() {
        //   alert(this.state.show)
        // }.bind(this), 50)
    },
	
    render: function() {
      return <div id="main-content"  className={ (this.state.show ? " show " : "") + (this.state.block ? " block " : "") }>
        {this.renderSection()}
      </div>
    },
    renderSection: function() {
        switch(this.props.section) {
            case "take":
                return <Shelves type={0} client="user" />;
            case "borrow":
                return <Shelves type={1} client="user" />;
            case "manage":
                return <SecManage />;
            default:
                return <Shelves type={0} client="user" />;
        }
    }
});