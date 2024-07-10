return {
	{
		"echasnovski/mini.nvim",
		lazy = true,
	},
	{
		"mini.bracketed",
		dev = true,
		config = function()
			require("mini.bracketed").setup()
		end,
		keys = {
			{ "[" },
			{ "]" },
		},
	},
	{
		"mini.extra",
		dev = true,
		config = function()
			require("mini.extra").setup()
		end,
		-- lazy = false,
	},
	{
		"mini.pick",
		dev = true,
		init = function()
			vim.ui.select = require("mini.pick").ui_select
		end,
		-- Telescope native is as fast as mini pick
		-- config = function()
		-- 	require("plugins.confs.mini.pick")
		-- end,
		-- keys = function()
		-- 	if not MiniExtra then
		-- 		require("mini.extra").setup()
		-- 	end
		-- 	local e_pick = MiniExtra.pickers
		-- 	return {
		-- 		{
		-- 			"<C-P>",
		-- 			require("mini.pick").builtin.files,
		-- 			{ desc = "files" },
		-- 		},
		-- 		{
		-- 			"<C-F>",
		-- 			-- function()
		-- 			-- 	require("mini.pick").builtin.grep_live()
		-- 			-- end,
		-- 			"<CMD>Pick center_grep<CR>",
		-- 			{ desc = "grep live" },
		-- 		},
		-- 		{
		-- 			"<leader>fgs",
		-- 			require("mini.pick").builtin.grep,
		-- 			{ desc = "grep" },
		-- 		},
		-- 		{
		-- 			"<leader>ff",
		-- 			require("mini.pick").builtin.cli,
		-- 			{ desc = "cli" },
		-- 		},
		-- 		{
		-- 			"<leader>fh",
		-- 			require("mini.pick").builtin.help,
		-- 			{ desc = "help" },
		-- 		},
		-- 		{
		-- 			"<leader>fr",
		-- 			require("mini.pick").builtin.resume,
		-- 			{ desc = "resume" },
		-- 		},
		--
		-- 		-- Extras
		-- 		{
		-- 			"<leader>pehg",
		-- 			e_pick.hl_groups,
		-- 			{ desc = "hl groups" },
		-- 		},
		-- 		{
		-- 			"<leader>peH",
		-- 			e_pick.history,
		-- 			{ desc = "history" },
		-- 		},
		-- 		{
		-- 			"<leader>peK",
		-- 			e_pick.keymaps,
		-- 			{ desc = "keymaps" },
		-- 		},
		-- 		{
		-- 			"<leader>pem",
		-- 			e_pick.marks,
		-- 			{ desc = "marks" },
		-- 		},
		--
		-- 		{
		-- 			"<leader>pelq",
		-- 			function()
		-- 				e_pick.list({ scope = "quickfix" })
		-- 			end,
		-- 			{ desc = "pick qf" },
		-- 		},
		-- 		{
		-- 			"<leader>pell",
		-- 			function()
		-- 				e_pick.list({ scope = "location" })
		-- 			end,
		-- 			{ desc = "pick ll" },
		-- 		},
		-- 		{
		-- 			"<leader>pelj",
		-- 			function()
		-- 				e_pick.list({ scope = "jump" })
		-- 			end,
		-- 			{ desc = "pick jumplist" },
		-- 		},
		-- 		{
		-- 			"<leader>pelc",
		-- 			function()
		-- 				e_pick.list({ scope = "change" })
		-- 			end,
		-- 			{ desc = "pick changelist" },
		-- 		},
		-- 		{
		-- 			"z=",
		-- 			e_pick.spellsuggest,
		-- 			{ desc = "spell suggest" },
		-- 		},
		-- 	}
		-- end,
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
	{
		"mini.notify",
		event = "VeryLazy",
		dev = true,
		init = function()
			vim.notify = require("mini.notify").make_notify()
		end,
		cmd = "Notifications",
		config = function()
			require("plugins.confs.mini.notify")
		end,
	},
	{
		"mini.sessions",
		dev = true,
		config = function()
			require("mini.sessions").setup({
				auto_write = true,
			})
		end,
		keys = function()
			function Config._sessions_complete(arg_lead)
				return vim.tbl_filter(function(v)
					return v:find(arg_lead, 1, true) ~= nil
				end, vim.tbl_keys(MiniSessions.detached))
			end

			local function get_session_from_user(prompt)
				local completion = "customlist,v:lua.Config._session_complete"
				local ok, res = pcall(vim.fn.input, {
					prompt = prompt,
					cancelreturn = false,
					completion = completion,
				})
				if not ok or res == false then
					return nil
				end
				return res
			end
			local function delete()
				local res = get_session_from_user("Delete session: ")
				if res ~= nil then
					MiniSessions.delete(res, { force = true })
				end
			end

			local function save()
				local res = get_session_from_user("Save session as: ")
				if res ~= nil then
					MiniSessions.write(res)
				end
			end
			return {
				utils.vim_to_lazy_map("n", "<leader>ss", save, { desc = "save session" }),
				utils.vim_to_lazy_map("n", "<leader>sd", delete, { desc = "delete session" }),
				utils.vim_to_lazy_map("n", "<leader>ms", function()
					MiniSessions.select()
				end, { desc = "select session" }),
			}
		end,
	},
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
		event = "InsertEnter",
		config = function()
			require("mini.ai").setup({
				custom_textobjects = {
					B = MiniExtra.gen_ai_spec.buffer(),
				},
			})
		end,
	},
	{
		"mini.diff",
		dev = true,
		event = "VeryLazy",
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
			{ mode = "n", "sa" }, -- Add surrounding in Normal and Visual modes
			{ mode = "n", "sd" }, -- Delete surrounding
			{ mode = "n", "sf" }, -- Find surrounding (to the right)
			{ mode = "n", "sF" }, -- Find surrounding (to the left)
			{ mode = "n", "sh" }, -- Highlight surrounding
			{ mode = "n", "sr" }, -- Replace surrounding
			{ mode = "n", "sn" }, -- Update `n_lines`
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
			{ "<leader>gc" },
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
			{ "F" },
			{ "f" },
			{ "T" },
			{ "t" },
		},
	},
	{
		"mini.icons",
		dev = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
