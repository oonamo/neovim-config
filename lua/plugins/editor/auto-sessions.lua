return {
	"rmagatti/auto-session",
	opts = {
		auto_restore_enabled = true,
	},
	keys = {
		{ "<leader>ws", "<cmd>SessionSave<CR>" },
		{ "<leader>wr", "<cmd>SessionRestore<CR>" },
	},
}
