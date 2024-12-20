_G.Config = {}

function Config.open_lazygit()
	vim.cmd("tabedit")
	vim.cmd("setlocal nonumber signcolumn=no cmdheight=0")

  vim.fn.termopen('lazygit', {
    on_exit = function()
      vim.cmd('silent! :checktime')
      vim.cmd('silent! :bw')
    end,
  })
  vim.cmd('startinsert')
  vim.b.minipairs_disable = true
end
