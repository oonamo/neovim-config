-- local M = {}
-- M.variants = {}
-- M.variants.prime_pine = {}
-- M.variants.prime_pine.colors = {
-- 	fg = "#e0def4",
-- 	bg = "#28272a",
-- 	green = "#698282",
-- 	yellow = "#ffc2c6",
-- 	magenta = "#dda0dd",
-- 	red = "#ea83a5",
-- 	blue = "#31748f",
-- 	cyan = "#b3c3c4",
-- 	gray = "#3d3d3d",
-- 	orange = "#d3a38d",
-- 	white = "#e0def4",
-- 	black = "#21202e",
-- }
-- M.variants.prime_pine.opts = {
-- 	{ "@keyword", { fg = M.variants.prime_pine.colors.green } },
-- 	{ "Statement", { link = "@keyword" } },
-- 	{ "Function", { fg = M.variants.prime_pine.colors.yellow } },
-- 	{ "@property", { link = "@variable.member" } },
-- 	{ "NormalFloat", { blend = 15 } },
-- 	{ "FloatBorder", { blend = 15 } },
-- 	{ "Title", { bold = true, fg = M.variants.prime_pine.colors.green } },
-- 	{ "Directory", { bold = true, fg = M.variants.prime_pine.colors.green } },
-- 	{ "DiagnosticVirtualTextError", { fg = M.variants.prime_pine.colors.red, bg = "#2e202f", blend = 10 } },
-- 	{ "DiagnosticVirtualTextHint", { fg = "#c4a7e7", bg = "#2a2538", blend = 10 } },
-- 	{ "DiagnosticVirtualTextInfo", { fg = "#9ccfd8", bg = "#292936", blend = 10 } },
-- 	{ "DiagnosticVirtualTextWarn", { fg = "#f6c177", bg = "#2f282c", blend = 10 } },
-- 	{ "CursorLine", { bg = "#262626" } }, -- fg = "#d7d7ff" } },
-- 	{ "CursorLineNr", { fg = M.variants.prime_pine.colors.orange } },
-- 	{ "StatusLine", { bg = "#262626", fg = "#d7d7ff" } },
-- 	{ "@attribute", { fg = M.variants.prime_pine.colors.blue } },
-- 	{ "@text.uri", { fg = M.variants.prime_pine.colors.blue, underline = true } },
-- 	{ "@neorg.headings.1.title.norg", { fg = M.variants.prime_pine.colors.blue } },
-- 	{ "@neorg", { fg = M.variants.prime_pine.colors.red } },
-- 	{ "Float", { fg = M.variants.prime_pine.colors.orange } },
-- 	{ "ModeMsg", { fg = M.variants.prime_pine.colors.green } },
-- 	{ "TelescopeSelection", { fg = M.variants.prime_pine.colors.text, bg = M.colors.bg } },
-- 	{ "TelescopeSelectionCaret", { fg = M.variants.prime_pine.colors.red, bg = M.colors.red } },
-- 	{ "BufferVisible", { bg = "none", fg = M.variants.prime_pine.colors.text, bold = true, italic = true } },
-- }
--
local M = {}
function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	if flavour == "dawn" then
		vim.o.background = "light"
	elseif flavour == "prime" then
		require("colors.prime-pine").setup()
		require("colors.prime-pine").setup_pmenu()
		return
	else
		vim.o.background = "dark"
	end
	require("rose-pine").setup({
		variant = flavour,
	})
	vim.cmd("colorscheme rose-pine")
	-- require("rose-pine").setup({
	-- 	variant = variant,
	-- 	styles = {
	-- 		bold = true,
	-- 		italic = true,
	-- 		transparency = true,
	-- 	},
	-- 	highlight_groups = {
	-- 		-- _nc = "#16141f",
	-- 		-- base = "#191724",
	-- 		-- surface = "#1f1d2e",
	-- 		-- overlay = "#26233a",
	-- 		-- muted = "#6e6a86",
	-- 		-- subtle = "#908caa",
	-- 		-- text = "#e0def4",
	-- 		-- love = "#eb6f92",
	-- 		-- gold = "#f9bd98",
	-- 		-- rose = "#ebbcba",
	-- 		-- pine = "#7f9f9f",
	-- 		-- foam = "#bedfe0",
	-- 		-- iris = "#debee2",
	-- 		-- highlight_low = "#21202e",
	-- 		-- highlight_med = "#403d52",
	-- 		-- highlight_high = "#524f67",
	-- 		-- none = "NONE",
	-- 		TreesitterContext = { bg = "highlight_low" },
	-- 		TreesitterContextBottom = { sp = "rose", underline = true },
	-- 		TreesitterContextNumberBottom = { sp = "rose", underline = true },
	-- 		TelescopeTitle = { fg = "base", bg = "love" },
	-- 		TelescopePromptTitle = { fg = "base", bg = "pine" },
	-- 		TelescopePreviewTitle = { fg = "base", bg = "iris" },
	-- 		BufferVisible = { bg = "none", fg = "text", bold = true, italic = true },
	-- 		NoiceCmdlinePopupBorder = { fg = "subtle", bg = "subtle" },
	-- 		DiagnosticUnderlineWarn = { sp = "gold", undercurl = true },
	-- 		DiagnosticUnderlineOk = { sp = "gold", undercurl = true },
	-- 		DiagnosticUnderlineError = { sp = "love", undercurl = true },
	-- 	},
	-- })
	--
	-- if vim.g.transparent_enabled and vim.g.neovide then
	-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- end
	--
	-- vim.cmd("colorscheme " .. O.colorscheme)
end

return M
