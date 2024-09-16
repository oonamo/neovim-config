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

local function handler(direction)
	return function(err, uri)
		if not uri or uri == "" then
			vim.api.nvim_echo({
				{ "Corresponding file does not exist", "DiagnosticWarn" },
			}, false, {})
		end
		local filename = vim.uri_to_fname(uri)
		if direction == "below" then
			vim.cmd.split()
		elseif direction == "vertial" then
			vim.cmd.vsplit()
		end
		vim.cmd("edit " .. filename)
	end
end

vim.keymap.set("n", "<leader>lh", function()
	vim.lsp.buf_request(0, "textDocument/switchSourceHeader", {
		uri = vim.uri_from_bufnr(0),
	}, handler())
end, {
	desc = "go to header file",
})
