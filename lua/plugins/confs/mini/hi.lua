local hipatterns = require("mini.hipatterns")
if not MiniExtra then
	require("mini.extra").setup()
end

-- local hi_words = MiniExtra.gen_highlighter.words

local highlighters = {
	fixme = { pattern = "()FIXME():", group = "MiniHipatternsFixme" },
	hack = { pattern = "()HACK():", group = "MiniHipatternsHack" },
	todo = { pattern = "()TODO():", group = "MiniHipatternsTodo" },
	note = { pattern = "()NOTE():", group = "MiniHipatternsNote" },
	from = { pattern = "()FROM():", group = "MiniHipatternsNote" },
	fixme_colon = { pattern = " FIXME():()", group = "MiniHipatternsFixmeColon" },
	hack_colon = { pattern = " HACK():()", group = "MiniHipatternsHackColon" },
	todo_colon = { pattern = " TODO():()", group = "MiniHipatternsTodoColon" },
	note_colon = { pattern = " NOTE():()", group = "MiniHipatternsNoteColon" },
	from_colon = { pattern = " FROM():()", group = "MiniHipatternsNoteColon" },
	fixme_body = { pattern = " FIXME:().*()", group = "MiniHipatternsFixmeBody" },
	hack_body = { pattern = " HACK:().*()", group = "MiniHipatternsHackBody" },
	todo_body = { pattern = " TODO:().*()", group = "MiniHipatternsTodoBody" },
	note_body = { pattern = " NOTE:().*()", group = "MiniHipatternsNoteBody" },
	from_body = { pattern = " FROM:().*()", group = "MiniHipatternsNoteBody" },
	hex_color = hipatterns.gen_highlighter.hex_color(),
}

-- # Hello, world
-- ## Hello world
-- ### Somethng, something

-- TODO:
-- HACK: test
-- FIXME: hello
-- NOTE: Something
-- fixme = hi_words({ "()FIXME():", "()Fixme():", "()fixme():" }, "MiniHipatternsFixme"),
-- hack = hi_words({ "HACK:", "Hack:", "hack:" }, "MiniHipatternsHack"),
-- todo = hi_words({ "TODO:", "Todo:", "todo:" }, "MiniHipatternsTodo"),
-- note = hi_words({ "NOTE:", "Note:", "note:" }, "MiniHipatternsNote"),
hipatterns.setup({
	highlighters = highlighters,
})

local hls = {
	"MiniHipatternsFixme",
	"MiniHipatternsHack",
	"MiniHipatternsTodo",
	"MiniHipatternsNote",
}

-- TODO: hello
for _, hl in ipairs(hls) do
	vim.api.nvim_set_hl(0, hl .. "Colon", { link = hl })
	vim.api.nvim_set_hl(0, hl .. "Body", { link = hl })
end
