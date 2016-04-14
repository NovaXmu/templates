var React = require("react");
var HorizontalForm = require("./HorizontalForm");
var Api = require("../utils/api");
var ValuableItem = require("./ValuableItem");

module.exports = React.createClass({

  getInitialState: function() {
    return {
      isCreating: false,
      newName: "",
      newAmount: 0,
      newPrice: 0,
      newScale: "",
      newRemark: "",
      allowSubmit: true,
      items: []
    }
  },

  componentWillMount: function() {   
    this.getItems()     
  },

  getItems: function() {
    Api.get("api/admin/item", {m: "getValuablesList"}, function(json) {
      if (json.errno == 0) {
        this.setState({
          items: json.data
        })
      } else {
        alert(json.errmsg)
      }
    }.bind(this))
  },

  render: function() {
    return <div className="valuable-manager">
      {this.renderCreate()}
      <ul className="val-list">{this.renderItems()}</ul>
    </div>
  },

  renderCreate: function() {
    var formRows = [
      {
        label: "名\u00a0\u00a0\u00a0\u00a0称",
        type: "input-text",
        properties: {
          value: this.state.newName
        },
        handleChange: function(evt) {
          this.setState({
            newName: evt.target.value
          })
        }.bind(this)
      },
      {
        label: "数\u00a0\u00a0\u00a0\u00a0量",
        type: "input-num",
        properties: {
          value: this.state.newAmount
        },
        handleChange: function(evt) {
          this.setState({
            newAmount: evt.target.value
          })
        }.bind(this)
      },
      {
        label: "价\u00a0\u00a0\u00a0\u00a0格",
        type: "input-num",
        properties: {
          value: this.state.newPrice
        },
        handleChange: function(evt) {
          this.setState({
            newPrice: evt.target.value
          })
        }.bind(this)
      },
      {
        label: "规\u00a0\u00a0\u00a0\u00a0格",
        type: "contentEditable",
        html: this.state.newScale,
        handleChange: function(evt) {
          this.setState({
            newScale: evt.target.value
          })
        }.bind(this)
      },
      {
        label: "备\u00a0\u00a0\u00a0\u00a0注",
        type: "contentEditable",
        html: this.state.newRemark,
        handleChange: function(evt) {
          this.setState({
            newRemark: evt.target.value
          })
        }.bind(this)
      }
    ]
    if (this.state.isCreating) {
      return <div className="create">
        <HorizontalForm flexRatio={2} rows={formRows}/>
        <div className="btn-wrap">
          <button onClick={this.create}>提交</button>
          <button onClick={this.dontCreate}>取消</button>
        </div>
      </div>
    } else {
      return <div className="create">
        <div className="plus" onClick={this.onPlusClicked}>+</div>
      </div>
    }
  },

  create: function() {
    if (!this.state.allowSubmit) return;
    this.setState({
      allowSubmit: false
    })

    var data = {
      name: this.state.newName,
      amount: this.state.newAmount,
      price: this.state.newPrice,
      scale: this.state.newScale,
      remark: this.state.newRemark
    }

    Api.post("api/admin/item", {m: "modifyValuables"}, data, function(json) {
      if (json.errno == 0) {
        alert("添加成功！");
        this.setState({
          newName: "",
          newAmount: 0,
          newPrice: 0,
          newScale: "",
          newRemark: ""
        })
        this.getItems();
      } else {
        alert(json.errmsg)
      }
      this.setState({
        allowSubmit: true
      })
    }.bind(this))
  },

  dontCreate: function() {
    this.setState({
      isCreating: false
    })
  },

  onPlusClicked: function(evt) {
    this.setState({
      isCreating: true
    })
  },

  renderItems: function() {
    return this.state.items.map(function(item, i) {
      return <ValuableItem {...item} key={i} onItemUpdated={this.getItems}/>
    }.bind(this))
  }
})