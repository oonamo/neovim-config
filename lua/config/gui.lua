local opt, o, g = vim.opt, vim.o, vim.g

-- g.neovide_scale_factor = 1.0
g.neovide_hide_mouse_when_typing = true
g.neovide_confirm_quit = true
g.neovide_floating_shadow = true
vim.g.neovide_floating_blur_amount_x = 10.0
vim.g.neovide_floating_blur_amount_y = 10.0
-- g.neovide_theme = "dark"
g.neovide_scroll_animation_length = 0.03
-- g.neovide_cursor_animation_length = 0
-- opt.linespace = 10
g.neovide_transparency_point = 1.0
g.neovide_underline_stroke_scale = 1.5
g.neovide_transparency = 1.0
g.neovide_padding_top = 30
g.neovide_padding_bottom = 30
g.neovide_padding_right = 14
g.neovide_padding_left = 30
g.neovide_floating_shadow = false
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"

if not vim.o.guifont or not vim.o.guifont:find(".+:h%d*") then vim.o.guifont = "Iosevka Nerd Font:h20" end

local fonts = {
  "GoMono Nerd Font:h16",
  "SpaceMono Nerd Font:h16",
  "GohuFont uni14 Nerd Font Propo:h14",
  "Iosevka Nerd Font:h14",
  "PxPlus ToshibaSat 9x16:h14",
  "Ac437ToshibaSat8x16 Nerd Font",
  "AcPlusToshibaSat8x16 Nerd Font",
  "Terminess Nerd Font",
  "MonoLisa Nerd Font",
  "BigBlueTerm437 Nerd Font",
  "scientifica",
  "Fixedsys Excelsior",
  "InputMonoCompressed",
  "CozetteVector",
  "Terminess Nerd Font:h16",
}

local function pick()
  MiniPick.start({
    source = {
      name = "Fonts",
      items = fonts,
      choose = function(item) vim.o.guifont = item end,
      preview = function(buf_id, item)
        vim.o.guifont = item
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { "Font:" .. item, "{}[]0O" })
      end,
    },
  })
end

vim.keymap.set("n", "<C-x><C-x>", pick, { desc = "pick font?" })
vim.keymap.set("n", "<leader>nt", function()
  if g.neovide_transparency ~= 1.0 then
    g.neovide_transparency = 1.0
  else
    g.neovide_transparency = 0.9
  end
end)

local function change_font_size(delta)
  if not vim.o.guifont then vim.o.guifont = fonts[1] end
  if not o.guifont then return end

  local f, size = string.match(o.guifont, "(.*:h)(.*)")
  if not f and vim.o.guifont then f = vim.o.guifont .. ":h" end
  if size == nil then size = 14 end
  o.guifont = f .. tonumber(size) + delta
end

vim.keymap.set("n", "<C-=>", function() change_font_size(1) end)
vim.keymap.set("n", "<C-->", function() change_font_size(-1) end)
