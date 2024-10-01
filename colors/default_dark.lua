local ok, _ = pcall(require, "mini.base16")
vim.cmd.hi("clear")
local p = {
	base00 = "#181818",
	base01 = "#282828",
	base02 = "#383838",
	base03 = "#585858",
	base04 = "#b8b8b8",
	base05 = "#d8d8d8",
	base06 = "#e8e8e8",
	base07 = "#f8f8f8",
	base08 = "#ab4642",
	base09 = "#dc9656",
	base0A = "#f7ca88",
	base0B = "#a1b56c",
	base0C = "#86c1b9",
	base0D = "#7cafc2",
	base0E = "#ba8baf",
	base0F = "#a16946",
}

local function apply()
	vim.cmd.hi("clear")
	require("mini.base16").setup({ palette = p })
	local hls = {
		Delimiter = { fg = p.base05 },
		Special = { fg = p.base0A },
		Charcter = { fg = p.base09 },
		["@lsp.type.variable"] = { fg = p.base06 },
		Identifier = { fg = "#DE8452" },
		["@lsp.mod.global"] = { fg = p.base08 },
		StatusLine = { bg = p.base01, fg = p.base04 },
		CursorLineNr = { fg = p.base04, bold = true, bg = p.base01 },
		["@markup.heading.1.markdown"] = { fg = p.base08 },
		["@markup.heading.2.markdown"] = { fg = p.base09 },
		["@markup.heading.3.markdown"] = { fg = p.base0A },
		["@markup.heading.4.markdown"] = { fg = p.base0B },
		["@markup.heading.5.markdown"] = { fg = p.pase0B },
		["@markup.heading.6.markdown"] = { fg = p.base0C },
		RenderMarkdownH1 = { fg = p.base08 },
		RenderMarkdownH2 = { fg = p.base09 },
		RenderMarkdownH3 = { fg = p.base0A },
		RenderMarkdownH4 = { fg = p.base0B },
		RenderMarkdownH5 = { fg = p.pase0B },
		RenderMarkdownH6 = { fg = p.base0C },
		-- RenderMarkdownH1Bg = { fg = p.base08, bg = p.base01 },
		-- RenderMarkdownH2Bg = { fg = p.base09, bg = p.base01 },
		-- RenderMarkdownH3Bg = { fg = p.base0A, bg = p.base01 },
		-- RenderMarkdownH4Bg = { fg = p.base0B, bg = p.base01 },
		-- RenderMarkdownH5Bg = { fg = p.base0C, bg = p.base01 },
		-- RenderMarkdownH6Bg = { fg = p.baseOD, bg = p.base01 },
	}

	for k, v in pairs(hls) do
		vim.api.nvim_set_hl(0, k, v)
	end
	utils.trigger_event("ColorScheme")
	vim.g.colors_name = "default_dark"
end

if not ok then
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		once = true,
		callback = function()
			apply()
			return true
		end,
	})
else
	apply()
end
