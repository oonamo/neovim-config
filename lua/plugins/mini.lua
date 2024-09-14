return {
	{
		"echasnovski/mini.nvim",
		lazy = true,
	},
	{
		"mini.cursorword",
		dev = true,
		event = "LazyFile",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"mini.extra",
		dev = true,
		config = function()
			require("mini.extra").setup()
		end,
	},
	{
		"mini.pick",
		dev = true,
		config = function()
			require("plugins.confs.mini.pick")
		end,
		keys = function()
			if not MiniExtra then
				require("plugins.confs.mini.pick")
			end
			return {
				{
					"<leader>ff",
					function()
						require("mini.extra").pickers.explorer({}, {
							mappings = {
								go_in = {
									char = "<Tab>",
									func = function()
										vim.api.nvim_input("<CR>")
									end,
								},
								toggle_preview = "",
							},
						})
					end,
					-- "<cmd>Pick explorer<CR>",
					-- function()
					-- 	local cmd = vim.fn.input({
					-- 		prompt = "Command: ",
					-- 	})
					-- 	require("mini.pick").builtin.cli({
					-- 		command = cmd,
					-- 	})
					-- end,
					-- { desc = "cli" },
				},
			}
		end,
	},
	{
		"mini.files",
		dev = true,
		config = function()
			require("plugins.confs.mini.files")
		end,
		keys = {
			utils.vim_to_lazy_map("n", "<leader>e", function()
				require("mini.files").open()
			end, { desc = "open cwd files" }),

			utils.vim_to_lazy_map("n", "-", function()
				local bufname = vim.api.nvim_buf_get_name(0)
				local path = vim.fn.fnamemodify(bufname, ":p")

				-- Noop if the buffer isn't valid.
				if path and vim.uv.fs_stat(path) then
					require("mini.files").open(bufname, false)
				end
			end, { desc = "open bufdir files" }),
		},
	},
	-- {
	-- 	"mini.notify",
	-- 	event = "VeryLazy",
	-- 	dev = true,
	-- 	init = function()
	-- 		vim.notify = require("mini.notify").make_notify()
	-- 	end,
	-- 	cmd = "Notifications",
	-- 	config = function()
	-- 		require("plugins.confs.mini.notify")
	-- 	end,
	-- },
	{
		"mini.splitjoin",
		dev = true,
		config = function()
			require("mini.splitjoin").setup()
		end,
		keys = {
			"gS",
		},
	},
	{
		"mini.ai",
		dev = true,
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({
				custom_textobjects = {
					B = require("mini.extra").gen_ai_spec.buffer(),
				},
			})
		end,
	},
	{
		"mini.diff",
		dev = true,
		event = "LazyFile",
		config = function()
			require("plugins.confs.mini.diff")
		end,
	},
	{
		"mini.move",
		dev = true,
		config = function()
			require("plugins.confs.mini.move")
		end,
		keys = {
			{ mode = "v", "H" },
			{ mode = "v", "L" },
			{ mode = "v", "J" },
			{ mode = "v", "K" },
		},
	},
	{
		"mini.surround",
		dev = true,
		config = function()
			require("plugins.confs.mini.surround")
		end,
		keys = {
			{ mode = "n", "sa", desc = "Add surrounding" }, -- Add surrounding in Normal and Visual modes
			{ mode = "n", "sd", desc = "Delete surrounding" }, -- Delete surrounding
			{ mode = "n", "sf", desc = "Find surrounding" }, -- Find surrounding (to the right)
			{ mode = "n", "sF", desc = "Find surrounding (left)" }, -- Find surrounding (to the left)
			{ mode = "n", "sh", desc = "Highlight surrounding" }, -- Highlight surrounding
			{ mode = "n", "sr", desc = "Replace surrounding" }, -- Replace surrounding
			{ mode = "n", "sn", desc = "Update search lines" }, -- Update `n_lines`
		},
	},
	{
		"mini.bufremove",
		dev = true,
		config = function()
			require("mini.bufremove").setup()
		end,
		keys = {
			{
				"<leader>bd",
				function()
					MiniBufremove.delete()
				end,
				desc = "delete buffer",
			},
		},
	},
	{
		"mini.hipatterns",
		dev = true,
		event = "VeryLazy",
		config = function()
			require("plugins.confs.mini.hi")
		end,
	},
	{
		"mini.git",
		dev = true,
		event = "LazyFile",
		config = function()
			require("plugins.confs.mini.git")
		end,
		keys = {
			utils.vim_to_lazy_map("n", "<leader>gs", "<CMD>Git status<CR>", { desc = "Git Status" }),
			utils.vim_to_lazy_map("n", "<leader>gac", "<CMD>Git add %<CR>", { desc = "Git Add Current" }),
			utils.vim_to_lazy_map("n", "<leader>gaa", "<CMD>Git add .<CR>", { desc = "Git Add All" }),
			utils.vim_to_lazy_map("n", "<leader>gp", "<CMD>Git push<CR>", { desc = "Git Push" }),
			{
				mode = { "n", "x" },
				"<leader>gx",
				function()
					require("mini.git").show_at_cursor()
				end,
				desc = "Show info at cursor",
			},
			utils.vim_to_lazy_map("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "Git commit" }),
		},
	},
	{
		"mini.indentline",
		dev = true,
		event = "VeryLazy",
		config = function()
			require("plugins.confs.mini.indent")
		end,
	},
	{
		"mini.jump",
		dev = true,
		config = function()
			require("plugins.confs.mini.jump")
		end,
		keys = {
			{ "F", desc = "Jump to previous occurrence" },
			{ "f", desc = "Jump to next occurrence" },
			{ "T", desc = "Jump till previous occurrence" },
			{ "t", desc = "Jump till next occurrence" },
		},
	},
	{
		"mini.icons",
		dev = true,
		event = "LazyFile",
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
		config = function()
			require("mini.icons").setup({
				lsp = {
					["function"] = { glyph = "󰡱", hl = "MiniIconsAzure" },
					["Function"] = { glyph = "󰡱", hl = "MiniIconsAzure" },
				},
			})
		end,
	},
	-- {
	-- 	"mini.tabline",
	-- 	dev = true,
	-- 	event = "LazyFile",
	-- 	config = function()
	-- 		require("plugins.confs.mini.tabline")
	-- 	end,
	-- },
}
