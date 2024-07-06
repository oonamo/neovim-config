require("mini.colors").setup()
require("mini.colors").interactive()

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

-- chan_add("lightness", 85, { filter = "bg" })
-- chan_add("lightness", -20, { filter = "fg" })
-- chan_add('saturation', 30,  { filter = 'fg' })
-- chan_add('saturation', -100,  { filter = 'bg' })
-- chan_set('saturation', { 10, 90 }, {
--     filter = 'fg',
--     gamut_clip = "lightness"
-- })
-- chan_add('saturation', -100,  { filter = 'bg' })
-- :chan_add("saturation", -20, { filter = "bg" })
-- :chan_add("saturation", 20, { filter = "fg" })
-- :chan_set("saturation", { 10, 90 }, { filter = "fg" })
-- :chan_invert("pressure", { filter = "fg" })
-- :chan_set("hue", { 12, 250, 315 }, { filter = "fg" })
-- :write()
