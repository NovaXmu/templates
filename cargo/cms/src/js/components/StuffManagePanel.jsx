var React = require("react");
var Reflux = require("reflux");
var Panel = require("./Panel");
var Button = require("./Button");
var Nav = require("./Nav");
var Thumbnail = require("./Thumbnail");
var Actions = require("../actions");
var ItemStore = require("../stores/item-store");
var Api = require("../api");

module.exports = React.createClass({
	mixins: [
		Reflux.listenTo(ItemStore, "onStuffListUpdate")
	],
	getInitialState: function() {
		return {
			stuffType: "0",
			stuffs: [],
			toUpload: {},
			picUpdated: false
		}
	},
	
	componentDidMount: function() {
		Actions.getItemsInCategory();
	},
	
	componentDidUpdate: function(nextProps, nextState) {
		if ( this.state.stuffType != nextState.stuffType ) {
			Actions.getItemsInCategory();
		}
	},
	
	render: function() {
		var tabs = [
			{
				active: true,
				content: "申领"
			},
			{
				content: "借用"
			}
		]
		
		var body = <div>
			<Nav type="tab" items={tabs} justified={true} onSwitch={this.onNavSwitch}></Nav>
			<ul className="list-unstyled stuff-list row">
				{this.renderStuffs()}
			</ul>
		</div>
		
		return <Panel heading={this.renderPanelHeading()} body={body}></Panel>
	},
	
	renderPanelHeading: function() {
		return [<h2>
			物资管理
			<div className="sec-ops">
				<Button style="info" onClick={this.onExportClick}>数据导出</Button>
			</div>
		</h2>]
	},
	
	onExportClick: function() {
		window.open("/cargo/api/take?m=download" + (this.state.stuffType == 1 ? "&type=1" : ""));
	},
	
	renderStuffs: function() {
		return this.state.stuffs.map(function(stuff, i) {
			var pFooter = <div className="stuff-ops">
				<Button style="info">保存</Button>
			</div>
			//var pBody = 
			return <li key={i} className="col-sm-4" data-item-id={stuff.id}>
				<Thumbnail uploadEnabled={true} 
										label={stuff.name} 
										imgUrl={stuff.picUrl} 
										defaultImgUrl="/templates/cargo/cms/dist/img/image-upload-placeholder.jpg"
										newPic={this.state.picUpdated == stuff.id}
										onUploadChange={this.handleUploadChange}>
					{this.renderThumbnailFooter(stuff.id)}
				</Thumbnail>
			</li>
		}.bind(this))
	},
	
	renderThumbnailFooter: function(id) {
		if ( this.state.toUpload[id] ) {
			return <Button style={this.state.toUpload[id] ? "warning" : "info"} onClick={this.onUploadSubmit}>上传</Button>;
		} else return null;
	},
	
	onNavSwitch: function(activeIndex) {
		if ( activeIndex == 0 ) {
			this.setState({
				stuffType: "0"
			})
		} else if ( activeIndex == 1 ) {
			this.setState({
				stuffType: "1"
			})
		}
	},
	
	handleUploadChange: function(evt) {
		var file = evt.target.files[0];
		var li = $(evt.target).parents("li");
		var id = li.data("item-id");
		var data = {
			item_id: id,
			file: file
		}
		
		var n = this.state.toUpload;
		n[id] = data;
		this.setState({
			toUpload: n,
			picUpdated: false
		})
		
	},
	
	onUploadSubmit: function(evt) {
		var li = $(evt.target).parents("li");
		var id = li.data("item-id");
		
		var data = this.state.toUpload[id]
		if ( !data ) {
			return;
		}
		Api.upload("api/item", {m: "pic"}, data, function(json) {
			if ( json.errno == 0 ) {
				alert("上传成功");
				var n = this.state.toUpload;
				delete n[id];
				this.setState({
					toUpload: n,
					picUpdated: true
				}, function() {
					this.setState({
						picUpdated: id
					})
				}.bind(this))
				Actions.getItemsInCategory();
			} else {
				alert( json.errmsg );
			}
		}.bind(this))
	},
	
	onStuffListUpdate: function(itemsInCat) {
		var all = [];
		for ( var cat in itemsInCat ) {
			if ( itemsInCat[cat] && itemsInCat[cat].length > 0 ) {
				all = all.concat(itemsInCat[cat]);
			}
		}
		
		all = all.filter(function(item) {
			return item.type == this.state.stuffType
		}.bind(this));
		
		this.setState({
			stuffs: all
		})
	}
});