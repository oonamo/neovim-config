local group = vim.api.nvim_create_augroup("config group", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = {
		"help",
		"man",
		"qf",
		"query",
		"scratch",
	},
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
		if args.match == "qf" then
			return
		end
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("K")
		vim.cmd.wincmd("=")
	end,
	desc = "Close with 'q'",
})
