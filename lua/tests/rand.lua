local pick = require("mini.pick")
local grep = pick.builtin.grep_live
local default = pick.default_show

grep(nil, {
	source = {
		show = function(buf_id, items, query, opts)
      for i, v in ipairs(items) do
        if v:sub(-1) == "\r" then
          items[i] = v:sub(1, -2)
        end
      end
      default(buf_id, items, query, opts)
		end,
	},
})
