var React = require("react");

/*
	@prop Boolean uploadEnabled
	@prop String imgUrl
	@prop String label
	@prop String defaultImgUrl
	@prop Function onUploadChange([event])
	
	@children
*/

module.exports = React.createClass({
	render: function() {
		return <div className={"thumbnail " + (this.props.uploadEnabled ? "upload" : "")}>
			<div>
				{this.props.uploadEnabled ? <input type="file" accept=".jpg,.jpeg,.gif,.png" ref="upload" onChange={this.onUploadChange}/> : null}
      	<img src={this.props.imgUrl ? (this.props.newPic ? ( this.props.imgUrl + "?v=" + new Date().valueOf() ) : this.props.imgUrl ) : this.props.defaultImgUrl} onClick={this.onImgClick} />
			</div>
      <div className="caption">
        <h4>{this.props.label}</h4>
				{this.props.children}
      </div>
    </div>
	},
	
	onImgClick: function() {
		if ( this.props.uploadEnabled ) {
			var input = this.refs.upload;
			input.click();
		}
	},
	
	onUploadChange: function(evt) {
		if ( this.props.onUploadChange ) {
			this.props.onUploadChange(evt);
		}
	}
});