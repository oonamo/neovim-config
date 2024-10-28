vim.keymap.set("n", "<F1>", function()
	print("pressed f1!")
end)

vim.keymap.set("n", "<C-space>", function()
	print("pressed <C-space>!")
end)

vim.keymap.set("n", "<C-d>", function()
  print("pressed <A-space>!")
end)


for i = 0, 10 do
	vim.keymap.set("n", "<F" .. i .. ">", function()
		print("pressed f" .. i)
	end)
end
