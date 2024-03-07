local Form = require("onam.form")

local form = Form:new({
	{
		position = "50%",
		relative = "editor",
		on_submit = function(state)
			vim.print(state)
			print("Submitted")
		end,
	},
})

form:set_content(
	form.text_input({
		label = "Name",
		key = "name",
		focus = true,
	}),
	form.text_input({
		label = "Email",
		key = "email",
		height = 5,
	}),
	form.select({
		label = "Select",
		height = 8,
		key = "select",
		data = { "a", "b", "c" },
	}),
	form.footer({
		is_focusable = true,
	})
)

form:open()
