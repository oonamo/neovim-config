vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({
		"NvChad/nvim-colorizer.lua",
	})
	use("ms-jpq/coq_nvim")
	use("ms-jpq/coq.artifacts")
	use("CRAG666/code_runner.nvim")
	use({
		"https://github.com/Maan2003/lsp_lines.nvim",
		as = "lsp_lines",
		config = function()
			require("lsp_lines").setup({
				vim.diagnostic.config({ virtual_text = false }),
			})
		end,
	})
	use("xiyaowong/transparent.nvim")
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("windwp/nvim-ts-autotag")
	use("ThePrimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({ "simrat39/rust-tools.nvim", requires = { "neovim/nvim-lspconfig" } }) -- Required
	use("mfussenegger/nvim-dap")
	-- leet code
	-- Formaters
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end,
	})

	-- Navigation
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- tree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})
	--Terminal tree
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Which keys
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	--Auto Pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	--Status Bar
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- Themes
	use("zaldih/themery.nvim")
	use("Yazeed1s/oh-lucy.nvim")
	use("kvrohit/mellow.nvim")
	use({
		"rose-pine/neovim",
		as = "rose-pine",
	})
	use("EdenEast/nightfox.nvim") -- Packer
end)
