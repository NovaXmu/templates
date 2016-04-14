var React = require("react");
var ContentEditable = require("./ContentEditable");

module.exports = React.createClass({
	getInitialState: function() {
		return {
			styles: {
				flex: this.props.flexRatio,
				WebkitFlex: this.props.flexRatio
			}
		}
	},
	
	render: function() {
		return <form className="form-horizontal clearfix">
			{this.renderRows()}
		</form>
	},
	
	renderRows: function() {
		return this.props.rows.map(function(row, i) {
			if (row) {
				return <div className={"row " + (row.className || "")} key={i}>
					{row.label ? <label>{row.label}</label> : null}
					<div style={this.state.styles}>
						{this.renderField(row)}
						{row.extra}
					</div>
				</div>
			}
		}.bind(this));
	},
	
	renderField: function(row) {
		if ( row.type == "plain-text" ) {
		
			return <p contentEditable={row.editable}>{row.text}</p>
			
		} else if ( row.type == "input-text" ) {
		
			return <input type="text" {...row.properties} onChange={row.handleChange}/>
			
		} else if ( row.type == "input-date" ) {
		
			return <input type="local-datetime" {...row.properties} onChange={row.handleChange}/>
			
		} else if ( row.type == "input-num" ) {
		
			return <input type="number" {...row.properties} onChange={row.handleChange}/>
			
		} else if ( row.type == "component" ) {
		
			return row.getComponent();
			
		} else if ( row.type == "select" ) {
			var options = row.options.slice(0);
			if ( row.placeholder ) {
				options.unshift({
					value: row.placeholder.value,
					text: row.placeholder.text,
					otherAttrs: {
						disabled: true
					}
				});
			}
		
			var optionElems = options.map(function(option, i) {
				return <option value={option.value} key={i} {...option.otherAttrs}>{option.text}</option>
			});
			return <select {...row.properties} onChange={row.handleChange} >
				{optionElems}
			</select>
			
		} else if ( row.type == "textarea" ) {
			return <textarea  onChange={row.handleChange} {...row.properties}></textarea>
		} else if ( row.type == "contentEditable" ) {
			return <ContentEditable html={row.html} onChange={row.handleChange} />
		}
	}
});