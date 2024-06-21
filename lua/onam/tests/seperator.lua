local font = "MonoLisa Nerd Font:h12"
local _, _, f, size = string.find(font, "(.*:h)(.*)")
font = f .. tonumber(size) + 3
print(font)
