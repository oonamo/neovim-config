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

	local win_cmds_map = {
		["help"] = "H",
		-- ["qf"] = "J",
		-- [
	}
	utils.augroup("QOL", {
		{
			events = { "TextYankPost" },
			targets = { "*" },
			command = function()
				vim.highlight.on_yank({ timeout = 500 })
			end,
			desc = "highlight on yank",
		},
		{
			events = { "VimResized" },
			targets = { "*" },
			command = function()
				vim.cmd("wincmd =")
			end,
			desc = "resize windows un resize",
		},
		-- TODO: These autocmds are very slow
		-- {
		-- 	events = { "VimEnter" },
		-- 	targets = { "*" },
		-- 	command = function()
		-- 		-- vim.env.IS_NVIM = true
		-- 		local stdout = vim.loop.new_tty(1, false)
		-- 		stdout:write(
		-- 			("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
		-- 				"IS_NVIM",
		-- 				vim.fn.system({ "base64" }, "1")
		-- 			)
		-- 		)
		-- 	end,
		-- 	desc = "write variable to know when inside neovim",
		-- },
		-- {
		-- 	events = { "VimLeave" },
		-- 	targets = { "*" },
		-- 	command = function()
		-- 		local stdout = vim.loop.new_tty(1, false)
		-- 		stdout:write(
		-- 			("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
		-- 				"IS_NVIM",
		-- 				vim.fn.system({ "base64" }, "-1")
		-- 			)
		-- 		)
		-- 	end,
		-- 	desc = "rewrite variable to be false when leaving neovim",
		-- },
		{
			events = { "FileType" },
			targets = {
				"help",
				"man",
				"qf",
				"query",
				"scratch",
				"spectre_panel",
			},
			command = function(args)
				vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
				if args.match == "qf" then
					return
				end
				vim.bo.bufhidden = "unload"
				local dir = win_cmds_map[args.match] or "K"
				vim.cmd.wincmd(dir)
				vim.cmd.wincmd("=")
			end,
			desc = "Close with 'q'",
		},
		-- might be bugging shada file on windows
		-- {
		-- 	events = { "BufReadPost" },
		-- 	targets = { "*" },
		-- 	command = function(args)
		-- 		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		-- 		local line_count = vim.api.nvim_buf_line_count(args.buf)
		-- 		if mark[1] > 0 and mark[1] <= line_count then
		-- 			vim.cmd('normal! g`"zz')
		-- 		end
		-- 	end,
		-- 	desc = "save previous cursor position",
		-- },
	})
	-- do
	-- 	SEARCH_REG = ""
	-- 	utils.augroup("SearchCommand", {
	-- 		{
	-- 			events = { "CmdlineEnter" },
	-- 			targets = { "*" },
	-- 			command = function()
	-- 				SEARCH_REG = vim.fn.getreg("/")
	-- 				vim.fn.setreg("/", "")
	-- 				vim.opt.hlsearch = true
	-- 			end,
	-- 		},
	-- 		{
	-- 			events = { "CmdlineLeave" },
	-- 			targets = { "*" },
	-- 			command = function()
	-- 				vim.fn.setreg("/", SEARCH_REG)
	-- 				vim.opt.hlsearch = false
	-- 			end,
	-- 		},
	-- 	})
	-- end
	if O.ui.transparency.enable then
		vim.api.nvim_create_autocmd("Colorscheme", {
			callback = vim.schedule_wrap(function(event)
				if vim.tbl_contains(O.ui.transparency.exclude_list, event.match) then
					return
				end
				require("mini.colors")
					.get_colorscheme()
					:add_transparency({
						general = true,
						float = false,
						statuscolumn = true,
						statusline = true,
						tabline = true,
						winbar = true,
					})
					:apply()
			end),
		})
	end
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
			events = { "BufWritePre" },
			targets = { "*.md", "*.norg", "*.org", "*.tex" },
			command = function()
				require("mini.trailspace").trim()
			end,
		},
		{
			events = { "Colorscheme" },
			command = function()
				local hls = {
					ObsidianTodo = { bold = true, fg = "#f78c6c" },
					ObsidianDone = { bold = true, fg = "#89ddff" },
					ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					ObsidianTilde = { bold = true, fg = "#ff5370" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#c792ea" },
					ObsidianExtLinkIcon = { fg = "#c792ea" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianHighlightText = { bg = "#75662e" },
				}
				for k, v in pairs(hls) do
					vim.api.nvim_set_hl(0, k, v)
				end
			end,
		},
	})
end

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = M.set_qol,
	once = true,
})
-- M.set_qol()

return M
