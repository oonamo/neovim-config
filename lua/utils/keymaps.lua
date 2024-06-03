local M = {}

function M.norm_lazy_to_normal(spec)
	vim.keymap.set("n", spec[1], spec[2], spec[3] or {})
end

return M
