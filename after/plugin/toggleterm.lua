require("toggleterm").setup({
    size = 80,
    hide_numbers = true,
    open_mapping = [[<c-\>]],
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights ={
            border = "Normal",
            background = "Normal"
        },
    },
})

