-- if not pcall(require, "harpoon") then
-- 	return
-- end
return {
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		branch = "harpoon2",
		opts = {
			setting = {
				save_on_toggle = true,
			},
		},
		config = function(_, opts)
			local harpoon = require("harpoon")
			local Extensions = require("harpoon.extensions")
			vim.api.nvim_create_augroup("HarpoonStatus", {
				clear = true,
			})

			--TODO: Add opts for different harpoon modes
			local function exec_harpoon_autocmds(list, cmd_opts)
				cmd_opts = cmd_opts or { pattern = "HarpoonListChange" }
				vim.api.nvim_exec_autocmds("User", {
					pattern = cmd_opts.pattern,
					group = "HarpoonStatus",
					data = {
						list = list.list,
						idx = list.idx,
						item = list.item,
					},
				})
			end
			harpoon:setup(opts)
			harpoon:extend(Extensions.builtins.navigate_with_number())
			harpoon:extend({
				NAVIGATE = function()
					vim.api.nvim_exec_autocmds("User", {
						pattern = "HarpoonNavigate",
						group = "HarpoonStatus",
						data = {
							list = harpoon:list(),
						},
					})
				end,
				SELECT = function(list)
					exec_harpoon_autocmds(list)
				end,
				REORDER = function(list)
					exec_harpoon_autocmds(list)
				end,
				ADD = function(list)
					-- add_new_item(list)
					exec_harpoon_autocmds(list, { pattern = "HarpoonListAdd" })
				end,
				REMOVE = function(list)
					-- remove_deleted_item(list)
					exec_harpoon_autocmds(list, { pattern = "HarpoonListRemove" })
				end,
			})

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():append()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end)
			vim.keymap.set("n", "<leader>5", function()
				harpoon:list():select(5)
			end)
			vim.keymap.set("n", "<leader>6", function()
				harpoon:list():select(6)
			end)
			vim.keymap.set("n", "<leader>7", function()
				harpoon:list():select(7)
			end)
			vim.keymap.set("n", "<leader>8", function()
				harpoon:list():select(8)
			end)
		end,
	},
}
