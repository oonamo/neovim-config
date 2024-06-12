return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-j>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-l>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
    keys = function()
        local harpoon = require("harpoon")
        return {

		utils.vim_to_lazy_map("n", "<leader>a", function()
			harpoon:list():add()
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
