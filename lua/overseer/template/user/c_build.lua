return {
	name = "gcc build",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			-- cmd = { "gcc -o tmp " .. file .. " && ./tmp" },
			cmd = { "gcc" },
			components = { { "on_output_quickfix", open = true }, "default" },
			args = { file, "-o", "tmp" },
		}
	end,
	condition = {
		filetype = { "c" },
	},
}
