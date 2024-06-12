local M = {}

function M.apply_custom_highlights(palette, is_light)
	vim.o.background = is_light and "light" or "dark"
	require("mini.base16").setup({ palette = palette })
	local hi = function(name, data)
		vim.api.nvim_set_hl(0, name, data)
	end

	-- I prefer bold headlines and titles
	hi("Title", { fg = palette.base0C, bg = nil, bold = true })

	hi("MiniAnimateNormalFloat", { bg = palette.base01, blend = 40 })

	-- Better markdown code block compat w/ mini.hues
	-- hi("CodeBlock", { bg = palette.base03 })

	-- I prefer italic fonts as I use fonts with beautiful italics.
	-- Some examples: Operator Mono, Berkeley Mono, PragmataPro, Radon
	hi("Comment", { fg = palette.base03, bg = nil, italic = true })
	hi("@markup.math", { fg = palette.base0d, bg = nil })
	hi("@markup.quote", { fg = palette.base03, bg = palette.base01, bold = true, italic = true })
	hi("ObsidianTodo", { bold = true, fg = "#f78c6c" })
	hi("ObsidianDone", { bold = true, fg = "#89ddff" })
	hi("ObsidianRightArrow", { bold = true, fg = "#f78c6c" })
	hi("ObsidianTilde", { bold = true, fg = "#ff5370" })
	hi("ObsidianBullet", { bold = true, fg = "#89ddff" })
	hi("ObsidianRefText", { underline = true, fg = "#c792ea" })
	hi("ObsidianExtLinkIcon", { fg = "#c792ea" })
	hi("ObsidianTag", { italic = true, fg = "#89ddff" })
	hi("ObsidianHighlightText", { bg = "#75662e" })
	hi("MiniTablineCurrent", { link = "Normal" })
	hi("MiniTablineVisible", { link = "MiniTablineVisible" })
	hi("MiniTablineHidden", { bg = palette.base02, fg = palette.base03 })
	hi("MiniTablineModifiedCurrent", { link = "MiniTablineCurrent" })
	hi("MiniTablineModifiedVisible", { link = "MiniTablineModifiedCurrent" })
	hi("MiniTablineModifiedHidden", { bg = palette.base03 })
	hi("MiniTablineFill", { link = "MiniTablineHidden" })
	hi("MiniTablineTabpagesection", { link = "MiniTablineHidden" })

	-- if O.ui.transparency.enable then
	-- 	hi("LineNr", { link = "Normal" })
	-- 	hi("SignColumn", { link = "Normal" })
	-- 	hi("FoldColumn", { link = "Normal" })
	-- 	hi("CursorlineFold", { link = "Normal" })
	-- 	hi("CursorLineSign", { link = "Normal" })
	-- 	hi("ColorColumn", { line = "Normal" })
	-- 	-- hi("LineNr", { blend = 100 })
	-- 	-- hi("SignColumn", { blend = 100 })
	-- end
	-- hi("DiagnosticVirtualTextError", { fg = p.red, bg = p.red_bg, italic = true })
	-- hi("DiagnosticVirtualTextHint", { fg = p.cyan, bg = p.cyan_bg, italic = true })
	-- hi("DiagnosticVirtualTextInfo", { fg = p.blue, bg = p.blue_bg, italic = true })
	-- hi("DiagnosticVirtualTextOk", { fg = p.green, bg = p.green_bg, italic = true })
	-- hi("DiagnosticVirtualTextWarn", { fg = p.yellow, bg = p.yellow_bg, italic = true })

	-- Highlight patterns for highlighting the whole line and hiding colon.
	-- See https://github.com/echasnovski/mini.nvim/discussions/783
	-- hi("MiniHipatternsFixmeBody", { fg = p.red, bg = p.bg })
	-- hi("MiniHipatternsFixmeColon", { bg = p.red, fg = p.red, bold = true })
	-- hi("MiniHipatternsHackBody", { fg = p.yellow, bg = p.bg })
	-- hi("MiniHipatternsHackColon", { bg = p.yellow, fg = p.yellow, bold = true })
	-- hi("MiniHipatternsNoteBody", { fg = p.cyan, bg = p.bg })
	-- hi("MiniHipatternsNoteColon", { bg = p.cyan, fg = p.cyan, bold = true })
	-- hi("MiniHipatternsTodoBody", { fg = p.blue, bg = p.bg })
	-- hi("MiniHipatternsTodoColon", { bg = p.blue, fg = p.blue, bold = true })

	-- Highlight patterns for deemphasizing the directory name, so the
	-- filename is more prominent. Visually, this makes it faster to
	-- identify the name of the file.
	-- See https://github.com/echasnovski/mini.nvim/discussions/36#discussioncomment-8889147
	-- hi("MiniStatuslineDirectory", { fg = p.fg_mid2, bg = p.accent_bg })
	-- hi("MiniStatuslineFilename", { fg = p.fg_mid, bg = p.accent_bg, bold = true })
	-- hi("MiniStatuslineFilenameModified", { link = "Todo" })
	-- hi("MiniStatuslineInactive", { fg = p.fg_mid2, bg = p.bg_mid })

	-- I like my vertical split divider to be the same color as my inactive
	-- horizontal status bar color, so it's consistent both vertically and
	-- horizontally when laststatus=2.
	-- hi("VertSplit", { fg = p.bg_mid, bg = nil })
	-- hi("WinSeparator", { fg = p.bg_mid, bg = nil })
	utils.create_virt_diagnostics_hl()
end

return M
