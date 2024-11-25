local opt, o, g = vim.opt, vim.o, vim.g

-- g.neovide_scale_factor = 1.0
g.neovide_hide_mouse_when_typing = true
g.neovide_confirm_quit = true
-- g.neovide_theme = "dark"
g.neovide_scroll_animation_length = 0
g.neovide_cursor_animation_length = 0
-- opt.linespace = 10
g.neovide_transparency_point = 1.0
g.neovide_underline_stroke_scale = 1.5
g.neovide_transparency = 1.0
g.neovide_padding_top = 30
g.neovide_padding_bottom = 30
g.neovide_padding_right = 15
g.neovide_padding_left = 30
g.neovide_floating_shadow = false

--[[
Some fonts:
GoMono Nerd Font:h16
SpaceMono Nerd Font:h16
GohuFont uni14 Nerd Font Propo:h14
PxPlus ToshibaSat 9x16
Ac437ToshibaSat8x16 Nerd Font
]]

local fonts = {
	"GoMono Nerd Font:h16",
	"SpaceMono Nerd Font:h16",
	"GohuFont uni14 Nerd Font Propo:h14",
	"PxPlus ToshibaSat 9x16",
	"Ac437ToshibaSat8x16 Nerd Font",
	"AcPlusToshibaSat9x16 Nerd Font",
	"Terminess Nerd Font",
	"MonoLisa Nerd Font",
	"BigBlueTerm437 Nerd Font",
	"scientifica",
	"Fixedsys Excelsior",
  "InputMonoCompressed",
	"CozetteVector",
}

local selected_font
local hooks = {
	pre_hooks = {},
	post_hooks = {},
}

local function pick()
	MiniPick.start({
		source = {
			name = "Fonts",
			items = fonts,
			choose = function(item)
        vim.o.guifont = item
			end,
			preview = function(buf_id, item)
				vim.o.guifont = item
				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { "Font:" .. item, "{}[]0O" })
			end,
		},
	})
end

vim.keymap.set("n", "<C-x><C-x>", pick, { desc = "pick font?" })

-- hooks.pre_hooks.Fonts = function()
--   selected_font = vim.o.guifont
-- end
--
-- hooks.post_hooks.Fonts = function()
--   vim.o.guifont = selected_font
-- end
--
-- require("mini.pick").registry.fonts = function()
--   return MiniPick.start({
--     source = {
--       name = "Fonts",
--       items = fonts,
--       choose = function (item)
--         selected_font = item
--       end,
--       preview = function (buf_id, item)
--         vim.o.guifont = item
--         vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { "Font:" .. item, "{}[]0O"})
--       end
--     }
--   })
-- end
--
-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = "MiniPickStart",
--   group = vim.api.nvim_create_augroup("minipick-pre-hooks", { clear = true }),
--   desc = "Invoke pre_hook for specific picker based on source.name.",
--   callback = function(...)
--     local opts = MiniPick.get_picker_opts() or {}
--     local pre_hook = hooks.pre_hooks[opts.source.name] or function(...) end
--     pre_hook(...)
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = "MiniPickStop",
--   group = vim.api.nvim_create_augroup("minipick-post-hooks", { clear = true }),
--   desc = "Invoke post_hook for specific picker based on source.name.",
--   callback = function(...)
--     local opts = MiniPick.get_picker_opts() or {}
--     local post_hook = hooks.post_hooks[opts.source.name] or function(...) end
--     post_hook(...)
--   end,
-- })

-- o.guifont = "GoMono Nerd Font:h15"
o.guifont = "SpaceMono Nerd Font:h16"
vim.keymap.set("n", "<leader>nt", function()
	if g.neovide_transparency ~= 1.0 then
		g.neovide_transparency = 1.0
	else
		g.neovide_transparency = 0.9
	end
end)

local function change_font_size(delta)
	if not o.guifont then
		return
	end
	local f, size = string.match(o.guifont, "(.*:h)(.*)")
	if not f and vim.o.guifont then
		f = vim.o.guifont .. ":h"
	end
	if size == nil then
		size = 14
	end
	o.guifont = f .. tonumber(size) + delta
end
vim.keymap.set("n", "<C-=>", function()
	change_font_size(1)
end)
vim.keymap.set("n", "<C-->", function()
	change_font_size(-1)
end)
