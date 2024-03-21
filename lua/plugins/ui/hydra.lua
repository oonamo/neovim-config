return {
	"anuvyklack/hydra.nvim",
	dependencies = { "ibhagwan/fzf-lua" },
	config = function()
		local Hydra = require("hydra")
		local function search_norg_files(filter)
			if filter == nil then
				filter = ".*"
			end
			local list = {}
			local cmd = string.format(
				'rg "\\s+[-] \\(%s\\)" --color=never -n -g *.norg C:\\Users\\onam7\\Documents\\School\\spring2024',
				filter
			)

			require("fzf-lua").fzf_exec(cmd, {
				fn_transform = function(line)
					local colon = line:gmatch("([^:]+)")
					local until_second_colon = colon()
					until_second_colon = colon()
					local file_path = "C:" .. until_second_colon
					local ln = colon()
					until_second_colon = vim.fn.fnamemodify(until_second_colon, ":p:t")
					local after_second_colon = colon()
					table.insert(list, { file_path = file_path, ln = ln, short_fn = until_second_colon })
					return until_second_colon .. " " .. after_second_colon
				end,
				actions = {
					["default"] = function(selected)
						selected = vim.split(selected[1], " ")
						for _, item in ipairs(list) do
							if item.short_fn == selected[1] then
								vim.schedule(function()
									vim.cmd("e " .. item.file_path)
									vim.schedule(function()
										print("Closing Document Meta")
										vim.cmd("1 foldc")
										vim.schedule(function()
											vim.api.nvim_win_set_cursor(0, { tonumber(item.ln), 0 })
										end)
									end)
								end)
								return
							end
						end
					end,
				},
			})
		end

		-- Hydra({
		-- 	name = "tasks",
		-- 	hint = [[
		--               _d_: done
		--               _u_: undone
		--               _i_: important
		--               _q_: quit
		--           ]],
		-- 	config = {
		-- 		color = "teal",
		-- 		invoke_on_body = true,
		-- 		hint = {
		-- 			position = "middle",
		-- 			border = "rounded",
		-- 		},
		-- 	},
		-- 	mode = "n",
		-- 	body = "<leader>nt",
		-- 	heads = {
		-- 		{
		-- 			"d",
		-- 			function()
		-- 				search_norg_files("x")
		-- 			end,
		-- 			desc = "done tasks",
		-- 		},
		-- 		{
		-- 			"u",
		-- 			function()
		-- 				search_norg_files(" ")
		-- 			end,
		-- 			desc = "undone tasks",
		-- 		},
		-- 		{
		-- 			"i",
		-- 			function()
		-- 				search_norg_files("!")
		-- 			end,
		-- 			desc = "important tasks",
		-- 		},
		-- 		{ "q", nil, { exit = true } },
		-- 		{ "<Esc>", nil, { exit = true } },
		-- 	},
		-- })
	end,
	-- keys = { "<leader>nt" },
	lazy = true,
}
