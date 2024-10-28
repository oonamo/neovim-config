local basepath = "C:/Users/onam7/goodnotes"
local goodpath = "C:/Users/onam7/Desktop/DB/DB/goodnotes"
local noterpath = "C:/Users/onam7/projects/go/movefile/move.exe"

local M = {}

MiniPick.registry.goodnotes = function()
	require("mini.pick").builtin.cli({
		command = {
			"fd",
			"--color",
			"never",
			"--type",
			"file",
			"--extension",
			"pdf",
			".",
			basepath,
			goodpath,
		},
		spawn_opts = { cwd = basepath },
	}, {
		source = {
			name = "Goodnotes picker",
			choose = function(path)
				path = path:gsub("\\", "/")
				vim.notify(path)
				vim.notify("picked a path")
				local in_goodpath = path:match(goodpath .. "/(.*)")
				if in_goodpath then
					vim.schedule(function()
						vim.api.nvim_put({ "![[goodnotes/" .. in_goodpath .. "]]" }, "", false, true)
					end)
				else
					local propre_path = path:match(basepath .. "/(.*)")
					vim.uv.spawn(noterpath, {
						args = {
							propre_path,
							goodpath,
							basepath,
						},
					}, function(code, signal)
						if code == 0 then
							vim.schedule(function()
								vim.api.nvim_put({ "![[goodnotes/" .. propre_path .. "]]" }, "", false, true)
							end)
						else
							vim.schedule(function()
								vim.notify("Noter failed with code " .. code, vim.log.levels.ERROR)
							end)
						end
					end)
				end
			end,
		},
	})
end

function M.current_link()
	local current_line = vim.api.nvim_get_current_line()
	local _, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
	cur_col = cur_col + 1
	local left = cur_col
	local right = cur_col
	local cur_line_length = #current_line
	while left > 0 and string.sub(current_line, left, left) ~= "[" do
		left = left - 1
	end
	while right < cur_line_length and string.sub(current_line, right, right) ~= "]" do
		right = right + 1
	end
	if left > 0 and right < cur_line_length then
		local link = string.sub(current_line, left + 1, right - 1)
		local file = string.match(goodpath .. "/" .. link, "goodnotes/(.*)")
		vim.fn.jobstart({
			"sumatrapdf",
			"-reuse-instance",
			file,
		})
	end
end

return M
