local file = io.open("C:/Users/onam7/AppData/Local/nvim/lua/onam/test_file.txt")
-- local file = vim.fn.readfile("C:/Users/onam7/AppData/Local/nvim/lua/onam/test_file.txt")
if file then
	local colorscheme = file:read()
	local color, flavor = colorscheme:match("([^,]*),(.*)")
	if not color then
		print("error")
		return
	end
	print("color is " .. color)
	print("flavor is " .. flavor)
	vim.fn.writefile({ "hello" .. ",read" }, "C:/Users/onam7/AppData/Local/nvim/lua/onam/test_file.txt")
else
	print("error")
end
