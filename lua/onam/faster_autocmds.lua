utils.augroup("Wezterm", {
	{
		events = { "VimEnter" },
		targets = { "*" },
		command = function()
			-- vim.env.IS_NVIM = true
			local stdout = vim.loop.new_tty(1, false)
			stdout:write(
				("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format("IS_NVIM", vim.fn.system({ "base64" }, "1"))
			)
		end,
		desc = "write variable to know when inside neovim",
	},
	{
		events = { "VimLeave" },
		targets = { "*" },
		command = function()
			local stdout = vim.loop.new_tty(1, false)
			stdout:write(
				("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
					"IS_NVIM",
					vim.fn.system({ "base64" }, "-1")
				)
			)
		end,
		desc = "rewrite variable to be false when leaving neovim",
	},
})
