local tests = {
	"roses,",
	"roses,main",
	"gruvbox-material,dark-soft",
	"gruvbox-material,light-hard",
	"kanagawa,wave",
}

for _, test in pairs(tests) do
	local color, next = string.match(test, "([^,]*),(.*)")
	print("color", color)
	local flavour_tbl = {}
	for token in string.gmatch(next, "([^-]+)") do
		table.insert(flavour_tbl, token)
	end
	if #flavour_tbl == 1 then
		flavour_tbl = flavour_tbl[1]
	end
	vim.print("flavour", flavour_tbl)
end
