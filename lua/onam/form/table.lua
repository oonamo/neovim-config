local NuiTable = require("nui.table")
local Text = require("nui.text")

local bufnr = 0
local tbl = NuiTable({
	bufnr = bufnr,
	columns = {
		{
			align = "center",
			header = "Name",
			columns = {
				{ accessor_key = "firstName", header = "First" },
				{
					id = "lastName",
					accessor_fn = function(row)
						return row.lastName
					end,
					header = "Last",
				},
			},
		},
		{
			align = "right",
			accessor_key = "age",
			cell = function(cell)
				return Text(tostring(cell.get_value()), "DiagnosticInfo")
			end,
			header = "Age",
		},
	},
	data = {
		{ firstName = "John", lastName = "Doe", age = 42 },
		{ firstName = "Jane", lastName = "Doe", age = 27 },
	},
})

tbl:render()
