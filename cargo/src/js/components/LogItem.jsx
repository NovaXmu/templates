var React = require("react");
var HorizontalForm = require("./HorizontalForm");
var Reflux = require("reflux");
var CategoryStore = require("../stores/category-store");
var Actions = require("../actions");
var Api = require("../utils/api");

module.exports = React.createClass({
	mixins: [
		Reflux.listenTo(CategoryStore, "onGotCategories")
	],
	getInitialState: function() {
		return {
			amountInputVal: this.props['apply_amount'],
			backtimeInputVal: this.props['back_time'],
			buyModifyMode: false,
			room: this.props['item_room'],
			location: this.props['item_location'],
			amount: this.props['apply_amount'],
			modifyModeItemType: -1,
			modifyModeCategoryOptions: [],
			modifyModeCategoryId: -1,
			modifyModeCreateNewCat: false,
			modifyModeNewCatName: ""
		}
	},
	
	/*props.['rq-type']: 1 ==> 补购，0 ==> 领取
		 props.['item_type']: 1 ==> borrow, 0 ==> take
	*/

	render: function() {
		var label = this.props.item_id == 0 ? "new" : (this.props['item_type'] == 1 ? "borrow" : "take");
		return <li className={"log-item" + " " + label}> 
			{this.props['rq-type'] == 0 ? this.renderGet() : this.renderBuy() }
		</li>
	},
	
	renderGet: function() {
	//GET--->管理用户领取
		switch ( this.props.dealt ) {
			case '0': //未处理
				return this.renderGetUndealt();
			case '1': //通过
				return this.renderGetDealt(true);
			case '-1': //拒绝
				return this.renderGetDealt(false);
		}
	},
	
	renderGetUndealt: function() {
		var times;
		//var now = new Date();
		//var nowStr = now.getFullYear() + "-" + (now.getMonth()+1) + "-" + now.getDate() + " " + now.getHours() + ":" + now.getMinutes();
		if ( this.props['item_type'] == 1 ) {
			times = <div>
				归还时间：
				<input type="datetime-local" value={this.state.backtimeInputVal} onChange={this.onBacktimeChange}/>
				{Modernizr && Modernizr.inputtypes['datetime-local'] ? "" : <p className="s-warning">检测到您的设备不支持内置的日期选择器，请手动输入如下格式日期：2015-12-30 12:59</p>}
			</div>
		}

		return <div className="undealt">
			<h2>{this.props['item_name']}</h2>
			<p className="amount">
				数量：
				<input type="number" value={this.state.amountInputVal} onChange={this.onAmountChange}/>
			</p>
			<p className="location">
				{this.props['item_room']}&nbsp;/&nbsp;{this.props['item_location']}
			</p>
			{times}
			<p className="user">{this.props['user_name']}</p>
			<p className="remark">备注：{this.props.remark || ""}</p>
			<div className="deal-btns">
				<button className="approve" onClick={this.handleGetApprove}>通过</button>
				<button className="refuse" onClick={this.handleGetRefuse}>拒绝</button>
			</div>
		</div>
	},
	
	onBacktimeChange: function(evt) {
		this.setState({
			backtimeInputVal: evt.target.value
		});
	},
	
	handleGetApprove: function() {
		var data = {
			log_id: this.props.id,
			real_amount: this.state.amountInputVal,
			dealt: 1
		}
		if (this.props.item_type == 1) {
			data.back_time = this.state.backtimeInputVal;
		}
		Api.post("api/take", null, data, function(json) {
			if ( json.errno == 0 ) {
				alert("成功通过该申请");
				this.props.onUpdate();
			} else {
				alert(json.errmsg);
			}
		}.bind(this));
	},
	
	handleGetRefuse: function() {
		var data = {
			log_id: this.props.id,
			dealt: -1
		}
		if (this.props.item_type == 1) {
			data.back_time = this.state.backtimeInputVal;
		}
		Api.post("api/take", null, data, function(json) {
			if ( json.errno == 0 ) {
				alert("成功拒绝该申请");
				this.props.onUpdate();
			} else {
				alert(json.errmsg);
			}
		}.bind(this));
	},
	
	renderGetDealt: function(approved) {
		var times;
		if ( this.props['item_type'] == 1 ) {
			times = <p>
				借用时间：
				{this.props['dealt_time']} ~ {this.state.backtimeInputVal}
			</p>
		}

		return <div className={approved ? "approved" : "refused" }>
			<h2>{this.props['item_name']}</h2>
			<p className="amount">
				数量：
				{this.props['real_amount']}
			</p>
			<p className="location">
				{this.props['item_room']}&nbsp;/&nbsp;{this.props['item_location']}
			</p>
			{ approved ? times : null }
			<p className="user">{this.props['user_name']}</p>
			<p className="remark">备注：{this.props.remark || ""}</p>
		</div>
	},
	
	renderBuy: function() {
		switch( this.props.dealt ) {
			case '0':
				return this.renderBuyUndealt();
			case '1':
				return this.renderBuyDealt(true);
			case '-1':
				return this.renderBuyDealt(false);
		}
	},
	
	renderBuyUndealt: function() {
		if ( !this.state.buyModifyMode ) {
		
			var location = this.props.item_id == 0 ? null : <p className="location">
				{this.props['item_room']}&nbsp;/&nbsp;{this.props['item_location']}
			</p>;
			
			return <div className="undealt">
				<h2>{this.props['item_name']}</h2>
				<p className="amount">
					数量：{this.state.amountInputVal}
				</p>
				{location}
				<p className="user">{this.props['user_name']}</p>
				<div className="deal-btns">
					<button className="approve" onClick={this.handleApproveAndModify}>入库</button>
					<button className="refuse" onClick={this.handleBuyRefuse}>拒绝</button>
				</div>
			</div>
			
		} else {
			return this.renderBuyMode();
		}
	},
	
	renderBuyMode: function() {
		if ( this.props.item_id == 0 ) {     //新品
			var basicFormRows = [
				{
					label: "物资名称",
					type: "plain-text",
					text: this.props['item_name']
				},
				{
					label: "申请模式",
					type: "select",
					placeholder: {
						value: "-1",
						text: "请选择"
					},
					options: [
						{
							value: 0,
							text: "申领"
						},
						{
							value: 1,
							text: "借用"
						}
					],
					properties: {
						value: this.state.modifyModeItemType == -1 ? "-1" : this.state.modifyModeItemType
					},
					handleChange: function(evt) {
						this.setState({
							modifyModeItemType: evt.target.value 
						}, function() {
							Actions.getCategories(this.state.modifyModeItemType);
						}.bind(this));
						
					}.bind(this)
				}
			];
			
			if ( this.state.modifyModeItemType != -1 ) {
				basicFormRows.push({
					label: "物资类别",
					type: "select",
					placeholder: {
						value: "-1",
						text: this.state.modifyModeItemType == -1 ? "请先选择申请模式" : "请选择"
					},
					options: this.state.modifyModeCategoryOptions || [],
					properties: {
						value: this.state.modifyModeCategoryId == -1 ? "-1" : this.state.modifyModeCategoryId
					},
					handleChange: function(event) {
						if ( event.target.value == "new" ) {
							this.setState({
								modifyModeCreateNewCat: true,
								modifyModeCategoryId: "new"
							})
						} else {
							this.setState({
								modifyModeCreateNewCat: false,
								modifyModeCategoryId: event.target.value								
							})
						}
					}.bind(this)
				})
			}
			if ( this.state.modifyModeCreateNewCat ) {
				basicFormRows.splice(3,0,{
					label: "新增类别",
					type: "input-text",
					properties: {
						value: this.state.modifyModeNewCatName
					},
					handleChange: function(evt) {
						this.setState({
							modifyModeNewCatName: evt.target.value
						})
					}.bind(this)
				})
			}
		} else {                              //旧品
			var basicFormRows = [
				{
					label: "物资名称",
					type: "plain-text",
					text: this.props['item_name']
				},
				{
					label: "物资类别",
					type: "plain-text",
					text: this.props['category_name'],
				}
			];
		}
		
		var newFormRows = basicFormRows.concat([
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
				html: this.state.location || "",
				handleChange: function(evt) {
					this.setState({
						location: evt.target.value
					})
				}.bind(this)
			}
		]);
    
    var oldFormRows = basicFormRows.concat([
			{
				label: "所属仓库",
				type: "plain-text",
				text: this.state.room
			},
			{
				label: "具体位置",
				type: "plain-text",
				text: this.state.location || ""
			}
		]);
    
    var formRows = this.props.item_id == 0 ? newFormRows : oldFormRows;
    
    formRows = formRows.concat([
      {
				label: "入库数量",
				type: "input-num",
				properties: {
					value: this.state.amount
				},
				handleChange: function(evt) {
					this.setState({
						amount: evt.target.value
					})
				}.bind(this)
			}
    ]);
		
		return <div className="buymodify">
			<HorizontalForm rows={formRows} flexRatio={2} />
			<div className="deal-btns">
				<button className="approve" onClick={this.handleBuyModifySubmit}>入库</button>
				<button className="refuse" onClick={this.closeBuyModifyMode}>返回</button>
			</div>
		</div>
	},
	
	renderBuyDealt: function(approved) {
		var location = ( approved && this.props.item_id == 0 ) ? null : <p className="location">
			{this.props['item_room']}&nbsp;/&nbsp;{this.props['item_location']}
		</p>;
		return <div className={approved ? "approved" : "refused" }>
			<h2>{this.props['item_name']}</h2>
			<p className="amount">数量：
				{approved ? this.props["real_amount"] : this.props['apply_amount']}
			</p>
			{location}
			<p className="user">{this.props['user_name']}</p>
		</div>
	},
	
	handleApproveAndModify: function() {
		this.setState({
			buyModifyMode: true
		});
	},
	
	closeBuyModifyMode: function() {
		this.setState({
			buyModifyMode: false
		});
	},
	
	handleBuyModifySubmit: function() {
		var realItemId;
		if ( this.props.item_id == 0 ) {
			//新品, 要先创建才能入库
			if ( this.state.modifyModeCategoryId == -1 ) {
				alert("请选择要将改物品归为哪个类别");
				return;
			}
			var data = {
				name: this.props.item_name || "",
				amount: 0,
				room: this.state.room || "",
				location: this.state.location || "",
				category_id: this.state.modifyModeCategoryId || ""
			}
			
			if ( this.state.modifyModeCreateNewCat ) {
				var newCat = {
					name: this.state.modifyModeNewCatName,
					type: this.state.modifyModeItemType
				}
				Api.post('api/category', null, newCat, function(json) {
					if ( json.errno == 0 ) {
						data.category_id = json.data;
						this.stockInNewItem(data);
					} else {
						alert( json.errmsg )
					}
				}.bind(this));	
			} else {
				this.stockInNewItem(data);
			}
		} else {
			this.stockInMoreOldItems(this.props.item_id, this.state.amount);
		}
	},
	
	stockInNewItem: function(data) {
		Api.post('api/item', null, data, function(json) {
			if ( json.errno == 0 ) {
				var realItemId = json.data;
				if ( realItemId ) {
					this.stockInMoreOldItems(realItemId, this.state.amount);
				}
			} else {
				alert( json.errmsg );
			}
		}.bind(this));
	},
	
	stockInMoreOldItems: function(realItemId, realAmount) {
		var data = {
			item_id: realItemId,
      log_id: this.props.id,
      real_amount: realAmount,
      dealt: 1
		};
		Api.post('api/buy', null, data, function(json) {
			if ( json.errno == 0 ) {
				alert("已成功入库~");
				this.setState(this.getInitialState());
				this.props.onUpdate();
			} else {
				alert( json.errmsg );
        Actions.getOrdersByType(this.props.type)
			}
		}.bind(this));
	},
	
	handleBuyRefuse: function() {
		var data = {
			log_id: this.props.id,
			real_room: this.state.room,
			real_location: this.state.location,
			dealt: -1
		};
		Api.post('api/buy', null, data, function(json) {
			if ( json.errno == 0 ) {
				alert("已拒绝该补购请求");
				this.setState(this.getInitialState());
				this.props.onUpdate();
			} else {
				alert( json.errmsg );
			}
		}.bind(this));
	},
	
	onAmountChange: function(evt) {
		this.setState({
			amountInputVal: evt.target.value
		});
	},
	
	onGotCategories: function(data) {
		var options = data.map(function(category) {
			return {
				value: category.id,
				text: category.name
			}
		});
		options.push({
			value: "new",
			text: "新增分类"
		});
		this.setState({
			modifyModeCategoryOptions: options
		});
	}
});