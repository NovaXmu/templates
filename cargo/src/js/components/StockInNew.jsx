var React = require("react");
var HorizontalForm = require("./HorizontalForm");
var Api = require("../utils/api");

module.exports = React.createClass({
	getInitialState: function() {
		return {
			createNewCat: false,
			name: this.props.initialName || "",
			room: "",
			location: "",
			categoryId: this.props.categories[0] ? this.props.categories[0].id : "",
			amount: this.props.initialAmount || 1,
			author: "",
			newCatName: "",
			borrowDays: this.props.initialBorrowDays || 1
		}
	},

	componentWillReceiveProps: function(nextProps) {
		this.setState({
			categoryId: nextProps.categories[0] ? nextProps.categories[0].id : null
		})
	},
	
	render: function() {
		var catOpts = this.props.categories.map(function(cat) {
			return {
				value: cat.id,
				text: cat.name
			}
		});
		if (catOpts.length > 0) {
			catOpts.push({
				value: "new",
				text: "新增分类"
			});
		}

		var amountInput = this.props.hideAmount ? null : {
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
		};

		var cats = this.props.hideCats ? null : {
			label: "物资类别",
			type: "select",
			options: catOpts,
			handleChange: function(event) {
				this.setState({
					createNewCat: event.target.value == "new",
					categoryId: event.target.value
				})
			}.bind(this)
		}

		var formRows = [
			{
				label: "物资名称",
				type: "input-text",
				properties: {
					value: this.state.name
				},
				handleChange: function(evt) {
					this.setState({
						name: evt.target.value
					})
				}.bind(this)
			},
			cats,
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
			amountInput,
			{
				label: "作者",
				type: "input-text",
				properties: {
					value: this.state.author,
					placeholder: "选填（只针对书籍）"
				},
				handleChange: function(evt) {
					this.setState({
						author: evt.target.value
					})
				}.bind(this)
			}
		];
		if ( this.state.createNewCat ) {
			formRows.splice(2,0,{
				label: "新增类别",
				type: "input-text",
				properties: {
					value: this.state.newCatName
				},
				handleChange: function(evt) {
					this.setState({
						newCatName: evt.target.value
					})
				}.bind(this)
			})
		}

		if ( this.props.type == 1 ) {
			formRows.splice(-1, 0, {
				label: "最长借期",
				type: "input-num",
				extra: "天",
				className: "br-days",
				properties: {
					value: this.state.borrowDays
				},
				handleChange: function(evt) {

					this.setState({
						borrowDays: evt.target.value
					})
				}.bind(this)
			})
		}
		return <div className="stock-in-new">
			<HorizontalForm flexRatio={2} rows={formRows}/>
			<div className="btn-wrap">
				<button onClick={this.onSubmit}>{this.props.needAmount ? "入库" : "创建"}</button>
			</div>
		</div>
	},
	
	onSubmit: function() {
		var data = {
			name: this.state.name,
			amount: this.state.amount,
			room: this.state.room,
			location: this.state.location,
			author: this.state.author,
			borrow_days: this.state.borrowDays,
			type: this.props.type
		}
		
		if ( this.state.createNewCat ) {
			this.stockInWithNewCat(data);
		} else {
			data.category_id = this.state.categoryId
			this.stockInNew(data);
		}
	},
	
	stockInWithNewCat: function(data) {
		var newCat = {
			name: this.state.newCatName,
			type: this.props.type
		}
		Api.post("api/category", null, newCat, function(json) {
			if ( json.errno == 0 ) {
				data.category_id = json.data;
				this.stockInNew(data);
			}	else {
				alert(json.errmsg)
			}	
		}.bind(this));
	},
	
	stockInNew: function(data) {
		Api.post("api/admin/item", {m: "add"}, data, function(json) {
			if ( json.errno == 0 ) {
				alert("已成功入库~");
				if (document.querySelector("#search-bar input")) {
					document.querySelector("#search-bar input").value = "";
				}
				this.setState(this.getInitialState());
				if (this.props.onStockedIn) {
					this.props.onStockedIn(json.data);
				}
			} else {
				alert("出现了错误:" + json.errmsg);
			}
		}.bind(this));
	}
	
});