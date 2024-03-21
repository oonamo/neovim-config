local fn = require("onam.fn")
local M = {}
local function search(filter_item)
	local fzf = require("fzf-lua")
	local cmd =
		string.format('rg "[-] \\[%s\\]" --color=never -n -g *.md C:\\Users\\onam7\\Desktop\\DB\\DB', filter_item)
	local list = {}
	fzf.fzf_exec(cmd, {
		fn_transform = function(line)
			local colon = line:gmatch("([^:]+)")
			local until_second_colon = colon()
			until_second_colon = colon()
			local file_path = "C:" .. until_second_colon
			local ln = colon()
			until_second_colon = vim.fn.fnamemodify(until_second_colon, ":p:t")
			local after_second_colon = colon()

			if after_second_colon:match("\\[x\\]") then
				after_second_colon = fzf.utils.ansi_codes.magenta(after_second_colon)
			elseif after_second_colon:match("%[%s%]") then
				after_second_colon = fzf.utils.ansi_codes.red(after_second_colon)
			end

			table.insert(list, { file_path = file_path, ln = ln, short_fn = until_second_colon })
			return fzf.make_entry.file(until_second_colon, { file_icons = true, color_icons = true })
				.. " "
				.. after_second_colon
		end,
		actions = {
			["default"] = function(selected)
				print("selected: " .. selected[1])
				selected = vim.split(selected[1], " ")
				for _, item in ipairs(list) do
					print(item.short_fn)
					if item.short_fn == selected[1] then
						print(item.file_path)
						vim.schedule(function()
							vim.cmd("e " .. item.file_path)
							vim.schedule(function()
								vim.api.nvim_win_set_cursor(0, { tonumber(item.ln), 0 })
							end)
						end)
						return
					end
				end
			end,
			["ctrl-q"] = function()
				vim.fn.setqflist(list)
			end,
		},
	})
end

function M.open()
	vim.ui.select({
		"Open ... ",
		"New ... ",
		"Quick Switch",
		"Follow Link",
		"Tags ... ",
		"Today",
		"Yesterday",
		"Tomorrow",
		"Search ... ",
		"Link ... ",
		"Link New ... ",
		"Extract ... ",
		"Workspace ...",
		"Paste Image",
		"Rename ... ",
	}, { prompt = "Select:" }, function(choice)
		fn.switch(choice, {
			["Open"] = function()
				vim.cmd("ObsidianOpen")
			end,
			["New"] = function()
				vim.schedule(function()
					local new_title
					vim.ui.input({
						prompt = "New Name: ",
					}, function(title)
						if title ~= nil then
							new_title = title:gsub("%s+", "_")
						else
							new_title = nil
						end
					end)
					vim.cmd("ObsidianNew " .. new_title)
				end)
			end,
			["Link"] = function()
				vim.cmd("ObsidianLink")
			end,
			["Link New"] = function()
				vim.cmd("ObsidianLinkNew")
			end,
			["Extract"] = function()
				vim.cmd("ObsidianExtract")
			end,
			["Workspace"] = function()
				vim.cmd("ObsidianWorkspace")
			end,
			["Paste Image"] = function()
				vim.cmd("ObsidianPasteImage")
			end,
			["Rename"] = function()
				vim.schedule(function()
					local new_title
					vim.ui.input({
						prompt = "New Name: ",
					}, function(title)
						if title ~= nil then
							new_title = title:gsub("%s+", "_")
						else
							new_title = nil
						end
					end)
					vim.cmd("ObsidianRename " .. new_title)
				end)
			end,
		})
	end)
end

function M.find_tasks(filter)
	if filter == nil then
		vim.ui.input({ prompt = "Filter: " }, function(input)
			vim.print(input)
			if input ~= nil or input ~= "" then
				filter = input
			else
				filter = ".*"
			end
			search(filter)
		end)
	else
		search(filter)
	end
end

function M.hyrda()
	local Hydra = require("hydra")
	Hydra({
		name = "Obsidian",
		hint = [[
            _t_: Table mode
            _p_: Physics
            _l_: Linear Algebra
            _d_: Diff Eq
            _c_: CS
        ]],
		config = {
			invoke_on_body = true,
			hint = {
				border = "rounded",
			},
		},
		mode = "n",
		body = "<leader>ohm",
		heads = {
			{ "t", ":ObsidianOpenInTableMode<cr>", { desc = "Table mode" } },
		},
	})
end

return M
