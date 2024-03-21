local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

vim.notify("lua snips loaded", vim.log.levels.INFO)
local snippets, autosnippets = {}, {}

local first = s("fst", {
	t("first snippet"),
})

local first_auto = s("auto-", {
	t("this is was automatically created"),
})

local function matrix_node(args)
	-- args has the form of %dx%d, get only the numbers
	local rows = tonumber(args[1])
	local columns = tonumber(args[2])
	local j_vec = {}
	local count = 1
	for x = 1, rows do
		for j = 1, columns do
			local jNode
			jNode = i(count)
			j_vec[2 * count - 1] = jNode
			if j ~= columns then
				j_vec[2 * count] = t(" & ")
			end
			count = count + 1
		end
		j_vec[#j_vec + 1] = t({ "\\\\", "" })
	end
	return sn(nil, j_vec)
end

local function matrix_rows(args)
	local tabs = {}
	local rows = tonumber(args[2])
	for j = 1, rows do
		tabs[2 * j - 1] = i(j)
		if j ~= rows then
			tabs[2 * j] = t(" & ")
		end
	end
	return sn(nil, tabs)
end

local matrix = s({ trig = "m(%d+)x(%d+)-", regTrig = true }, {
	t("\\begin{bmatrix}", ""),
	t({ "", "" }),
	d(1, function(_, snipp)
		return matrix_node(snipp.captures)
	end),
	t("\\end{bmatrix}"),
})

local eqn = s(
	{ trig = "eqn", name = "equation" },
	fmta(
		[[
    \begin{equation}
    <>
    \end{equation}
    ]],
		{
			i(1),
		}
	)
)

local qf = s(
	{ trig = "(.+)/(.+);", regTrig = true },
	f(function(_, snip)
		return "\\frac{" .. snip.captures[1] .. "}{" .. snip.captures[2] .. "}"
	end)
)
-- table.insert(autosnippets, qf)
-- table.insert(autosnippets, elementary_matrix)
-- table.insert(autosnippets, eqn)
-- table.insert(snippets, first)
-- table.insert(autosnippets, matrix)
return snippets, autosnippets
