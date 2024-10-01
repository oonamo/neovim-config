vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"man",
		"qf",
		"query",
		"scratch",
		-- "spectre_panel",
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

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("bigfile", { clear = true }),
	pattern = "bigfile",
	callback = function(ev)
		vim.b.minianimate_disable = true
		vim.schedule(function()
			vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
		end)
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function(ev)
		vim.wo.rnu = false
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function(ev)
		vim.wo.rnu = true
	end,
})
