local api = vim.api
local totext = vim.treesitter.get_node_text

local M = {}
M.last_signature = {}

local language_ident = {
	c = "call_expression",
	lua = "function_call",
}

local function clear_cmd()
	vim.cmd([[echo '' | redraw]])
end

---@class signature.Parameters
---@field label table<number, number>

---@class config.Signature
---@field parameters signature.Parameters[]
---@field activeParameter number
---@field label string

---@param signature config.Signature
local function write_signature(signature)
	local params = {}
	for i, v in ipairs(signature.parameters) do
		local start, stop = v.label[1], v.label[2]
		local label = signature.label:sub(start + 1, stop)
		if i ~= #signature.parameters then
			label = label .. ", "
		end
		if i == signature.activeParameter + 1 then
			table.insert(params, { label, "LspSignatureActiveParameter" })
		else
			table.insert(params, { label, "Normal" })
		end
	end

	local node = vim.treesitter.get_node()
	while node and node:type() ~= language_ident[vim.bo.ft] do
		node = node:parent()
	end
	node = node and node:child(0)
	if not node then
		-- node = node:parent()
		return
	end
	local ident
	ident = totext(node, 0) .. ": "
	ident = string.gsub(ident, "[\n\r\t]", " ")
	table.insert(params, 1, { ident, "Function" })

	-- FROM: https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/ai.lua
	-- SEE: Lines 1956-1976
	local max_width = vim.o.columns * math.max(vim.o.cmdheight - 1, 0) + vim.v.echospace
	local chunks, tot_width = {}, 0
	for _, ch in ipairs(params) do
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

--- FROM: https://github.com/ray-x/lsp_signature.nvim/blob/master/lua/lsp_signature/init.lua
local function signature_handler(_, result, ctx, config)
	-- vim.print(result)
	-- vim.print(M.last_signature)
	config = config or {}
	config.focus_id = ctx.method
	if api.nvim_get_current_buf() ~= ctx.bufnr then
		M.last_signature = {}
		clear_cmd()
		return
	end

	if result == nil or result.signatures == nil or result.signatures[1] == nil then
		M.last_signature = {}
		clear_cmd()
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

	if M.last_signature.label == actSig.label and M.last_signature.activeParameter == actSig.activeParameter then
		return
	end
	M.last_signature = vim.deepcopy(actSig)
	actSig.activeParameter = actSig.activeParameter or 0
	actSig.label = string.gsub(actSig.label, "[\n\r\t]", " ")
	write_signature(actSig)
end

local function sig()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/signatureHelp", params, vim.lsp.with(signature_handler, {}))
end

function M.setup(opts)
	opts = opts or {}
	opts.delay = opts.delay or 200
	M.opts = opts
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		callback = function()
			vim.defer_fn(function()
				sig()
			end, opts.delay)
		end,
	})
end

return M
