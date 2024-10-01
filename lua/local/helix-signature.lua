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

function M._make_floating_popup_size(contents, opts)
	local width = vim.api.nvim_win_get_width(0)
	local height = #contents
	return height, width
end

function M.float_win(height, width)
	local bufnr = vim.api.nvim_get_current_buf()
	local previewwin = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, "lsp_float")
	if previewwin and vim.api.nvim_win_is_valid(previewwin) then
		return previewwin, vim.api.nvim_win_get_buf(previewwin)
	end

	local float_buf = vim.api.nvim_create_buf(false, true)
	local winopts = vim.lsp.util.make_floating_popup_options(width, height, {})
	local float_win = vim.api.nvim_open_win(float_buf, false, winopts)
	vim.api.nvim_buf_set_var(bufnr, "lsp_float", float_win)

	return float_win, float_buf
end

function M._buf_set_preview(win, buf, preview, opts)
	vim.bo[buf].undolevels = -1
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].modifiable = true
	vim.wo[win].wrap = true
	vim.wo[win].spell = false
	vim.bo[buf].filetype = "markdown"
	vim.wo[win].conceallevel = 2
	vim.wo[win].foldenable = false
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, preview)
	-- vim.lsp.util.stylize_markdown(buf, preview, opts)
	vim.bo[buf].modifiable = false
end

function M.set_preview(preview)
	local height, width = M._make_floating_popup_size(preview)
	local win, buf = M.float_win(height, width)
	M._buf_set_preview(win, buf, preview, {
		height = height,
		width = width,
		wrap_at = width,
	})
	return buf
end

function M.update_hl(signature)
	local active_hl
	if signature.parameters and #signature.parameters > 0 then
		local parameter = signature.parameters[signature.activeParameter + 1]
		if parameter.label then
			if type(parameter.label) == "table" then
				active_hl = parameter.label
			else
				local offset = 1
				-- try to set the initial offset to the first found trigger character
				for _, t in ipairs(M.triggers or {}) do
					local trigger_offset = signature.label:find(t, 1, true)
					if trigger_offset and (offset == 1 or trigger_offset < offset) then
						offset = trigger_offset
					end
				end
				for p, param in pairs(signature.parameters) do
					offset = signature.label:find(param.label, offset, true)
					if not offset then
						break
					end
					if p == signature.activeParameter + 1 then
						active_hl = { offset - 1, offset + #parameter.label - 1 }
						break
					end
					offset = offset + #param.label + 1
				end
			end
		end
	end
	return active_hl
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
	local signature = result.signatures[activeSignature]
	if signature == nil then
		return
	end
	if M.last_signature and M.last_signature.label == signature.label then
		local active_hl = M.update_hl(signature)
		if active_hl then
			vim.api.nvim_buf_clear_namespace(M.last_signature.buf, M.ns, 0, -1)
			local line = vim.startswith(M.last_signature.contents[1], "```") and 1 or 0
			vim.api.nvim_buf_add_highlight(
				M.last_signature.buf,
				-1,
				"LspSignatureActiveParameter",
				line,
				unpack(active_hl)
			)
			vim.cmd.redraw()
		end
		M.last_hl = active_hl
		return
	end
	M.last_signature = vim.deepcopy(signature)

	-- F.last_signature = vim.deepcopy(actSig)
	signature.activeParameter = signature.activeParameter or 0
	-- actSig.label = string.gsub(actSig.label, "[\n\r\t]", " ")
	-- actSig.label = ("```%s\n%s\n```"):format(vim.bo[ctx.bufnr].filetype, actSig.label)

	if signature.documentation and signature.documentation.value then
		local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
		M.triggers = vim.tbl_get(client.server_capabilities, "signatureHelpProvider", "triggerCharacters")
		local contents = {}
		local ft = vim.bo[ctx.bufnr].filetype
		if ft then
			signature.label = ("```%s\n%s\n```"):format(vim.bo[ctx.bufnr].filetype, signature.label)
		end
		vim.list_extend(contents, vim.split(signature.label, "\n", { plain = true, trimepty = true }))
		local active_hl = M.update_hl(signature)
		local buf = M.set_preview(vim.split(signature.label, "\n"))

		vim.treesitter.start(buf, result.kind or "markdown")
		if active_hl then
			-- Highlight the second line if the signature is wrapped in a Markdown code block.
			local line = vim.startswith(contents[1], "```") and 1 or 0
			M.ns = vim.api.nvim_buf_add_highlight(buf, -1, "LspSignatureActiveParameter", line, unpack(active_hl))
		end
		M.last_hl = active_hl
		M.last_signature.mod_label = signature.label
		M.last_signature.buf = buf
		M.last_signature.contents = contents
	else
		M.message("no docs available")
	end
	return signature
end

function M.request()
	M.height = vim.api.nvim_get_option_value("previewheight", {})
	M.width = vim.o.columns
	M.win = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/signatureHelp", params, signature_handler)
end

vim.keymap.set("n", "<leader>hrs", function()
	M.request()
end)
