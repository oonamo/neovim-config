return {
	"stevearc/overseer.nvim",
	opts = {},
	cmd = { "OverseerRun", "OverseerToggle" },
	keys = {
		{ "<leader>br", "<CMD>OverseerRun<CR>", desc = "Overseer run" },
		{ "<leader>bt", "<CMD>OverseerToggle<CR>", desc = "Overseer toggle" },
	},
}
