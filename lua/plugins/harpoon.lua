return {
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		branch = "harpoon2",
		config = function()
			local harpoon = require("harpoon")
			local Path = require("plenary.path")
			local Extensions = require("harpoon.extensions")
			vim.api.nvim_create_augroup("HarpoonStatus", {
				clear = true,
			})
			local function normalize_path(buf_name, root)
				return Path:new(buf_name):make_relative(root)
			end
			--TODO: Can probaly make cool stuff with this
			--IE: grab current files with a warning or error
			--Record macros or registers into the list
			harpoon:setup({
				["cmd"] = {
					create_list_item = function(config, name)
						name = name
							or normalize_path(
								vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
								config.get_root_dir()
							)

						local bufnr = vim.fn.bufnr(name, false)

						local pos = { 1, 0 }
						if bufnr ~= -1 then
							pos = vim.api.nvim_win_get_cursor(0)
						end

						vim.api.nvim_exec_autocmds("User", {
							pattern = "HarpoonListChange",
							group = "HarpoonStatus",
							data = {
								name = name,
								list = harpoon:list("cmd"),
							},
						})

						return {
							value = name,
							context = {
								row = pos[1],
								col = pos[2],
							},
						}
					end,
					select = function(list_item, list, options)
						options = options or {}
						if list_item == nil then
							return
						end

						vim.api.nvim_exec_autocmds("User", {
							pattern = "HarpoonListSelect",
							group = "HarpoonStatus",
							data = {
								name = list_item.value,
								list = list,
							},
						})

						local bufnr = vim.fn.bufnr(list_item.value)
						local set_position = false
						if bufnr == -1 then
							set_position = true
							bufnr = vim.fn.bufnr(list_item.value, true)
						end
						if not vim.api.nvim_buf_is_loaded(bufnr) then
							vim.fn.bufload(bufnr)
							vim.api.nvim_set_option_value("buflisted", true, {
								buf = bufnr,
							})
						end

						if options.vsplit then
							vim.cmd("vsplit")
						elseif options.split then
							vim.cmd("split")
						elseif options.tabedit then
							vim.cmd("tabedit")
						end

						vim.api.nvim_set_current_buf(bufnr)

						if set_position then
							vim.api.nvim_win_set_cursor(0, {
								list_item.context.row or 1,
								list_item.context.col or 0,
							})
						end

						Extensions.extensions:emit(Extensions.event_names.NAVIGATE, {
							buffer = bufnr,
						})
					end,
					BufLeave = function(arg, list)
						local bufnr = arg.buf
						local bufname = vim.api.nvim_buf_get_name(bufnr)
						local item = list:get_by_display(bufname)

						if item then
							local pos = vim.api.nvim_win_get_cursor(0)

							item.context.row = pos[1]
							item.context.col = pos[2]
						end
						vim.api.nvim_exec_autocmds("User", {
							pattern = "HarpoonBufLeave",
							group = "HarpoonStatus",
							data = {
								name = bufname,
								list = list,
							},
						})
					end,
				},
			})

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list("cmd"):append()
				-- harpoon:list():append()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list("cmd"))
			end)

			vim.keymap.set("n", "<leader>1", function()
				harpoon:list("cmd"):select(1)
			end)
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list("cmd"):select(2)
			end)

			vim.keymap.set("n", "<leader>3", function()
				harpoon:list("cmd"):select(3)
			end)

			vim.keymap.set("n", "<leader>4", function()
				harpoon:list("cmd"):select(4)
			end)

			vim.keymap.set("n", "<leader>5", function()
				harpoon:list("cmd"):select(5)
			end)
			vim.keymap.set("n", "<leader>6", function()
				harpoon:list("cmd"):select(6)
			end)
			vim.keymap.set("n", "<leader>7", function()
				harpoon:list("cmd"):select(7)
			end)
			vim.keymap.set("n", "<leader>8", function()
				harpoon:list("cmd"):select(8)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list("cmd"):prev()
			end)
			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list("cmd"):next()
			end)
		end,
	},
}
