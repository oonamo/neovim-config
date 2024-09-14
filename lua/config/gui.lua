local opt, o, g = vim.opt, vim.o, vim.g

g.neovide_scale_factor = 1.0
g.neovide_hide_mouse_when_typing = true
g.neovide_theme = "dark"
-- g.neovide_scroll_animation_length = 0
opt.linespace = 10
g.neovide_transparency_point = 1.0
g.neovide_underline_stroke_scale = 1.5
g.neovide_transparency = 1.0
vim.g.neovide_padding_top = 30
vim.g.neovide_padding_bottom = 30
vim.g.neovide_padding_right = 100
vim.g.neovide_padding_left = 100
g.neovide_floating_shadow = false

-- o.guifont = "GoMono Nerd Font:h16"
o.guifont = "SpaceMono Nerd Font:h16"
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

local function change_font_size(delta)
	local _, _, f, size = string.find(o.guifont, "(.*:h)(.*)")
	o.guifont = f .. tonumber(size) + delta
end
vim.keymap.set("n", "<C-=>", function()
	-- change_scale_factor(1.25)
	change_font_size(1)
end)
vim.keymap.set("n", "<C-->", function()
	-- change_scale_factor(1 / 1.25)
	change_font_size(-1)
end)