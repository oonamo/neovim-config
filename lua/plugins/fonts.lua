local opts = { noremap = true, silent = true }
return {
	{
		"ziontee113/icon-picker.nvim",
		opts = {
			disable_legacy_commands = true,
		},
		keys = {
			{ "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts },
			{ "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts }, --> Yank the selected icon into registe
			{ "<C-i>", "<cmd>IconPickerInsert<cr>", opts },
		},
	},
}
