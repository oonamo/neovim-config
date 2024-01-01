local M = {}

function M.setup_status_cmds()
	utils.augroup("Statusline", {
		{
			events = { "CmdlineEnter", "CmdlineChanged", "BufWritePre" },
			targets = { "*" },
			command = "set cmdheight=1",
		},
		{
			events = { "CmdlineLeave", "BufWritePost", "InsertLeave" },
			targets = { "*" },
			command = "set cmdheight=0 | redrawstatus!",
		},
	})
end

function M.setup_qol()
	utils.augroup("QOL", {
		{
			events = { "TextYankPost" },
		},
	})
end

return M
