local map = vim.keymap.set
-- PICK
map("n", "<C-p>", "<cmd>Pick files<cr>")
map("n", "<leader>f", "<cmd>Pick files<cr>")
map("n", "<leader>,", "<cmd>Pick buffers<cr>")
map("n", "<C-F>", "<cmd>Pick grep_live<cr>")
map("n", "<C-x>h", "<cmd>Pick help<cr>")
map("n", "<leader>gw", "<cmd>Pick grep<cr>", { desc = "Grep word" })
map("n", "<leader>\\", "<cmd>Pick buf_lines<cr>", { desc = "Find line" })
map("n", "<C-x>i", function()
	require("mini.extra").pickers.hl_groups()
end, { desc = "Find highlights" })
map("n", "<C-x>m", function()
	require("mini.extra").pickers.marks()
end, { desc = "Find marks" })
map("n", "<leader>of", "<cmd>Pick oldfiles<cr>", { desc = "Old files (cwd)" })
map("n", "<C-x>b", "<cmd>Pick buffers<cr>", { desc = "Buffers" })
map("n", "<C-x><C-f>", function()
	require("mini.extra").pickers.explorer({}, {
		mappings = {
			go_up_level = {
				char = "<C-h>", -- Same as C BKSP, emacs lol
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
		},
	})
end, { desc = "File explorer" })
map("n", "<leader>pn", function()
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
end)
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
end)

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

-- Diff
map("n", "<leader>gdo", function()
	MiniDiff.toggle_overlay()
end, { desc = "MiniDiff toggle overlay" })

map("n", "<leader>ghq", function()
	vim.fn.setqflist(MiniDiff.export("qf"))
end)
