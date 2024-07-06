require("mini.git").setup({
	command = {
		split = "vertical",
	},
})

vim.keymap.set("n", "<leader>gs", "<CMD>Git status<CR>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>gac", "<CMD>Git add %<CR>", { desc = "Git Add Current" })
vim.keymap.set("n", "<leader>gaa", "<CMD>Git add .<CR>", { desc = "Git Add All" })
vim.keymap.set("n", "<leader>gp", "<CMD>Git push<CR>", { desc = "Git Push" })

-- TODO: Wait for merge with main
vim.keymap.set("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "Git commit" })
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniGitCommandSplit",
	callback = function(data)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", { desc = "quit", buffer = data.buf })
	end,
})

-- Use only HEAD name as summary string
local format_summary = function(data)
	-- Utilize buffer-local table summary
	local summary = vim.b[data.buf].minigit_summary
	vim.b[data.buf].minigit_summary_string = summary.head_name or ""
end

local au_opts = { pattern = "MiniGitUpdated", callback = format_summary }
vim.api.nvim_create_autocmd("User", au_opts)
