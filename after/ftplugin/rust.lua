vim.opt.formatoptions:remove("o")
vim.lsp.inlay_hint.enable(true)

vim.b.minihipatterns_config = {
	highlighters = {
		rust_todo = { pattern = "todo!", group = "MiniHipatternsTodo" },
	},
}
