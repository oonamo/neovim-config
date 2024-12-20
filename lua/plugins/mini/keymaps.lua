local map = vim.keymap.set
-- PICK
--
local function nmap_leader(suffix, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set("n", "<leader>" .. suffix, rhs, opts)
end
nmap_leader("ff", "<cmd>Pick files<cr>", "Files")
nmap_leader( ",", "<cmd>Pick buffers<cr>", "Buffers")
map("n", "<C-f>", "<cmd>Pick grep_live<cr>", { desc = "Live Grep" })
map("n", "<C-x>h", "<cmd>Pick help<cr>", { desc = "Help" })
map("n", "<leader>\\", "<cmd>Pick buf_lines<cr>", { desc = "Find line" })

map("n", "<C-x>w", "<cmd>Pick grep pattern='<cword>'<cr>", { desc = "Grep word" })
map("n", "<C-x>i", function()
	require("mini.extra").pickers.hl_groups()
end, { desc = "Highlights" })
map("n", "<C-x>m", function()
	require("mini.extra").pickers.marks()
end, { desc = "Marks" })
map("n", "<C-x>o", "<cmd>Pick oldfiles<cr>", { desc = "Old files (cwd)" })
map("n", "<C-x>b", "<cmd>Pick buffers<cr>", { desc = "Buffers" })
map("n", "<C-x><C-f>", function()
	require("mini.extra").pickers.explorer({}, {
		mappings = {
			toggle_preview = "",
			go_up_level = {
				char = "<C-BS>", -- Same as C BKSP, emacs lol
				func = function()
					local query = MiniPick.get_picker_query()
					if not query[1] or query[1] == "" then
						vim.schedule(function()
							vim.api.nvim_input("<CR>")
						end)
					else
						MiniPick.set_picker_query({ "" })
					end
				end,
			},
			go_up_level_neovide = {
				char = "<C-BS>", -- Same as C BKSP, emacs lol
				func = function()
					local query = MiniPick.get_picker_query()
					if not query[1] or query[1] == "" then
						vim.schedule(function()
							vim.api.nvim_input("<CR>")
						end)
					else
						MiniPick.set_picker_query({ "" })
					end
				end,
			},
			new_file = {
				char = "<c-e>",
				func = function()
					local query = MiniPick.get_picker_query()
					if not query or #query < 1 then
						return
					end
					query = table.concat(query, "")
					local cwd = MiniPick.get_picker_opts().source.cwd
					local file = cwd .. "/" .. query
					file = file:gsub("\\", "/")

					vim.schedule(function()
						vim.cmd.edit(file)
					end)
					return true
				end,
			},
			open_in_file_explorer = {
				char = "<C-d>",
				func = function()
					local current = MiniPick.get_picker_matches().current
					if not current then
						return
					end

					vim.schedule(function()
						require("mini.files").open(current.path)
					end)
					return true
				end,
			},
			smart_tab = {
				char = "<Tab>",
				func = function()
					local current = MiniPick.get_picker_matches().current
					if not current then
						return
					end
					local state = MiniPick.get_picker_state()
					local opts = MiniPick.get_picker_opts()

					if current.fs_type == "directory" then
						opts.source.choose(current)
						return
					end

					opts.source.show(state.buffers.main, current, MiniPick.get_picker_query())
				end,
			},
		},
	})
end, { desc = "File explorer" })
map("n", "<C-x>n", function()
	require("mini.extra").pickers.hipatterns({
		highlighters = { "note", "fixme", "hack", "todo" },
	})
end, { desc = "Find notes" })
map("n", "z=", function()
	require("mini.extra").pickers.spellsuggest()
end, { desc = "Spell Suggest" })
map("n", "<C-x><C-p>", function()
	require("mini.pick").builtin.cli({
		command = { "fd", "--color", "never", "--type=d" },
		spawn_opts = { cwd = "~/projects" },
	}, {
		source = {
			name = "Project Picker",
			choose = function(path)
				local home = vim.fn.expand("~/"):gsub("\\", "/")
				path = path:gsub("\\", "/")
				local cdpath = home .. "projects/" .. path
				print(cdpath)
				vim.notify("Moving to '" .. cdpath .. "'", vim.lsp.log_levels.INFO --[[@as integer]], { title = "CD" })
				vim.fn.chdir(cdpath)

				vim.schedule(function()
					require("mini.files").open(cdpath)
				end)
			end,
		},
	})
end, { desc = "Projects" })

map("n", "<C-x><C-c>", function()
	require("mini.pick").builtin.cli({
		command = { "fd", "--color", "never", "--type=d" },
	}, {
		source = {
			name = "Project Picker",
			choose = function(path)
				path = path:gsub("\\", "/")
				local cwd = vim.uv.cwd():gsub("\\", "/") .. "/"
				vim.notify(
					"Moving to '" .. cwd .. path .. "'",
					vim.lsp.log_levels.INFO --[[@as integer]],
					{ title = "CD" }
				)
				vim.fn.chdir(cwd .. path:sub(1, -2))
			end,
		},
	})
end, { desc = "Change Directory" })

-- FILES
-- map("n", "<leader>e", function()
--   require("mini.files").open()
-- end)
--
-- map("n", "-", function()
--   local bufname = vim.api.nvim_buf_get_name(0)
--   local path = vim.fn.fnamemodify(bufname, ":p")
--
--   if path and vim.uv.fs_stat(path) then
--     require("mini.files").open(bufname, false)
--   end
-- end)

map("n", "<leader>go", function()
	MiniDiff.toggle_overlay()
end, { desc = "Toggle Overlay" })

map("n", "<leader>gq", function()
	vim.fn.setqflist(MiniDiff.export("qf"))
end, { desc = "Export Quickfix" })

map("n", "<leader>oh", "<cmd>normal gxiagxina<cr>", { desc = "Swap Args" })

-- MiniGit
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
nmap_leader('ga', '<Cmd>Git diff --cached<CR>',                   'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',              'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>',                          'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',                  'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                            'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                       'Diff buffer')
nmap_leader('gg', '<Cmd>lua Config.open_lazygit()<CR>',           'Git tab')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',               'Log')
nmap_leader('gL', '<Cmd>' .. git_log_cmd .. ' --follow -- %<CR>', 'Log buffer')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',        'Show at cursor')
