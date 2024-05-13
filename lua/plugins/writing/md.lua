return {
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "markdown" },
		opts = {
			-- headings = { "❯", "❯", "❯", "❯", "❯", "❯" },
			-- HACK: Disable checkboxes and list icons by removing it's query
			markdown_query = [[
			   (atx_heading [
			         (atx_h1_marker)
			         (atx_h2_marker)
			         (atx_h3_marker)
			         (atx_h4_marker)
			         (atx_h5_marker)
			         (atx_h6_marker)
			     ] @heading)

			(thematic_break) @dash

			(fenced_code_block) @code
			 (block_quote (block_quote_marker) @quote_marker)
			(block_quote (paragraph (inline (block_continuation) @quote_marker)))

			(pipe_table) @table
			(pipe_table_header) @table_head
			(pipe_table_delimiter_row) @table_delim
			(pipe_table_row) @table_row
			        ]],
			headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			-- bullets = { "●", "○", "◆", "◇" },
			checkbox = {
				-- [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "", hl_group = "ObsidianDone" },
				-- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
				-- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				-- Character that will replace the [ ] in unchecked checkboxes
				unchecked = "󰄱",
				-- Character that will replace the [x] in checked checkboxes
				checked = "",
			},
			highlights = {
				heading = {
					backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
					foregrounds = {
						"markdownH1",
						"markdownH2",
						"markdownH3",
						"markdownH4",
						"markdownH5",
						"markdownH6",
					},
				},
			},
			conceal = {
				-- conceallevel used for buffer when not being rendered, get user setting
				default = vim.opt.conceallevel:get(),
				-- conceallevel used for buffer when being rendered
				rendered = vim.opt.conceallevel:get(),
			},
		},
		config = function(_, opts)
			local _, _, hl = utils.get_hl("Headline1")
			if hl ~= nil then
				local hls = {
					"Headline1",
					"Headline2",
					"Headline3",
					"Headline4",
					"Headline5",
					"Headline6",
				}
				opts.highlights.heading.backgrounds = hls
			end
			require("render-markdown").setup(opts)
		end,
	},
	-- {
	-- 	"tadmccorkle/markdown.nvim",
	-- 	name = "markdown-keys",
	-- 	ft = { "markdown" },
	-- },
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
		keys = { "<leader>tm", desc = "toggle table mode" },
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		-- init = function()
		-- 	vim.g.mkdp_filetypes = { "markdown" }
		-- end,
		ft = { "markdown" },
	},
	-- {
	-- 	"jbyuki/nabla.nvim",
	-- 	ft = { "markdown" },
	-- 	config = function()
	-- 		local nabla_float_grp = vim.api.nvim_create_augroup("nabla_float", { clear = true })
	-- 		vim.api.nvim_create_autocmd("CursorHold", {
	-- 			callback = function()
	-- 				require("nabla").popup()
	-- 			end,
	-- 			group = nabla_float_grp,
	-- 		})
	-- 	end,
	-- 	keys = {
	-- 		{
	-- 			"<leader>nt",
	-- 			function()
	-- 				require("nabla").popup()
	-- 			end,
	-- 			desc = "nabla",
	-- 		},
	-- 		{
	-- 			"<leader>nv",
	-- 			function()
	-- 				require("nabla").toggle_virt({ align_center = true })
	-- 			end,
	-- 			desc = "nabla",
	-- 		},
	-- 	},
	-- },
}
