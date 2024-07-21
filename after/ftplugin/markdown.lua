-- vim.opt_local.conceallevel = 2
if not vim.g.neovide then
	vim.opt_local.smoothscroll = true
end
vim.keymap.set({ "n", "v" }, "j", "gj", { buffer = true, silent = true })
vim.keymap.set({ "n", "v" }, "k", "gk", { buffer = true, silent = true })
-- vim.opt_local.nu = false
-- vim.opt_local.signcolumn = "no"
-- vim.opt_local.rnu = false
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "list:-1"
vim.b.miniindentscope_disable = true
vim.opt_local.sidescrolloff = 1000
vim.opt_local.scrolloff = 10

if package.loaded["markview"] then
	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = vim.api.nvim_get_current_buf(),
		callback = function()
			if vim.fn.mode():sub(1, 1) == "i" then
				return
			end
			local cursor = vim.api.nvim_win_get_cursor(0)
			local line = vim.fn.getline(cursor[1])
			local is_wiki_link = line:match("%[%[.*%]%]")
			if is_wiki_link then
				vim.o.concealcursor = ""
				return
			end
			local is_md_link = line:match("%[.*%]%(.*%)")
			if is_md_link then
				vim.o.concealcursor = ""
				return
			end

			local is_callout = line:match("> %[!.*%]")
			if is_callout then
				vim.o.concealcursor = ""
				return
			end
			-- local is_todo = line:match("- %[.%]")
			-- if is_todo then
			-- 	vim.o.concealcursor = ""
			-- 	return
			-- end
			vim.o.concealcursor = "n"
		end,
	})
end
