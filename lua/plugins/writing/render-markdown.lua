-- TODO: Prevent loading outside of floating windows
return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		start_enabled = true,
		-- headings = { "❯", "❯", "❯", "❯", "❯", "❯" },
		-- headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
		headings = { "◈ ", "◆ ", "◇ ", "❖ ", "⟡ ", "⋄ " },

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
				backgrounds = { "CursorLine" },
				-- backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
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
		win_options = {
			conceallevel = {
				rendered = 2,
				default = 2,
			},
			concealcursor = {
				rendered = "",
				default = "",
			},
		},
	},
}
