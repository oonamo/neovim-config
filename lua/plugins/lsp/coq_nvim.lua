return {
	"ms-jpq/coq_nvim",
	branch = "coq",
	dependencies = {
		{
			"ms-jpq/coq.artifacts",
			branch = "artifacts",
		},
		{
			"ms-jpq/coq.thirdparty",
			branch = "3p",
			-- config = function()
			-- 	require("3p")({
			-- 		{ src = "nvimlua", short_name = "nLUA" },
			-- 	})
			-- end,
		},
	},
	event = "InsertEnter",
	init = function()
		vim.g.coq_settings = {
			auto_start = "shut-up",
			keymap = {
				jump_to_mark = "<C-x>",
			},
		}
	end,
}
