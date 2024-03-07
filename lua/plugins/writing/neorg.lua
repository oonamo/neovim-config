return {
	"nvim-neorg/neorg",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	ft = "norg",
	cmd = { "Neorg" },
	opts = {
		load = {
			["core.keybinds"] = {
				config = {
					neorg_leader = "<Leader>n",
					hook = function(keybinds)
						local function remap_event(mode, lhs, rhs)
							keybinds.remap_event("norg", mode, lhs, rhs)
						end
						remap_event("i", "<C-j>", "core.itero.next-iteration")

						-- remap_event("n", "<C-s>", "core.integrations.telescope.find_linkable")
						keybinds.remap("norg", "n", "<localleader>toc", ":Neorg toc<cr>")
					end,
				},
			},
			["core.defaults"] = {},
			["core.esupports.metagen"] = {
				config = {
					type = "auto",
				},
			},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.concealer"] = {
				config = {
					folds = true, -- annoying sometimes
					init_open_folds = "always",
				},
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						["winter"] = "~/Documents/School/winter2024",
						["spring"] = "~/Documents/School/spring2024",
						["projects"] = "~/Documents/Projects",
					},
					default_workspace = "spring",
				},
			},
			["core.ui"] = {},
			["core.summary"] = {},
		},
	},
	config = function(_, opts)
		local autocmds = require("onam.autocmds")
		autocmds.setup_writing_cmds()
		require("neorg").setup(opts)
	end,
	keys = {
		{ "<leader>nn", "<cmd>Neorg workspace projects<cr>", desc = "Open Neorg projects" },
		{
			"<leader>ns",
			":cd ~/Documents/School/spring2024 | Neorg index <CR>",
			desc = "Open Neorg index and cd",
			silent = true,
		},
		{ "<leader>ntoc", "<cmd>Neorg toc<cr>", desc = "Open Neorg toc" },
		{ "<leader>nr", "<cmd>Neorg return<cr>", desc = "Return from neorg" },
		{ "<leader>no", "<cmd>Neorg index<cr>", desc = "Open Neorg index locally" },
	},
	build = ":Neorg sync-parsers",
}
