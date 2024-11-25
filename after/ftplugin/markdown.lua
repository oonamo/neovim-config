-- vim.opt_local.conceallevel = 2
if not vim.g.neovide then
	vim.opt_local.smoothscroll = true
end
vim.keymap.set({ "n", "v" }, "j", "gj", { buffer = true, silent = true })
vim.keymap.set({ "n", "v" }, "k", "gk", { buffer = true, silent = true })
vim.opt_local.nu = false
vim.opt_local.rnu = false
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
-- vim.opt_local.breakindent = true
-- vim.opt_local.breakindentopt = "list:-1"
vim.b.miniindentscope_disable = true
vim.opt_local.sidescrolloff = 1000
vim.opt_local.scrolloff = 10

local has_mini_ai, mini_ai = pcall(require, "mini.ai")
if has_mini_ai then
	vim.b.miniai_config = {
		custom_textobjects = {
			-- Bold
			["*"] = mini_ai.gen_spec.pair("*", "*", { type = "greedy" }),
			-- Strikethrough
			["_"] = mini_ai.gen_spec.pair("_", "_", { type = "greedy" }),
		},
	}
end

local has_surround, mini_surround = pcall(require, "mini.surround")
if has_surround then
	vim.b.minisurround_config = {
		custom_surroundings = {
			E = { input = { "%*%*().-()%*%*" }, output = { left = "*", right = "*" } },
			L = {
				input = { "%[().-()%]%(.-%)" },
				output = function()
					local link = mini_surround.user_input("Link: ")
					return { left = "[", right = "](" .. link .. ")" }
				end,
			},
		},
	}
end
