-- TODO: Might not need
return {
	"andymass/vim-matchup",
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
	event = { "BufReadPre", "BufNewFile" },
}
