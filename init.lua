vim.opt.rtp:prepend("C:/Users/onam7/projects/nvim/use-package/")

vim.g.mapleader = " "
vim.cmd.source("~/plugin/fzf.vim")
vim.keymap.set("n", "<leader>f", "<cmd>FZF<CR>")

local function on_attach(client, buffer)
  vim.bo[buffer].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
		desc = "Preview code actions",
		buffer = buffer,
	})
	-- end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
		desc = "go to buffer definition",
		buffer = buffer,
	})

	vim.keymap.set("n", "gD", function()
		require("mini.extra").pickers.lsp({ scope = "definition" })
	end, { desc = "go to multiple definition", buffer = buffer })
	vim.keymap.set("n", "<leader>vws", function()
		require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
	end, { desc = "Find workspace_symbol", buffer = buffer })
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, {
		desc = "Open float menu",
		buffer = buffer,
	})
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {
		desc = "Got to next diagnostic",
		buffer = buffer,
	})
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {
		desc = "Go to previous diagnostic",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {
		desc = "Go to lsp references",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = buffer, expr = true })
	vim.keymap.set("n", "<leader>vxx", function()
		require("mini.extra").pickers.diagnostic()
	end, { desc = "Find diagnostics", buffer = buffer })
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {
		desc = "Signature help",
		buffer = buffer,
	})
	if client.supports_method("textDocument/inlayHint") then
		vim.keymap.set("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Inlay Hint" })
	end
	vim.keymap.set("n", "<leader>qf", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Quickfix [L]ist [D]iagnostics" })
	-- vim.keymap.set("n", "<C-]>", "<C-w><C-]>")

	vim.keymap.set("n", "<leader>ss", function()
		require("config.lsp").request(true)
	end)
end

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*.lua",
  callback = function()
    vim.lsp.start({
      name = "luals",
      cmd = { "lua-language-server" },
      root_dir = vim.fs.root(0, { ".git", ".luarc.json" }),
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = { "vim", "bit" },
							workspaceDelay = -1,
						},
						telemetry = {
							enable = false,
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
							ignoreSubmodules = true,
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = true,
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
    })
  end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, buffer)
  end
})

local loader = require("use-package.plugin")
local use_package = loader.use_package

use_package("echasnovski/mini.nvim"):config(function()
  require("mini.completion").setup()
end):load()

use_package("nvim-treesitter/nvim-treesitter"):events({ "BufWritePre", "BufReadPost", "BufNewFile", }):config(function()
      vim.notify("loaded treesitter")
			require("nvim-treesitter.query_predicates")
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"lua",
					"javascript",
					"c",
					"norg",
					"rust",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"latex",
					"org",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = {
					enable = false,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				incremental_selection = {
					enable = false,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					keymaps = {
						init_selection = "<C-i>",
						node_incremental = "<CR>",
						scope_incremental = false,
						node_decremental = "<BS>",
					},
				},
        textobjects = {
          enabled = false,
        }
			})
end)

require("config.autocommands")
require("config.keymaps")
require("config.gui")
require("moody")

if vim.fn.has("win32") then
	_G.platform_specific = { lineending = "\r\n" }
else
	_G.platform_specific = { lineending = "\n" }
end

vim.o.shell = "pwsh"
vim.o.shellcmdflag =
	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.o.shellquote = ""
vim.o.shellxquote = ""

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ";"
local o, opt = vim.o, vim.opt
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

o.background = "dark"

-- Allows for easy telling if pane is a nvim proccess
o.title = true
o.titlestring = "nvim"
-- opt.completeopt = "menu,menuone,noselect"
o.cmdheight = 1

vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
vim.o.lazyredraw = true

-- Relative line numbers
opt.nu = true
opt.rnu = false

-- set tab stop at 4
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

o.guicursor =
	[[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]
-- autoindent
opt.smartindent = true
opt.shiftwidth = 2

-- smarter breaking
-- o.breakindent = true

-- better searching
o.inccommand = "split"
o.incsearch = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

-- disable wrap
opt.wrap = false

-- better splitting
o.splitkeep = "screen"
o.splitbelow = true
o.splitright = true

-- set completion options
-- opt.completeopt = { "menu", "menuone", "noselect" }

-- set signcolumn
opt.signcolumn = "yes"

o.emoji = true

-- Editor
o.showmode = false
opt.scrolloff = 8
-- o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 10
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.wildoptions = "tagfile"
opt.wildmenu = true
o.makeprg = "just"
opt.laststatus = 3 -- Or 3 for global statusline
opt.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldtext = ""
o.list = true
o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",")
-- opt.listchars = "trail:∘,nbsp:‼,tab:  ,multispace: "
o.fillchars = [[eob: ,vert:▕,vertleft:🭿,vertright:▕,verthoriz:🭿,horiz:▁,horizdown:▁,horizup:▔]]
o.virtualedit = "block"
o.shortmess = "tacstFOSWCo"
o.formatoptions = "rqnl1j"
o.cmdwinheight = 4
opt.iskeyword:append('-')
opt.complete:append("kspell")
o.spelloptions = "camel"
-- credit: https://github.com/nicknisi/dotfiles/blob/1360edda1bbb39168637d0dff13dd12c2a23d095/config/nvim/init.lua#L73
-- if ripgrep installed, use that as a grepper
-- o.grepprg = "rg --vimgrep --color=never --with-filename --line-number --no-heading --smart-case --"
o.grepprg = [[rg --glob !.git --no-heading --with-filename --line-number --vimgrep --follow $*]]
o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

o.cursorline = false
o.cursorlineopt = "screenline,number"
o.winblend = 0
o.pumblend = 0

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

if not vim.g.colors_name or vim.g.colors_name == "" then
	-- vim.cmd.colorscheme("minispring")
	vim.cmd.colorscheme("tokyonight")
	-- vim.cmd.colorscheme("solarized_osaka")
	-- vim.cmd.colorscheme("chadracula-evondev")
	-- vim.cmd.colorscheme("chadracula")
	-- vim.cmd.colorscheme("chad-gruvbox")
	-- vim.cmd.colorscheme("gruvbox")
	-- vim.cmd.colorscheme("pinkcat")
	-- vim.cmd.colorscheme("neovim_dark")
	-- vim.cmd.colorscheme("onenord")
	-- vim.cmd.colorscheme("kanagawa")
end
