return {

	{
		"echasnovski/mini.surround",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mini.surround").setup({})
		end,
	},
}
