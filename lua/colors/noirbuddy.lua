local M = {}
M.colors = {
	bg = "#121212",
}

function M.setup()
	O.colorscheme = "noirbuddy"
	O.fn = "noirbuddy"
	require("noirbuddy").setup()
end

return M
