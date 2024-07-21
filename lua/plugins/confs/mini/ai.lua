local miniai = require("mini.ai")
local function indent(ai_type)
	local spaces = (" "):rep(vim.o.tabstop)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local indents = {} ---@type {line: number, indent: number, text: string}[]

	for l, line in ipairs(lines) do
		if not line:find("^%s*$") then
			indents[#indents + 1] = { line = l, indent = #line:gsub("\t", spaces):match("^%s*"), text = line }
		end
	end

	local ret = {}

	for i = 1, #indents do
		if i == 1 or indents[i - 1].indent < indents[i].indent then
			local from, to = i, i
			for j = i + 1, #indents do
				if indents[j].indent < indents[i].indent then
					break
				end
				to = j
			end
			from = ai_type == "a" and from > 1 and from - 1 or from
			to = ai_type == "a" and to < #indents and to + 1 or to
			ret[#ret + 1] = {
				indent = indents[i].indent,
				from = { line = indents[from].line, col = ai_type == "a" and 1 or indents[from].indent + 1 },
				to = { line = indents[to].line, col = #indents[to].text },
			}
		end
	end

	return ret
end
miniai.setup({
	custom_textobjects = {
		B = MiniExtra.gen_ai_spec.buffer(),
		-- F = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
		i = indent,
	},
	search_method = "cover_or_next",
})
