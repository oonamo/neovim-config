local tests = {
	"rose-pine.nvim",
	"newpaper.nvim",
}

for _, v in ipairs(tests) do
	local spec = string.gsub(v, ".nvim", "")
	print("spec", spec)
end
