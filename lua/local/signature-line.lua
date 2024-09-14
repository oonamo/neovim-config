local M = {}

function M.eval()
	local sig = require("lsp_signature").status_line(80)
	return sig.label .. " " .. sig.hint
end

vim.o.statusline = "%!v:lua.require('local.signature-line').eval()"
return M
