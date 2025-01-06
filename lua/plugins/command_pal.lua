require("command_pal").setup({
  picker = "mini_pick",
})

vim.keymap.set("n", "<A-x>", function() require("command_pal").open() end)
