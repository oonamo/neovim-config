local M = {}
local sep = vim.fn.has("win32") and "\\" or "/"
local augroup = function(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end
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
}
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("on_yank"),
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("on_resize"),
	callback = function()
		vim.cmd("wincmd =")
	end,
})
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
		local dir = win_cmds_map[args.match] or "K"
		vim.cmd.wincmd(dir)
		vim.cmd.wincmd("=")
	end,
	desc = "Close with 'q'",
})

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
				vim.cmd("silent mkview")
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
		{
			events = { "BufNew" },
			targets = { "*.md", "*.norg", "*.org", "*.tex" },
			command = function(event)
				vim.schedule(function()
					vim.cmd("silent! loadview")
				end)
			end,
		},
		{
			events = { "VimEnter" },
			targets = { "*.md", "*.norg", "*.org", "*.tex" },
			command = function(event)
				if vim.fn.argc(-1) ~= 0 then
					vim.api.nvim_create_autocmd("User", {
						pattern = "VeryLazy",
						callback = function()
							vim.cmd("silent! loadview")
						end,
					})
				else
					vim.cmd("silent! loadview")
				end
			end,
		},
	})
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("bigfile"),
	pattern = "bigfile",
	callback = function(ev)
		vim.b.minianimate_disable = true
		vim.schedule(function()
			vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
		end)
	end,
})

-- vim.on_key(function(char)
-- 	local key = vim.fn.keytrans(char)
-- 	local isCmdlineSearch = vim.fn.getcmdtype():find("[/?]") ~= nil
-- 	local isNormalMode = vim.api.nvim_get_mode().mode == "n"
-- 	local searchStarted = (key == "/" or key == "?") and isNormalMode
-- 	local searchConfirmed = (key == "<CR>" and isCmdlineSearch)
-- 	local searchCancelled = (key == "<Esc>" and isCmdlineSearch)
-- 	if not (searchStarted or searchConfirmed or searchCancelled or isNormalMode) then
-- 		return
-- 	end
--
-- 	-- works for RHS, therefore no need to consider remaps
-- 	local searchMovement = vim.tbl_contains({ "n", "N", "*", "#" }, key)
--
-- 	local countNs = vim.api.nvim_create_namespace("searchCounter")
-- 	vim.api.nvim_buf_clear_namespace(0, countNs, 0, -1)
--
-- 	if (searchCancelled or not searchMovement) and not searchConfirmed then
-- 		vim.opt.hlsearch = false
-- 	elseif searchMovement or searchConfirmed or searchStarted then
-- 		vim.opt.hlsearch = true
--
-- 		-- CONFIG
-- 		local signColumnPlusScrollbarWidth = 2 + 3
--
-- 		vim.defer_fn(function()
-- 			local row = vim.api.nvim_win_get_cursor(0)[1]
-- 			local count = vim.fn.searchcount()
-- 			if count.total == 0 then
-- 				return
-- 			end
-- 			local text = (" %s/%s "):format(count.current, count.total)
-- 			local line = vim.api.nvim_get_current_line():gsub("\t", (" "):rep(vim.bo.shiftwidth)) -- ffff
-- 			local lineFull = #line + signColumnPlusScrollbarWidth >= vim.api.nvim_win_get_width(0)
-- 			local margin = { (" "):rep(lineFull and signColumnPlusScrollbarWidth or 0), "None" }
--
-- 			vim.api.nvim_buf_set_extmark(0, countNs, row - 1, 0, {
-- 				virt_text = { { text, "IncSearch" }, margin },
-- 				virt_text_pos = lineFull and "right_align" or "eol",
-- 				priority = 200, -- so it comes in front of lsp-endhints
-- 			})
-- 		end, 1)
-- 	end
-- end, vim.api.nvim_create_namespace("autoNohlAndSearchCount"))

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function(event)
		if event.buf then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.scl = "no"
		end
	end,
})

return M
