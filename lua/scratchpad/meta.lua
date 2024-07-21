local type_hlgroups = setmetatable({
	["-"] = "OilTypeFile",
	["d"] = "OilTypeDir",
	["p"] = "OilTypeFifo",
	["l"] = "OilTypeLink",
	["s"] = "OilTypeSocket",
}, {
	__index = function()
		return "OilTypeFile"
	end,
})

print(type_hlgroups["d"])
