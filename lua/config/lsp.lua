local M = {}

function M.message(message)
	message = type(message) == "table" and message or { { message, "WarningMsg" } }
	local max_width = vim.o.columns * math.max(vim.o.cmdheight - 1, 0) + vim.v.echospace
	local chunks, tot_width = {}, 0
	for _, ch in ipairs(message) do
		local new_ch = { vim.fn.strcharpart(ch[1], 0, max_width - tot_width), ch[2] }
		table.insert(chunks, new_ch)
		tot_width = tot_width + vim.fn.strdisplaywidth(new_ch[1])
		if tot_width >= max_width then
			break
		end
	end
	vim.cmd([[echo '' | redraw]])
	vim.api.nvim_echo(chunks, false, {})
end

function M.preview_windows()
	local tab = vim.api.nvim_get_current_tabpage()
	local wins = vim.api.nvim_tabpage_list_wins(tab)
	local previewwindows = {}
	for _, win in ipairs(wins) do
		if vim.api.nvim_get_option_value("previewwindow", {
			win = win,
		}) then
			table.insert(previewwindows, win)
		end
	end
	return previewwindows
end

function M._open_preview()
	local previews = M.preview_windows()
	local preview_win = previews[1]
	if preview_win then
		vim.api.nvim_set_current_win(preview_win)
		local bufnr = vim.api.nvim_win_get_buf(preview_win)
		return preview_win, bufnr
	end

	M.height = vim.api.nvim_get_option_value("previewheight", {})
	local buf = vim.api.nvim_create_buf(false, false)
	M.win = vim.api.nvim_get_current_win()
	vim.api.nvim_set_option_value("previewwindow", true, {
		buf = M.win,
	})
	vim.api.nvim_win_set_height(M.win, M.height)
	vim.bo[buf].bufhidden = "wipe"
	vim.keymap.set("n", "q", function()
		vim.cmd("close")
	end, { buffer = buf })
	vim.keymap.set("n", "<esc>", function()
		vim.cmd("close")
	end, { buffer = buf })
	return M.win, buf
end

---Sets preview window options
---@param buf number
---@param win number
---@param syntax string
---@param preview string[]
function M.buf_set_preview(buf, win, syntax, preview)
	vim.bo[buf].undolevels = -1
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].modifiable = true
	vim.wo[win].wrap = true
	vim.api.nvim_buf_set_lines(0, 0, -1, true, preview)
	vim.bo[buf].modifiable = false
	vim.wo[win].spell = false
	vim.bo[buf].filetype = "markdown"
	-- vim.bo[buf].syntax = syntax
end

---Sets preview
---@param syntax string
---@param preview string[]
---@return integer
function M.set_preview(syntax, preview)
	local win, buf = M._open_preview()
	M.buf_set_preview(buf, win, syntax, preview)
	return buf
end

local function signature_handler(_, result, ctx, config)
	config = config or {}
	config.focus_id = ctx.method
	if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
		return
	end

	if result == nil or result.signatures == nil or result.signatures[1] == nil then
		return
	end

	local activeSignature = result.activeSignature or 0
	activeSignature = activeSignature + 1
	if activeSignature > #result.signatures then
		-- this is a upstream bug of metals
		activeSignature = #result.signatures
	end
	local actSig = result.signatures[activeSignature]
	if actSig == nil then
		return
	end

	-- M.last_signature = vim.deepcopy(actSig)
	actSig.activeParameter = actSig.activeParameter or 0
	actSig.label = string.gsub(actSig.label, "[\n\r\t]", " ")

	if actSig.documentation and actSig.documentation.value then
		local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
		local triggers = vim.tbl_get(client.server_capabilities, "signatureHelpProvider", "triggerCharacters")
		local lines, _ =
			vim.lsp.util.convert_signature_help_to_markdown_lines(result, vim.bo[ctx.bufnr].filetype, triggers)
		if not lines or vim.tbl_isempty(lines) then
			M.message("No signatures")
			return
		end
		local buf = M.set_preview(actSig.documentation.kind, lines)
		vim.treesitter.start(buf)
	else
		M.message("no docs available")
	end
	return actSig
end

---etslkdjtlaksdj tlkasjdtlk jasdlkjtlk ajsdlk jlkasjdtlkajlksdjtlakjdt lkasdjtlkajlsdkjtalk jalksdjtlkajsdlkjtalkjtlka lkasdjtlka
---@param err any
---@param result any
---@param ctx any
---@param config any
function M.hover(err, result, ctx, config)
	config = config or {}
	if result and result.contents then
		local _, buf = M._open_preview()
		M.set_preview(result.kind, result.contents.value)
		vim.treesitter.start(buf, result.kind or "markdown")
	end
end

function M.request()
	M.height = vim.api.nvim_get_option_value("previewheight", {})
	M.width = vim.o.columns
	M.win = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/signatureHelp", params, signature_handler)
end

return M
