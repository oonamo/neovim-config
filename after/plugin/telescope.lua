local builtin = require("telescope.builtin")
--Find built in files
vim.keymap.set("n", "<leader>pf", builtin.find_files, {
	desc = "find project files",
})
--Git files
vim.keymap.set("n", "<C-p>", builtin.git_files, {
	desc = "Find git files",
})
--Search for string in files
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Search for a string in telescope" })
