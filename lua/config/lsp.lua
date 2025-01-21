local M = {}

---Creates message in the message area. Will trim if the message will prompt an enter key
---@param message string|table[]
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

---Gets all active preview windows
---@return number[]
function M.preview_windows()
	local tab = vim.api.nvim_get_current_tabpage()
	local wins = vim.api.nvim_tabpage_list_wins(tab)
	local previewwindows = {}
	previewwindows = vim.iter(wins)
		:filter(function(win)
			return vim.api.nvim_get_option_value("previewwindow", {
				win = win,
			})
		end)
		:totable()
	return previewwindows
end

---Opens Signature Preview window
function M._open_preview()
	local previews = M.preview_windows()
	local preview_win = previews[1]
	if preview_win then
		vim.api.nvim_set_current_win(preview_win)
		local bufnr = vim.api.nvim_win_get_buf(preview_win)
		return preview_win, bufnr
	end

	vim.api.nvim_command("new")
	M.height = vim.api.nvim_get_option_value("previewheight", {})
	M.win = vim.api.nvim_get_current_win()

	local buf = vim.api.nvim_win_get_buf(M.win)
	vim.api.nvim_set_option_value("previewwindow", true, {
		win = M.win,
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
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].undolevels = -1
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(0, 0, -1, true, preview)
	vim.wo[win].wrap = true
	vim.bo[buf].modifiable = false
	vim.wo[win].spell = false
	vim.bo[buf].syntax = syntax
end

---Sets preview
---@param syntax string
---@param preview string[]
---@return integer
function M.set_preview(syntax, preview)
	local prev_win = vim.api.nvim_get_current_win()
	local cursor_pos = vim.api.nvim_win_get_cursor(prev_win)
	local win, buf = M._open_preview()
	M.buf_set_preview(buf, win, syntax, preview)
	if M.restore_pos then
		vim.api.nvim_set_current_win(prev_win)
		vim.api.nvim_win_set_cursor(prev_win, cursor_pos)
		vim.api.nvim_input("zz")
	end
	return buf
end

---@param result lsp.SignatureHelp
---@param ctx lsp.HandlerContext
local function signature_handler(_, result, ctx)
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

---@param result lsp.Hover
local function hover_handler(_, result, _)
	if not result then
		return
	end
	local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)

	local md_lines = vim.iter(lines)
		:map(function(line)
			return vim.split(line, "\n", { trimempty = true })[1]
		end)
		:totable()

	if not md_lines or vim.tbl_isempty(md_lines) then
		M.message("no docs available")
		return
	end

	local buf = M.set_preview(result.contents.kind, md_lines)
	vim.treesitter.start(buf)
end

---Request a function signature, and open a split
---@param restore_pos boolean
function M.request(restore_pos)
	M.height = vim.api.nvim_get_option_value("previewheight", {})
	M.width = vim.o.columns
	M.win = vim.api.nvim_get_current_win()
	M.restore_pos = restore_pos
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/hover", params, hover_handler)
end

function M.request_sig(restore_pos)
	M.height = vim.api.nvim_get_option_value("previewheight", {})
	M.width = vim.o.columns
	M.win = vim.api.nvim_get_current_win()
	M.restore_pos = restore_pos
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/signatureHelp", params, signature_handler)
end

---@param result lsp.SignatureHelp
---@param ctx lsp.HandlerContext
local function echo_handler(_, result, ctx)
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

	if actSig.activeParameter ~= nil then
		actSig.activeParameter = actSig.activeParameter ~= 0 and actSig.activeParameter + 1 or 1
	end

	actSig.label = string.gsub(actSig.label or "", "[\n\r\t]", " ")

	if actSig.label ~= "" then
		local label = vim.iter(ipairs(actSig.parameters))
			:map(function(i, parameter)
				local hl = "Normal"
				if actSig.activeParameter and i == actSig.activeParameter then
					hl = "Special"
				end
				return { actSig.label:sub(parameter.label[1], parameter.label[2] + 1), hl }
			end)
			:totable()

		M.message(label)
	end
	return actSig
end

function M.inlay_hint_handle(_, result, ctx) end

function M.echo_area_sig()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/signatureHelp", params, echo_handler)
end

function M.inlay_hint_sig()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/inlayHint", params, echo_handler)
end
M.echo_area_sig()

function M.setup_popup() end

return M
