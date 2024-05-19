local M = {}
function M.set_qol()
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
		-- {
		-- 	events = { "FileType" },
		-- 	targets = {
		-- 		"netrw",
		-- 		"Jaq",
		-- 		"qf",
		-- 		"git",
		-- 		"help",
		-- 		"man",
		-- 		"lspinfo",
		-- 		"spectre_panel",
		-- 		"lir",
		-- 		"DressingSelect",
		-- 		"tsplayground",
		-- 	},
		-- 	command = function()
		-- 		-- vim.cmd("set nobuflisted")
		-- 		vim.bo.buflisted = false
		-- 		vim.schedule(function()
		-- 			vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
		-- 		end)
		-- 	end,
		-- },
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
