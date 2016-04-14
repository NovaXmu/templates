var React = require("react");
var ReactModal = require("react-modal");

module.exports = React.createClass({
  render: function() {
    const customStyles = {
      content : {
        top                   : '50%',
        left                  : '50%',
        right                 : 'auto',
        bottom                : 'auto',
        marginRight           : '-30%',
        padding               : '10px',
        transform             : 'translate(-50%, -50%)',
        WebkitTransform       : 'translate(-50%, -50%)'
      },
      overlay: {
        zIndex                : '11'
      }
    };
    var modal = <ReactModal
      style={customStyles}
      {...this.props} >
      {this.props.children}
    </ReactModal>

    return modal;
  }
})