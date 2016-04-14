var React = require("react");

/*
	@prop Boolean responsive
	@prop Boolean striped
	@prop Boolean bordered
	@prop Boolean hover
	@prop Boolean condensed
	@prop Boolean className
	@prop *Array[Object] rows
		[Object] {
			Boolean isHead,
			Boolean active,
			String style,
			String id,
			String className,
			*Array[Object] cells,
				[Object] {
					String className,
					Boolean active,
					String style,
					Number colspan,
					Number rowspan,
					ReactElement content
				}
		}
	
	@template
	{
		responsive: false,
		striped: true,
		bordered: false,
		hover: true,
		condensed: false,
		rows: [
			{
				isHead: true,
				active: false,
				style: "success",
				cells: [
					{
						active: false,
						style: "",
						colspan: null,
						rowspan: null,
						content: "#"
					},
					{
						active: false,
						style: "",
						colspan: null,
						rowspan: null,
						content: "Name"
					}
				]
			},
			{
				isHead: false,
				active: false,
				style: "",
				cells: [
					{
						active: false,
						style: "",
						colspan: null,
						rowspan: null,
						content: "1"
					},
					{
						active: false,
						style: "",
						colspan: null,
						rowspan: null,
						content: "Chris"
					}
				]
			}
		]
	}
*/

module.exports = React.createClass({
	render: function() {
		if ( this.props.responsive ) {
			return <div className="table-responsive">
				{this.renderTable()}
			</div>
		}	else {
			return this.renderTable();
		}
	},
	
	renderTable: function() {
		return <table className={"table" + 
							(this.props.striped ? " table-striped" : "") + 
							(this.props.bordered ? " table-bordered" : "") + 
							(this.props.hover ? " table-hover" : "") + 
							(this.props.condensed ? " table-condensed" : "") + " " +
							(this.props.className || "")} >
			<tbody>
				{this.renderRows()}
			</tbody>
		</table>
	},
	
	renderRows: function() {
		return this.props.rows.map(function(row, i) {
			return <tr key={i} data-id={row.id} className={(row.active ? " active" : "") + (row.style ? " " + row.style : "") + " " + (row.className || "")}>
				{this.renderCells(row)}
			</tr>
		}.bind(this));
	},
	
	renderCells: function(row) {
		return row.cells.map(function(td, i) {
			if ( row.isHead ) {
				return <th  key={i} className={(td.active ? " active" : "") + (td.style ? " " + td.style : "")} 
									colSpan={td.colspan ? td.colspan : ""} 
									rowSpan={td.rowspan ? td.rowspan : ""}
									className={td.className || ""}>
					{td.content}
				</th>
			} else {
				return <td key={i} className={(td.active ? " active" : "") + (td.style ? " " + td.style : "")} 
									colSpan={td.colspan ? td.colspan : ""} 
									rowSpan={td.rowspan ? td.rowspan : ""}
									className={td.className || ""}>
					{td.content}
				</td>
			}
		});
	}
});