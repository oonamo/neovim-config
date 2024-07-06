local cwd = require("mini.git").get_buf_data(0)
if cwd == nil then
	return
end
require("onam.float_term").float_term("lazygit", {
	size = { width = 0.85, height = 0.8 },
	cwd = cwd.root or "",
})
