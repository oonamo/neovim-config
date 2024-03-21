local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local c = ls.choice_node

vim.notify("markdown snippets loaded", vim.log.levels.INFO)

local snippets, autosnippets = {}, {}
---@param count number
---@param idx number
local function repeat_with_count(count, idx)
	return f(function(arg)
		if arg[1][1] == "& b_1" then
			return "& b_" .. idx
		end
		return arg[1]
	end, { count })
end

local function matrix_node(args)
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

autosnippets = {
	s({ trig = "m(%d+)x(%d+)", regTrig = true }, {
		t("\\begin{bmatrix}"),
		t({ "", "" }),
		d(1, function(_, snipp)
			return matrix_node(snipp.captures)
		end),
		t("\\end{bmatrix}"),
	}),
	s(
		{ trig = "env", regTrig = true },
		fmta(
			[[
    \begin{<>}
        <>
    \end{<>}
    ]],
			{
				i(1, "envname"),
				i(2, "content"),
				rep(1),
			}
		)
	),

	s(
		{ trig = "elm", regTrig = true },
		fmt(
			[[
    \begin{{bmatrix}}
    a_{{11}} & a_{{12}} & a_{{13}} {}\\
    a_{{21}} & a_{{22}} & a_{{23}} {}\\
    \vdots & \vdots & \vdots {}\\
    a_{{n1}} & a_{{n2}} & a_{{n3}} {}\\
    \end{{bmatrix}}
    ]],
			{
				c(1, { t("& b_1"), t("& \\vdots"), t("") }),
				repeat_with_count(1, 2),
				repeat_with_count(1, 3),
				repeat_with_count(1, 4),
			}
		)
	),
	s({ trig = "(.+)/(.+);", regTrig = true }, {
		f(function(_, snip)
			return "\\frac{" .. snip.captures[1] .. "}{" .. snip.captures[2] .. "}"
		end),
	}),
	-- s(
	-- 	{ trig = "(%w+)/(%w+);", regTrig = true },
	-- 	f(function(_, snip)
	-- 		return "\\frac{" .. snip.captures[1] .. "}{" .. snip.captures[2] .. "}"
	-- 	end)
	-- ),
	s(
		";;init",
		fmta(
			[[
\documentclass{article}
\usepackage{amsmath}
\usepackage{pgfplots}
\usepackage{caption}
\usepackage{subcaption}
\pgfplotsset{compat=1.18}
\title{<>}
\author{Onam Hernandez}
\date{\today}
\begin{document}
\maketitle
\section{<>}
        ]],
			{
				i(1, "title"),
				rep(1),
			}
		)
	),
}

return snippets, autosnippets
