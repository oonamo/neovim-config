-- require("mini.colors").setup()
-- require("mini.colors").interactive()

local function can_error(v)
	if v % 2 == 0 then
		error("something bad happen")
	end
	return "good job"
end

local r1, err = pcall(can_error, 1)
print("r1", r1)
print("r2", err)

-- local function somethign()
-- 	print("some")
-- end
--
-- chan_set('lightness', 15, { filter = 'bg' })
-- chan_set('lightness', 85, { filter = 'fg' })
-- Make background colors less saturated and foreground - more
-- chan_add('saturation', -20, { filter = 'bg' })
-- chan_add('saturation', 20,  { filter = 'fg' })

-- Convert to grayscale
-- chan_set('saturation', 0)

-- Invert temperature (make cold theme become warm and vice versa)
-- chan_invert('temperature')

-- Make background colors colder and foreground warmer
-- chan_add('temperature', -40, { filter = 'bg' })
-- chan_add('temperature', 40,  { filter = 'fg' })
