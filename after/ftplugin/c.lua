-- vim.opt.formatoptions:remove("o")
local function go_to_headerfile()
	local file = vim.api.nvim_buf_get_name(0)
	local filename_no_ext = vim.fn.fnamemodify(file, ":r")
	local ext = vim.fn.fnamemodify(file, ":e")

	if ext == "c" then
		vim.cmd("e " .. filename_no_ext .. ".h")
	else
		vim.cmd("e " .. filename_no_ext .. ".c")
	end
end

vim.keymap.set("n", "<leader>lh", go_to_headerfile, {
	desc = "go to header file",
})

vim.keymap.set("n", "<leader>ls", function()
	vim.cmd.vsplit()
	go_to_headerfile()
end)
