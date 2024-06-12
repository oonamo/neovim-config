vim.ui.select({ "y", "n" }, {
	prompt = "Install?",
	default = "n",
}, function(val)
	if val == "y" then
		vim.notify("installing...")
	else
		vim.notify("aborting...")
	end
end)
