local M = {}
function M.set_qol()
	-- make :W the same as :w
	vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
	vim.api.nvim_create_user_command("Wq", "wq", { nargs = 0 })
	vim.api.nvim_create_user_command("Wqa", "wqa", { nargs = 0 })
	-- make :E the same as :e
	vim.api.nvim_create_user_command("E", "e", { nargs = 0 })
	-- make :Q the same as :qa
	vim.api.nvim_create_user_command("Q", "q", { nargs = 0 })
	vim.api.nvim_create_user_command("Qa", "qa", { nargs = 0 })

	utils.augroup("QOL", {
		{
			events = { "TextYankPost" },
			targets = { "*" },
			command = function()
				vim.highlight.on_yank({ timeout = 500 })
			end,
		},
		{
			events = { "VimResized" },
			targets = { "*" },
			command = function()
				vim.cmd("wincmd =")
			end,
		},
		{
			events = { "VimEnter" },
			targets = { "*" },
			command = function()
				-- vim.env.IS_NVIM = true
				local stdout = vim.loop.new_tty(1, false)
				stdout:write(
					("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
						"IS_NVIM",
						vim.fn.system({ "base64" }, "1")
					)
				)
			end,
		},
		{
			events = { "VimLeave" },
			targets = { "*" },
			command = function()
				local stdout = vim.loop.new_tty(1, false)
				stdout:write(
					("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
						"IS_NVIM",
						vim.fn.system({ "base64" }, "-1")
					)
				)
			end,
		},
		-- {
		-- 	events = { "BufEnter", "CursorMoved", "CursorHoldI" },
		-- 	command = function()
		-- 		local win_h = vim.api.nvim_win_get_height(0)
		-- 		local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
		-- 		local dist = vim.fn.line("$") - vim.fn.line(".")
		-- 		local rem = vim.fn.line("w$") - vim.fn.line("w0") + 1
		--
		-- 		if dist < off and win_h - rem + dist < off then
		-- 			local view = vim.fn.winsaveview()
		-- 			view.topline = view.topline + off - (win_h - rem + dist)
		-- 			vim.fn.winrestview(view)
		-- 		end
		-- 	end,
		-- },
		{
			events = { "BufEnter", "BufWinEnter" },
			targets = { "C:/Users/onam7/Desktop/DB/DB/*.md" },
			command = function(ev)
				vim.print(ev)
				vim.notify("would load plugins")
				if package.loaded["obsidian"] or package.loaded["obsidian-bridge"] then
					vim.notify("already loaded")
					return
				end
				-- require("lazy").load({ plugins = { "obsidian.nvim", "obsidian-bridge.nvim" } })
			end,
			desc = "Load these plugins based on path",
			once = true,
		},
	})
	do
		SEARCH_REG = ""
		utils.augroup("SearchCommand", {
			{
				events = { "CmdlineEnter" },
				targets = { "*" },
				command = function()
					SEARCH_REG = vim.fn.getreg("/")
					vim.fn.setreg("/", "")
					vim.opt.hlsearch = true
				end,
			},
			{
				events = { "CmdlineLeave" },
				targets = { "*" },
				command = function()
					vim.fn.setreg("/", SEARCH_REG)
					vim.opt.hlsearch = false
				end,
			},
		})
	end
end

function M.set_netrw()
	-- utils.augroup("Netrw", {
	-- 	{
	-- 		events = { "FileType" },
	-- 		targets = { "netrw" },
	-- 		command = function()
	-- 			vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>quit<cr>", { noremap = true, silent = true })
	-- 		end,
	-- 	},
	-- })
end

function M.setup_status_cmds()
	utils.augroup("Statusline", {
		{
			events = { "BufWritePost", "CmdlineLeave" },
			targets = { "*" },
			command = function()
				vim.opt.cmdheight = 0
				vim.schedule(function()
					vim.cmd("redrawstatus!")
				end)
			end,
		},
		{
			events = { "BufWritePre", "CmdlineEnter" },
			targets = { "*" },
			command = function()
				vim.opt.cmdheight = 1
			end,
		},
	})
end

function M.setup_writing_cmds()
	utils.augroup("Writing", {
		{
			events = { "BufEnter" },
			targets = { "*.md", "*.norg", "*.org", "*.tex" },
			command = function()
				vim.opt.shiftwidth = 2
			end,
		},
		{
			events = { "BufReadPost" },
			targets = { "*.norg" },
			command = function()
				vim.schedule(function()
					vim.cmd("1 foldc")
				end)
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
