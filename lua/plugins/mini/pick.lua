local pick = require("mini.pick")
local function win_config()
	return {
		height = math.floor(0.4 * vim.o.lines),
		width = vim.o.columns,
	}
end

local function send_all_to_qf()
	local mappings = MiniPick.get_picker_opts().mappings
	local keys = mappings.mark_all .. mappings.choose_marked
	vim.api.nvim_input(vim.api.nvim_replace_termcodes(keys, true, true, true))
end

pick.setup({
	window = { config = win_config },
	mappings = {
		choose_marked = "<C-l>",
		send_all_to_qf = {
			char = "<C-q>",
			func = send_all_to_qf,
		},
	},
	options = {
		use_cache = true,
	},
})

vim.ui.select = MiniPick.ui_select
local function m(lhs, rhs, opts)
	vim.keymap.set("n", lhs, rhs, opts)
end
local e_pick = MiniExtra.pickers
m("<C-P>", pick.builtin.files, { desc = "files" })
m("<C-F>", pick.builtin.grep_live, { desc = "grep live" })
m("<leader>fgs", pick.builtin.grep, { desc = "grep" })
m("<leader>ff", pick.builtin.cli, { desc = "cli" })
m("<leader>fh", pick.builtin.help, { desc = "help" })
m("<leader>fr", pick.builtin.resume, { desc = "resume" })

-- Extras
m("<leader>pehg", e_pick.hl_groups, { desc = "hl groups" })
m("<leader>peH", e_pick.history, { desc = "history" })
m("<leader>peK", e_pick.keymaps, { desc = "keymaps" })
m("<leader>pem", e_pick.marks, { desc = "marks" })

m("<leader>pelq", function()
	e_pick.list({ scope = "quickfix" })
end, { desc = "pick qf" })
m("<leader>pell", function()
	e_pick.list({ scope = "location" })
end, { desc = "pick ll" })
m("<leader>pelj", function()
	e_pick.list({ scope = "jump" })
end, { desc = "pick jumplist" })
m("<leader>pelc", function()
	e_pick.list({ scope = "change" })
end, { desc = "pick changelist" })

m("z=", e_pick.spellsuggest, { desc = "spell suggest" })
