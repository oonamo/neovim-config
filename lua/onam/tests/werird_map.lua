local m_tils = require("utils.mini")
-- require("onam.tests.load_me_from_weirdj")

m_tils.on_key({
	"n",
	"<leader>Lh",
	function()
		vim.notify("Hello")
	end,
}, "onam.tests.load_me_from_weirdj")
