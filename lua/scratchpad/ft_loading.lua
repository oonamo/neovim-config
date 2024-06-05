local fts = {}
local function ft(fileytpe, spec, opts)
	if fts[fileytpe] == nil then
		fts[fileytpe] = {}
	end
	table.insert(fts[fileytpe], { spec = spec, opts = opts })
end

ft("markdown", { "mini.bracketed" }, {})
ft("markdown", { "mini.ai" }, {})
ft("c", { "mini.bracketed" }, {})
ft("rust", { "mini.ai" }, {})

for filetype, plug in pairs(fts) do
	-- for _, v in ipairs(plug) do
	-- 	print("ft", filetype)
	-- 	vim.print(v)
	-- end
	-- vim.api.nvim_create_autocmd({ "Filetype" }, {
	-- 	pattern = filetype,
	-- 	callback = function()
	-- 		for _, v in ipairs(plug) do
	-- 			--load(v.spec, v.opts)
	-- 		end
	-- 	end,
	-- })
end
