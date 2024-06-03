local daily_path = "100 dailies/"
local daily_folder = os.date("%b %Y")
daily_path = daily_path .. "/" .. daily_folder

require("obsidian").setup({
	workspaces = {
		{
			name = "DB",
			path = "~/Desktop/DB/DB/",
		},
	},
	completion = {
		-- Set to false to disable completion.
		nvim_cmp = false,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},

	templates = {
		subdir = "templates",
	},

	daily_notes = {
		folder = daily_path,
		date_format = "%Y-%m-%d",
		alias_format = "%B %d, %Y",
	},

	note_id_func = function(title)
		if title ~= nil then
			return title:gsub("%s+", "-")
		else
			local note_title
			vim.ui.input({ prompt = "Title: " }, function(new_title)
				note_title = new_title:gsub("%s+", "-")
			end)
			return note_title
		end
	end,

	new_notes_location = "notes_subdir",

	-- For windows only
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		local local_file = string.match(url, "file://(.*)")
		if local_file ~= nil then
			vim.cmd("e " .. local_file)
		else
			vim.fn.jobstart({ "explorer", url })
		end
	end,
	picker = {
		name = "mini.pick",
		mappings = {},
	},

	callbacks = {
		enter_note = function()
			vim.schedule(function()
				vim.cmd("SoftWrapMode")
				vim.opt.shiftwidth = 2
			end)
		end,
		post_setup = function()
			-- vim.cmd("set spell")
			-- require("grapple").use_scope("obsidian")
		end,
	},

	ui = {
		enable = true, -- set to false to disable all additional syntax features
		update_debounce = 200, -- update delay after a text change (in milliseconds)
		-- Define how various check-boxes are displayed
		checkboxes = {
			-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
			["x"] = { char = "", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
		},
		bullets = { char = "•", hl_group = "ObsidianBullet" },
		external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		-- Replace the above with this if you don't have a patched font:
		-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		reference_text = { hl_group = "ObsidianRefText" },
		highlight_text = { hl_group = "ObsidianHighlightText" },
		tags = { hl_group = "ObsidianTag" },
		hl_groups = {
			-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
			ObsidianTodo = { bold = true, fg = "#f78c6c" },
			ObsidianDone = { bold = true, fg = "#89ddff" },
			ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
			ObsidianTilde = { bold = true, fg = "#ff5370" },
			ObsidianBullet = { bold = true, fg = "#89ddff" },
			ObsidianRefText = { underline = true, fg = "#c792ea" },
			ObsidianExtLinkIcon = { fg = "#c792ea" },
			ObsidianTag = { italic = true, fg = "#89ddff" },
			ObsidianHighlightText = { bg = "#75662e" },
		},
	},
})
require("onam.autocmds").setup_writing_cmds()
-- vim.g.markdown_folding = 1

utils.norm_lazy_to_normal({ "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "[O]bsidian [G]o" })
utils.norm_lazy_to_normal({ "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "[O]bsidian [F]ind" })
utils.norm_lazy_to_normal({
	"<leader>on",
	function()
		vim.ui.input({ prompt = "Note name (optional): " }, function(name)
			if name == nil then
				return
			end
			local note_title = name:gsub("%s+", "-")
			vim.cmd("ObsidianNew " .. note_title)
		end)
	end,
	desc = "[O]bsidian [N]ew",
})
utils.norm_lazy_to_normal({ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "[O]bsidian [S]earch" })
utils.norm_lazy_to_normal({ "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "[O]bsidian [T]oday" })
utils.norm_lazy_to_normal({ "<leader>oy", "<cmd>ObsidianYesterday<CR>", desc = "[O]bsidian [Y]esterday" })
utils.norm_lazy_to_normal({ "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "[O]bsidian [O]pen" })
utils.norm_lazy_to_normal({ "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "[O]bsidian [L]inks" })
utils.norm_lazy_to_normal({ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "[O]bsidian [B]acklinks" })
utils.norm_lazy_to_normal({ "<leader>or", "<cmd>ObsidianRename<CR>", desc = "[O]bsidian [R]ename" })
utils.norm_lazy_to_normal({
	"<leader>oe",
	function()
		vim.ui.input({ prompt = "Enter title (optional): " }, function(input)
			vim.cmd("ObsidianExtractNote " .. input)
		end)
	end,
	desc = "[O]bsidian [E]xtract",
})
utils.norm_lazy_to_normal({
	"<leader>ol",
	function()
		vim.cmd("ObsidianLink")
	end,
	desc = "[O]bsidian [L]ink",
})
utils.norm_lazy_to_normal({
	"<leader>od",
	function()
		local day_of_week = os.date("%A")

		print(day_of_week)
		assert(type(day_of_week) == "string")
		local offset_start

		require("onam.fn").switch(day_of_week, {
			["Monday"] = function()
				offset_start = 1
			end,
			["Tuesday"] = function()
				offset_start = 0
			end,
			["Wednesday"] = function()
				offset_start = -1
			end,
			["Thursday"] = function()
				offset_start = -2
			end,
			["Friday"] = function()
				offset_start = -3
			end,
			["Saturday"] = function()
				offset_start = -4
			end,
			["Sunday"] = function()
				offset_start = 2
			end,
		})

		if offset_start ~= nil then
			vim.cmd(string.format("ObsidianDailies %d %d", offset_start, offset_start + 4))
		end
	end,
	desc = "[O]bsidian [D]ailies",
})

vim.api.nvim_create_user_command("GoToNotes", function()
	vim.schedule(function()
		MiniSessions.read("Notes")
		vim.o.conceallevel = 2
		-- vim.cmd("cd C:/Users/onam7/Desktop/DB/DB")
		-- vim.cmd("e base.md")
	end)
end, {})
-- {
-- 	"oflisback/obsidian-bridge.nvim",
-- 	dependencies = { "nvim-telescope/telescope.nvim" },
-- 	opts = { scroll_sync = true },
-- 	lazy = true,
-- 	config = function(_, opts)
-- 		require("obsidian-bridge").setup(opts)
-- 	end,
-- 	keys = {
-- 		{ "<leader>og", function() end, desc = "Load obsidian-bridge" },
-- 	},
-- },
