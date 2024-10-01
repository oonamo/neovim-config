local starter = require("mini.starter")

starter.setup({
	evaluate_single = true,
	items = {
		starter.sections.telescope(),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.aligning("center", "center"),
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniStarterOpened",
	callback = vim.schedule_wrap(function()
		vim.opt_local.rnu = false
		vim.opt_local.number = false
		vim.opt_local.list = false
		vim.b.miniindentscope_disable = true
	end),
})
