return {
	{
		"stevearc/conform.nvim",
		-- event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				cpp = { "clang-format" },
				c = { "clang-format" },
			},
			timeout_ms = 500,
		},
		keys = {
			-- {
			-- 	"<leader>ff",
			-- 	function()
			-- 		require("conform").format({
			-- 			timeout_ms = 500,
			-- 			lsp_fallback = false,
			-- 		})
			-- 	end,
			-- },
			{
				"<localleader>f",
				function()
					require("conform").format({
						timeout_ms = 500,
						lsp_fallback = true,
					})
				end,
			},
			{
				"gf",
				mode = "v",
				function()
					require("conform").format({
						timeout_ms = 500,
						lsp_fallback = false,
					})
				end,
			},
		},
	},
	{
		"stevearc/overseer.nvim",
		cmd = { "Grep", "Make" },
		config = function(_, opts)
			local overseer = require("overseer")
			require("overseer").setup(opts)

			vim.api.nvim_create_user_command("Grep", function(params)
				local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
				if num_subs == 0 then
					cmd = cmd .. " " .. params.args
				end
				local task = overseer.new_task({
					cmd = vim.fn.expandcmd(cmd),
					components = {
						{
							"on_output_quickfix",
							errorformat = vim.o.grepformat,
							open = not params.bang,
							open_height = 8,
							items_only = true,
						},
						{ "on_exit_set_status", success_codes = { 0 } },
						{ "on_complete_dispose", timeout = 30 },
					},
				})
				task:start()
			end, {
				nargs = "*",
				bang = true,
				complete = "file",
				desc = "Grep using Overseer",
			})

			vim.api.nvim_create_user_command("Make", function(params)
				local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
				if num_subs == 0 then
					cmd = cmd .. " " .. params.args
				end
				local task = overseer.new_task({
					cmd = vim.fn.expandcmd(cmd),
					components = {
						{ "on_output_summarize", max_lines = 10 },
						{ "on_complete_notify" },
						"default",
					},
				})
				task:start()
			end, {
				nargs = "*",
				bang = true,
				desc = "Make using Overseer",
			})
		end,
		keys = {
			{
				"<C-g>",
				":Grep ",
				desc = "Async grep",
			},
		},
	},
}
