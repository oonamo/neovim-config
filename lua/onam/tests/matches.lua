local M = {}

local state = { colorscheme = "doom-one" }

M.themes = { { file_name = "doom-one" } }

for _, v in pairs(M.themes) do
	if v.file_name:match(state.colorscheme) then
		print("found match")
		break
	end
	if state.colorscheme == v.file_name then
		print("found match")
	end
end
