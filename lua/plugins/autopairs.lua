return {
	"windwp/nvim-autopairs",
	config = function()
		local npairs = require("nvim-autopairs")
		local remap = vim.api.nvim_set_keymap
		npairs.setup({
			-- enable_check_bracket_line = false,
			map_bs = false,
			map_cr = false,
		})
		_G.MUtils = {}

		MUtils.CR = function()
			if vim.fn.pumvisible() ~= 0 then
				if vim.fn.complete_info({ "selected" }).selected ~= -1 then
					return npairs.esc("<c-y>")
				else
					return npairs.esc("<c-e>") .. npairs.autopairs_cr()
				end
			else
				return npairs.autopairs_cr()
			end
		end
		remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

		MUtils.BS = function()
			if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
				return npairs.esc("<c-e>") .. npairs.autopairs_bs()
			else
				return npairs.autopairs_bs()
			end
		end
		remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
	end,
	event = "InsertEnter",
	enabled = false,
}
