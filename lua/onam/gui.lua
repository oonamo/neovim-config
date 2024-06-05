local opt, o, g = vim.opt, vim.o, vim.g
opt.guicursor = "i:ver20,n-v-sm:block,c-ci-ve:ver20,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
-- opt.guicursor = ""
g.neovide_scale_factor = 1.0
g.neovide_hide_mouse_when_typing = true
g.neovide_theme = "auto"
-- g.neovide_scroll_animation_length = 0
opt.linespace = 15
g.neovide_transparency_point = 1.0
g.neovide_underline_stroke_scale = 1.5
g.neovide_transparency = 1.0
vim.g.neovide_padding_top = 15
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 15
vim.g.neovide_padding_left = 70
vim.keymap.set("n", "<leader>nt", function()
	if g.neovide_transparency ~= 1.0 then
		g.neovide_transparency = 1.0
	else
		g.neovide_transparency = 0.9
	end
end)
local change_scale_factor = function(delta)
	g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
	change_scale_factor(1 / 1.25)
end)
