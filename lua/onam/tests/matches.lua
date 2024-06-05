local tests = {
	"rose-pine.nvim",
	"newpaper.nvim",
	"fzf.vim",
	"onam.globals",
	"something-else.lua",
	"remaps",
}

for _, v in ipairs(tests) do
	local spec = string.gsub(v, "%.nvim", "")
	local is_vim_plug = string.find(v, "%.vim") or 0
	if is_vim_plug ~= 0 then
		print(spec, "is vim plug, no spec needed")
	else
		print("spec", spec)
	end
end
