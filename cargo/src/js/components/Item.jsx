var React = require("react");
var Reflux = require("reflux");
var Api = require("../utils/api");
var Actions = require("../actions");

var Tools = require("../utils/tools");
var Op = require("./Op");
var CartStore = require("../stores/cart-store");
var Item_Cart_Op = require("../utils/item_cart_op");
var HorizontalForm = require("./HorizontalForm");
var ContentEditable = require("./ContentEditable");
var Modal = require("./Modal");
var _ = require("lodash");

module.exports = React.createClass({
	mixins: [
		Tools,
		Item_Cart_Op,
		Reflux.listenTo(CartStore, "onCartUpdate")
	],
	getInitialState: function() {
		return {
			name: this.props.name,
			need_buy: false,
			amount_take: 0,
			amount_buy: 0,
			real_borrow_days: 1,
			categoryId: this.props.category,
			room: this.props.room,
			location: this.props.location,
			amount: this.props.amount,
			stockInAmount: 1,
			picUrl: this.props.picUrl,
			showModal: false,
			showDelConfirmModal: false
		};
	},
	
	componentWillReceiveProps: function(nextProps) {
		if ( nextProps.picUrl !== this.props.picUrl ) {
			this.setState({
				picUrl: nextProps.picUrl
			})
		}
	},

	componentDidUpdate: function(prevProps, prevState) {
		var data = {};
		if ( this.state.name && prevState.name != this.state.name ) {
			data.name = this.state.name;
		}

		if ( this.state.room && prevState.room != this.state.room ) {
			data.room = this.state.room;
		}

		if ( this.state.location && prevState.location != this.state.location ) {
			data.location = this.state.location;
		}

		if ( this.state.categoryId && prevState.categoryId != this.state.categoryId ) {
			data.category_id = this.state.categoryId;
		}
		if (Object.getOwnPropertyNames(data).length == 0) return;
		data.item_id = this.props.id;
		Api.post("api/admin/item", {m: "modify"}, data, function(json) {
			if (json.errno == 0) {
				if ( this.props.onUpdate ) {
					this.props.onUpdate();
				}
			} else {
				alert(json.errmsg);
			}
		}.bind(this))
	},

	delete: function(evt) {
		var data = {
			item_id: this.props.id,
			deleted: 1
		}
		Api.post("api/admin/item", {m: "modify"}, data, function(json) {
			if (json.errno == 0) {
				if ( this.props.onUpdate ) {
					alert("已成功删除");
					this.props.onUpdate();
				}
			} else {
				alert(json.errmsg);
			}
		}.bind(this))
	},
	
	render: function() {
		var picModal = <Modal isOpen={this.state.showModal} onRequestClose={this.closeModal}>
			<img className="pic-show" src={this.state.picUrl} />
		</Modal>

		var delConfirmModal = <Modal isOpen={this.state.showDelConfirmModal} onRequestClose={this.closeDelConfirmModal}>
			<p>确定要从数据库里删除该物品相关的所有信息吗？</p>
			<div className="btn-wrap">
				<button onClick={this.delete}>确定</button>
				<button onClick={this.closeDelConfirmModal}>取消</button>
			</div>
		</Modal>

		var name = this.props.client == "manager" ? (<ContentEditable html={this.state.name} className="item-name" onChange={this.handleItemNameChange} />) 
																							: (<h3>{this.state.name}</h3>);
		return <li className="item" data-id={this.props.id}>
			<section className="clearfix">
				{this.renderPicture()}
				<div className="info">
					{name}
					<p className="remain">剩余数量<em>{this.props.amount}</em></p>
					{this.props.client == "manager" ? this.renderCatChanger() : null}
					{this.props.client == "user" ? this.renderOps() : null}
				</div>
			</section>
			{this.props.client == "manager" ? this.renderToStock() : null}
			{picModal}
			{delConfirmModal}
		</li>
	},

	closeDelConfirmModal: function(evt) {
		evt.preventDefault();
		this.setState({
			showDelConfirmModal: false
		})
	},

	openDelConfirmModal: function(evt) {
		
		this.setState({
			showDelConfirmModal: true
		})
	},

	renderCatChanger: function() {
		var catOpts = this.props.categoryList.map(function(cat) {
			return {
				value: cat.id,
				text: cat.name
			}
		});
		var row = [{
				type: "select",
				options: catOpts,
				properties: {
					value: this.state.categoryId
				},
				handleChange: function(event) {
					this.setState({
						categoryId: event.target.value
					})
				}.bind(this)
			}]
		return <HorizontalForm rows={row} />
	},

	handleItemNameChange: function(evt) {
		this.setState({
			name: evt.target.value
		})
	},
	
	onModalClickBtnClicked: function() {
		this.setState({
			showModal: false
		})
	},
	
	renderPicture: function() {
		var style = {
			backgroundImage: "url('" + this.state.picUrl + "')"
		}
		return <div className="pic" style={this.state.picUrl ? style : null}  onClick={this.onImgClick}></div>
	},
	
	onImgClick: function() {
		if ( this.props.client == "manager" ) {
			// var input = this.refs.upload;
			// input.click();
			//alert("如果你看到这个，说明不是缓存的原因");
			wx.chooseImage({
				count: 1, // 默认9
    		sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
    		sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				success: function (res) {
					var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
					wx.uploadImage({
							localId: localIds[0], // 需要上传的图片的本地ID，由chooseImage接口获得
							isShowProgressTips: 1, // 默认为1，显示进度提示
							success: function (res) {
									var serverId = res.serverId; // 返回图片的服务器端ID
									var data = {
										item_id: this.props.id,
										media_id: serverId,
										type: "item"
									}
									
									Api.post("api/admin/item", {m: "picFromWechat"}, data, function(json) {
										if ( json.errno == 0 ) {
											alert("上传成功");
											Actions.getItemsInCategory();
											if ( this.state.picUrl ) {
												this.setState({
													picUrl: this.state.picUrl + "?v=" + new Date().valueOf()
												})
											}
										} else {
											alert( json.errmsg );
										}
									}.bind(this))
							}.bind(this)
					});
				}.bind(this)
			});
		} else {
			if ( this.state.picUrl ) {
				this.setState({
					showModal: !this.state.showModal
				})
			}
		}
	},
	
	closeModal: function() {
    this.setState({showModal: false});
  },
	
	renderOps: function() {
		var op_2 = this.state.need_buy ? this.renderBuy() : this.renderBuyConfirm();
		var op_3 = this.props.type == 1 && (Number(this.state.amount_take) + Number(this.state.amount_buy) > 0) ? this.renderBorrowDaysOp() : null;
		return <div className="ops">
			<section data-type="take">
				{this.props.type == 0 ? "申领" : "借用"}
				<Op min={0} max={this.props.amount} onMax={this.onTakeAmountMax} num={this.state.amount_take} onNumChange={this.onTakeAmountChange} />
			</section>
				{op_2}
				{op_3}
		</div>
	},
	
	renderBuyConfirm: function() {
		return <div className="to-buy">
				<a href="#" onClick={this.showBuyOp}>补购</a>
		</div>
	},
	
	renderBuy: function() {
		return <section data-type="buy">
				补购
				<Op min={0} num={this.state.amount_buy} onNumChange={this.onBuyAmountChange} />
			</section>
	},
	
	renderToStock: function() {
		var formRows = [
			{
				label: "所属仓库",
				type: "input-text",
				properties: {
					value: this.state.room
				},
				handleChange: function(evt) {
					this.setState({
						room: evt.target.value
					})
				}.bind(this)
			},
			{
				label: "具体位置",
				type: "contentEditable",
				html: this.state.location,
				handleChange: function(evt) {
					this.setState({
						location: evt.target.value
					})
				}.bind(this)
			},
			{
				label: "入库数量",
				type: "input-num",
				properties: {
					value: this.state.stockInAmount
				},
				handleChange: function(evt) {
					this.setState({
						stockInAmount: evt.target.value
					})
				}.bind(this)
			}
		];
		return <div className="to-stock">
			<HorizontalForm flexRatio={1.5} rows={formRows} />
			<div className="btn-wrap">
				<button onClick={this.stockIn}>入库</button>
				<button onClick={this.openDelConfirmModal}>删除</button>
			</div>
		</div>
	},
	
	stockIn: function() {
		var data = {
			item_id: this.props.id,
			amount: this.state.stockInAmount
		}
		Api.post('api/admin/item', {m: "addAmount"}, data, function(json) {
			if ( json.errno == 0 ) {
				alert("已成功入库~");
				if ( this.props.onUpdate ) {
					this.props.onUpdate();
				}
			} else {
				alert( json.errmsg );
			}
		}.bind(this));
	},
	
	showBuyOp: function(event) {
		event.preventDefault();
		if ( this.state.amount_take < this.props.amount ) {
			alert( ( this.props.type == 0 ? "申领" : "借用" ) + "数量未达上限，无需补购");
			return;
		}
		this.setState({need_buy: true});
	},

	renderBorrowDaysOp: function() {
		return <section data-type="brw-days">
			天数
			<Op min={1} num={this.state.real_borrow_days} max={this.props.borrow_days} onMax={this.onBorrowDayMax} onNumChange={this.onBorrowDayChange} />
		</section>
	}

});