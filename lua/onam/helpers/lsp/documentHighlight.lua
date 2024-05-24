return function(bufnr)
	local under_cursor_highlights_group = vim.api.nvim_create_augroup("cursor_highlights", { clear = false })
	vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave", "BufEnter" }, {
		group = under_cursor_highlights_group,
		desc = "Highlight references under the cursor",
		buffer = bufnr,
		callback = vim.lsp.buf.document_highlight,
	})
	vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
		group = under_cursor_highlights_group,
		desc = "Clear highlight references",
		buffer = bufnr,
		callback = vim.lsp.buf.clear_references,
	})
end
