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
		{
			events = { "FileType" },
			targets = {
				"netrw",
				"Jaq",
				"qf",
				"git",
				"help",
				"man",
				"lspinfo",
				"spectre_panel",
				"lir",
				"DressingSelect",
				"tsplayground",
			},
			command = function()
				-- vim.cmd("set nobuflisted")
				vim.bo.buflisted = false
				vim.schedule(function()
					vim.api.nvim_buf_set_keymap(
						0,
						"n",
						"<leader>e",
						"<cmd>close<cr>",
						{ noremap = true, silent = true }
					)
				end)
			end,
		},
		-- Treesitter does not load using this.
		-- {
		-- 	events = { "VimEnter" },
		-- 	targets = { "*" },
		-- 	command = function()
		-- 		vim.schedule(function()
		-- 			require("grapple").select({ index = 1 })
		-- 		end)
		-- 		-- vim.cmd("<cmd>Grapple select index=1<cr>")
		-- 	end,
		-- },
	})
end

function M.set_netrw()
	utils.augroup("Netrw", {
		{
			events = { "FileType" },
			targets = { "netrw" },
			command = function()
				vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>quit<cr>", { noremap = true, silent = true })
			end,
		},
	})
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
