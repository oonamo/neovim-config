return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
	end,
	keys = function()
		local harpoon = require("harpoon")
		return {
			utils.vim_to_lazy_map("n", "<leader>a", function()
				harpoon:list():add()
			end, {}),
			utils.vim_to_lazy_map("n", "<leader>ph", function()
				if not MiniPick then
					require("mini.pick").setup()
				end
				local items = harpoon:list().items
				local values = vim.iter(items)
					:enumerate()
					:map(function(i, item)
						return i .. " " .. item.value
					end)
					:totable()
				local old_map = MiniPick.config.mappings.stop
				MiniPick.config.mappings.stop = "<C-e>"
				vim.ui.select(values, {}, function(selection)
					MiniPick.config.mappings.stop = old_map
					if not selection then
						return
					end
					local idx = selection:sub(1, 1)
					harpoon:list():select(tonumber(idx))
				end)
			end, {}),
			utils.vim_to_lazy_map("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, {}),
			utils.vim_to_lazy_map("n", "<C-h>", function()
				harpoon:list():select(1)
			end, {}),
			utils.vim_to_lazy_map("n", "<C-j>", function()
				harpoon:list():select(2)
			end, {}),
			utils.vim_to_lazy_map("n", "<C-k>", function()
				harpoon:list():select(3)
			end, {}),
			utils.vim_to_lazy_map("n", "<C-l>", function()
				harpoon:list():select(4)
			end, {}),
			utils.vim_to_lazy_map("n", "<leader>5", function()
				harpoon:list():select(5)
			end, {}),
			utils.vim_to_lazy_map("n", "<leader>6", function()
				harpoon:list():select(6)
			end, {}),
			utils.vim_to_lazy_map("n", "<leader>7", function()
				harpoon:list():select(7)
			end, {}),
			utils.vim_to_lazy_map("n", "<leader>8", function()
				harpoon:list():select(8)
			end, {}),
			utils.vim_to_lazy_map("n", "<leader>9", function()
				harpoon:list():select(9)
			end, {}),
			-- Toggle previous & next buffers stored within Harpoon list
			utils.vim_to_lazy_map("n", "<C-S-P>", function()
				harpoon:list():prev()
			end, {}),
			utils.vim_to_lazy_map("n", "<C-S-N>", function()
				harpoon:list():next()
			end, {}),
		}
	end,
}
