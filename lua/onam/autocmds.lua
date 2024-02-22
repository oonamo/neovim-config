local M = {}

function M.setup_status_cmds()
	utils.augroup("Statusline", {
		{
			events = { "CmdlineEnter", "CmdlineChanged", "BufWritePre" },
			targets = { "*" },
			command = function()
				vim.opt.cmdheight = 1
			end,
		},
		{
			events = { "CmdlineLeave", "BufWritePost", "InsertLeave" },
			targets = { "*" },
			command = function()
				vim.opt.cmdheight = 0
			end,
		},
	})
end
function M.norg_autocmds()
	utils.augroup("NorgAutocmds", {
		{
			events = { "BufReadPost" },
			targets = { "*.norg" },
			command = function()
				vim.schedule(function()
					vim.fn.feedkeys("ggzc", "n")
					vim.notify("Closing Document Meta")
				end)
			end,
		},
	})
end
return M
