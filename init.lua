-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local function load(spec, opts)
	return function()
		opts = opts or {}
		local slash = string.find(spec, "/[^/]*$") or 0
		local is_vim_plug = string.find(spec, "%.vim") or 0
		local name = opts.init or string.sub(spec, slash + 1)
		if slash ~= 0 then
			add(vim.tbl_deep_extend("force", { source = spec }, opts.add or {}))
		end
		if is_vim_plug ~= 0 or opts.no_setup then
			if opts.init then
				require(opts.init)
			end
			return
		end
		local req_name = string.gsub(name, ".nvim", "")
		local plug = require(opts.as or req_name)
		if opts.setup then
			plug.setup(opts.setup)
		end
	end
end

local function cmd(command)
	return function()
		vim.cmd(command)
	end
end

add({ name = "mini.nvim" })

now(load("globals"))
now(load("onam.remap"))
now(load("onam.utils"))
now(load("onam.set"))
now(load("onam.plug_opts"))
now(load("onam.autocmds"))
now(load("mini.extra", { setup = {} }))
now(load("cbochs/grapple.nvim", { init = "plugins.coding.grapple" }))
now(load("plugins.mini.starter"))

now(cmd("colorscheme base16-moon"))
-- now(cmd("colorscheme base16-newpaper"))
-- now(cmd("colorscheme duskfox"))
-- now(cmd("colorscheme base16-default_dark"))

now(load("EdenEast/nightfox.nvim"))
now(load("plugins.mini.colors"))

later(load("mini.comment", { setup = {} })) -- No C or CPP comment strings
later(load("mini.splitjoin", { setup = {} }))
later(load("plugins.mini.ai"))
later(load("plugins.mini.bracketed"))
later(load("plugins.mini.clues"))
later(load("plugins.mini.diff"))
later(load("plugins.mini.files"))
later(load("plugins.mini.git"))
later(load("plugins.mini.hi"))
later(load("plugins.mini.indent"))
later(load("plugins.mini.move"))
later(load("plugins.mini.notify"))
later(load("plugins.mini.pick"))
now(load("plugins.mini.sessions"))
later(load("plugins.mini.surround"))

later(load(
	"nvim-treesitter/nvim-treesitter",
	{ init = "plugins.editor.treesitter", add = {
		hooks = { post_checkout = cmd("TSUpdate") },
	} }
))

later(load("rebelot/heirline.nvim", { init = "plugins.ui.heirline" }))

later(load("williamboman/mason.nvim", { init = "plugins.lsp.mason" }))

later(load("hrsh7th/nvim-cmp", {
	init = "plugins.lsp.cmp",
	add = {
		depends = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},
}))

later(load("neovim/nvim-lspconfig", {
	init = "plugins.lsp.lsp",
	depends = { "williamboman/mason.nvim" },
}))

later(load("stevearc/conform.nvim", { init = "plugins.coding.format" }))

later(load("epwalsh/obsidian.nvim", {
	init = "plugins.writing.obsidian",
	add = {
		depends = { "nvim-lua/plenary.nvim" },
	},
}))

later(load("MeanderingProgrammer/markdown.nvim", { init = "plugins.writing.md" }))
later(load("andrewferrier/wrapping.nvim", { init = "plugins.writing.wrap" }))
later(load("folke/zen-mode.nvim", { init = "plugins.writing.zen" }))
later(load("folke/twilight.nvim", { init = "plugins.writing.twilight" }))

if vim.g.neovide then
	now(load("onam.gui"))
else
	later(load("plugins.mini.animate"))
end
