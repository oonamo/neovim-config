-- TODO: Script to delete lsp.log every so often
-- TODO: Watch https://github.com/neovim/neovim/issues/8587
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.notify("Downloading lazy...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.o.background = "dark"
vim.opt.rtp:prepend(lazypath)

require("globals")
require("onam.remap")
require("onam.utils")
require("onam.set")
require("onam.plug_opts")
require("onam.autocmds")
require("lazy").setup({
	spec = {
		{ import = "plugins.coding" },
		{ import = "plugins.editor" },
		{ import = "plugins.lsp" },
		{ import = "plugins.writing" },
		{ import = "plugins.mini" },
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "tokyonight-night" },
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"man",
				"matchparen",
				"tar",
				"tarPlugin",
				"rrhelper",
				"vimball",
				-- "health",
				"shada",
				-- "spellfile",
				"tohtml",
				"tutor",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"rplugin",
			},
		},
	},
})

if O.debug then
	local should_profile = os.getenv("NVIM_PROFILE")
	if should_profile then
		require("profile").instrument_autocmds()
		if should_profile:lower():match("^start") then
			require("profile").start("*")
		else
			require("profile").instrument("*")
		end
	end

	local function toggle_profile()
		local prof = require("profile")
		if prof.is_recording() then
			prof.stop()
			vim.ui.input(
				{ prompt = "Save profile to:", completion = "file", default = "profile.json" },
				function(filename)
					if filename then
						prof.export(filename)
						vim.notify(string.format("Wrote %s", filename))
					end
				end
			)
		else
			prof.start("*")
		end
	end

	vim.keymap.set("", "<f1>", toggle_profile)
end

-- require("onam.statusline")
require("onam.statuscolumn")

-- LIGHT:
-- vim.cmd.colorscheme("newpaper-light")
-- vim.cmd.colorscheme("light-ambition")
-- vim.cmd.colorscheme("lighter")
-- vim.cmd.colorscheme("lovefox")

-- DARK:
-- vim.cmd.colorscheme("ambition")
-- vim.cmd.colorscheme("brown_ambition")
-- vim.cmd.colorscheme("retrobox")
-- vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd.colorscheme("minimal")
-- vim.cmd.colorscheme("kopicat")
-- vim.cmd.colorscheme("ice-cave")
-- vim.cmd.colorscheme("sunbather")
-- vim.cmd.colorscheme("seoul256-sharp")
-- vim.cmd.colorscheme("seoul256-dull")
-- vim.cmd.colorscheme("pink-moon-dark")
-- vim.cmd.colorscheme("sierra")
-- vim.cmd.colorscheme("blie")
-- vim.cmd.colorscheme("lavi")
-- vim.cmd.colorscheme("grei")

if vim.g.neovide then
	require("onam.gui")
end
