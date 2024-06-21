return {
	"ChuufMaster/markdown-toc",
	cmd = { "GenerateTOC", "DeleteTOC" },
	opts = {

		-- The heading level to match (i.e the number of "#"s to match to) max 6
		heading_level_to_match = -1,

		-- Set to True display a dropdown to allow you to select the heading level
		ask_for_heading_level = false,

		-- TOC default string
		-- WARN
		toc_format = "%s- [%s](<%s#%s>)",
	},
	keys = {
		{
			"<leader>tg",
			"<CMD>GenerateTOC<CR>",
			desc = "Generate Table of Contents",
		},
		{
			"<leader>td",
			"<CMD>DeleteTOC<CR>",
			desc = "Delete Table of Contents",
		},
	},
}
