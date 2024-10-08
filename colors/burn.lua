local function hi(name, value)
	vim.api.nvim_set_hl(0, name, value)
end
local p = {
	base00 = "#383838",
	base01 = "#404040",
	base02 = "#606060",
	base03 = "#6f6f6f",
	base04 = "#808080",
	base05 = "#dcdccc",
	base06 = "#c0c0c0",
	base07 = "#ffffff",
	-- base08 = "#dca3a3",
	base08 = "#efdcbc",
	base09 = "#dfaf8f",
	base0A = "#e0cf9f",
	-- base0B = "#5f7f5f",
	-- base0B = "#efef8f",
	base0B = "#cc9393",
	base0C = "#93e0e3",
	-- base0D = "#7cb8bb",
	-- base0D = "#5f7f5f",
	base0D = "#efef8f",
	base0E = "#dc8cc3",
	base0F = "#8f8f8f",
}

require("mini.base16").setup({ palette = p })

do
	hi("SignColumn", { link = "Normal" })
	hi("LineNr", { bg = "#383838" })
	hi("LineNrAbove", { bg = "#383838" })
	hi("LineNrBelow", { bg = "#383838" })
	hi("CursorLineNr", { fg = p.base0B, bg = p.base00 })
end
