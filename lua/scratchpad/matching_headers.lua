local pattern = "^###.*"

local tests = {
	"### Hello, 3",
	"## Hello, 2",
	"#### Hello, 4",
}

for _, v in ipairs(tests) do
	-- local match = string.gmatch
	for w in string.gmatch(v, pattern) do
		print(w)
	end
end
