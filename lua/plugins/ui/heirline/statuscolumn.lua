local function pad_str(in_str, width, align)
	local num_spaces = width - #in_str
	if num_spaces < 1 then
		num_spaces = 1
	end
	local spaces = string.rep(" ", num_spaces)

	if align == "left" then
		return table.concat({ in_str, spaces })
	end

	return table.concat({ spaces, in_str })
end
local Stc = {
	static = {
		---@return {name:string, text:string, texthl:string}[]
		get_signs = function()
			-- local buf = vim.api.nvim_get_current_buf()
			local buf = vim.fn.expand("%")
			return vim.tbl_map(function(sign)
				return vim.fn.sign_getdefined(sign.name)[1]
			end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
		end,
		resolve = function(self, name)
			for pat, cb in pairs(self.handlers) do
				if name:match(pat) then
					return cb
				end
			end
		end,
		handlers = {
			["GitSigns.*"] = function(args)
				require("gitsigns").preview_hunk_inline()
			end,
			["Dap.*"] = function(args)
				require("dap").toggle_breakpoint()
			end,
			["Diagnostic.*"] = function(args)
				vim.diagnostic.open_float() -- { pos = args.mousepos.line - 1, relative = "mouse" })
			end,
		},
	},
	init = function(self)
		local signs = {}
		for _, s in ipairs(self.get_signs()) do
			if s.name:find("GitSign") then
				self.git_sign = s
			else
				table.insert(signs, s)
			end
		end
		self.signs = signs
	end,
	{
		provider = "%s ",
		-- provider = function(self)
		-- 	-- return vim.inspect({ self.signs, self.git_sign })
		-- 	local children = {}
		-- 	for _, sign in ipairs(self.signs) do
		-- 		table.insert(children, {
		-- 			provider = sign.text,
		-- 			hl = sign.texthl,
		-- 		})
		-- 	end
		-- 	self[1] = self:new(children, 1)
		-- end,
		on_click = {
			callback = function(self, ...)
				local mousepos = vim.fn.getmousepos()
				vim.api.nvim_win_set_cursor(0, { mousepos.line, mousepos.column })
				local sign_at_cursor = vim.fn.screenstring(mousepos.screenrow, mousepos.screencol)
				if sign_at_cursor ~= "" then
					local args = {
						mousepos = mousepos,
					}
					local signs = vim.fn.sign_getdefined()
					for _, sign in ipairs(signs) do
						local glyph = sign.text:gsub(" ", "")
						if sign_at_cursor == glyph then
							vim.defer_fn(function()
								self:resolve(sign.name)(args)
							end, 10)
							return
						end
					end
				end
			end,
			name = "heirline_signcol_callback",
			update = true,
		},
	},
	{
		-- provider = "%=%4{v:virtnum ? '' : &nu ? (&rnu && v:relnum ? v:relnum : v:lnum) . ' ' : ''}",
		provider = function()
			local cur_num
			local sep = ","

			-- return a visual placeholder if line is wrapped
			if vim.v.virtnum ~= 0 then
				return "│"
			end

			-- get absolute lnum if is current line, else relnum
			cur_num = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum

			-- insert thousands separators in line numbers
			-- viml regex: https://stackoverflow.com/a/42911668
			-- lua pattern: stolen from Akinsho
			if cur_num > 999 then
				cur_num = tostring(cur_num):reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
			else
				cur_num = tostring(cur_num)
			end

			-- return pad_str(cur_num, 3, "right")
			return cur_num .. " "
		end,
	},
	-- {
	-- 	provider = " %{% &fdc ? '%C ' : '' %}",
	-- },
	-- {
	-- 	provider = function(self)
	-- 		return self.git_sign and self.git_sign.text
	-- 	end,
	-- 	hl = function(self)
	-- 		return self.git_sign and self.git_sign.texthl
	-- 	end,
	-- },
}
return Stc
-- local conditions = require("heirline.conditions")
--
-- local function is_virtual_line()
-- 	return vim.v.virtnum < 0
-- end
--
-- local function is_wrapped_line()
-- 	return vim.v.virtnum > 0
-- end
--
-- local function not_in_fold_range()
-- 	return vim.fn.foldlevel(vim.v.lnum) <= 0
-- end
--
-- local function not_fold_start(line)
-- 	return vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1)
-- end
--
-- local function fold_opened(line)
-- 	return vim.fn.foldclosed(line or vim.v.lnum) == -1
-- end

-- local Number = {
-- 	{ provider = "%=" },
-- 	{
-- 		provider = function()
-- 			local lnum = tostring(vim.v.lnum)
-- 			if is_virtual_line() then
-- 				-- return string.rep("│", #lnum)
-- 				return "│"
-- 			elseif is_wrapped_line() then
-- 				return "│"
-- 			else
-- 				-- return (#lnum == 1 and "" or "") .. lnum .. " "
-- 				return lnum .. " "
-- 			end
-- 		end,
-- 	},
-- 	-- { provider = " " },
-- }
-- local Number = {
-- 	-- provider = "%=%4{v:virtnum ? '' : &nu ? (&rnu && v:relnum ? v:relnum : v:lnum) . ' ' : ''}",
-- 	provider = function()
-- 		local cur_num
-- 		local sep = ","
--
-- 		-- return a visual placeholder if line is wrapped
-- 		if vim.v.virtnum ~= 0 then
-- 			return "│"
-- 		end
--
-- 		-- get absolute lnum if is current line, else relnum
-- 		cur_num = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
--
-- 		-- insert thousands separators in line numbers
-- 		-- viml regex: https://stackoverflow.com/a/42911668
-- 		-- lua pattern: stolen from Akinsho
-- 		if cur_num > 999 then
-- 			cur_num = tostring(cur_num):reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
-- 		else
-- 			cur_num = tostring(cur_num)
-- 		end
--
-- 		-- return pad_str(cur_num, 3, "right")
-- 		return cur_num .. " "
-- 	end,
-- }
--
-- local Fold = {
-- 	provider = function()
-- 		if is_wrapped_line() or is_virtual_line() then
-- 			return ""
-- 		elseif not_in_fold_range() or not_fold_start(vim.v.lnum) then
-- 			return ""
-- 		elseif fold_opened() then
-- 			return tools.ui.icons.r_chev
-- 		else
-- 			return tools.ui.icons.ChevronShortDown
-- 		end
-- 	end,
-- 	hl = {
-- 		fg = "bright_fg",
-- 		bg = "bg",
-- 		bold = true,
-- 	},
-- 	on_click = {
-- 		name = "heirline_fold_click_handler",
-- 		callback = function()
-- 			local line = vim.fn.getmousepos().line
--
-- 			if not_fold_start(line) then
-- 				return
-- 			end
--
-- 			vim.cmd.execute("'" .. line .. "fold" .. (fold_opened(line) and "close" or "open") .. "'")
-- 		end,
-- 	},
-- }
--
-- local Border = {
-- 	condition = function()
-- 		return vim.bo.filetype ~= "markdown"
-- 	end,
-- 	init = function(self)
-- 		local ns_id = vim.api.nvim_get_namespaces()["gitsigns_extmark_signs_"]
-- 		if ns_id then
-- 			local marks = vim.api.nvim_buf_get_extmarks(
-- 				0,
-- 				ns_id,
-- 				{ vim.v.lnum - 1, 0 },
-- 				{ vim.v.lnum, 0 },
-- 				{ limit = 1, details = true }
-- 			)
--
-- 			if #marks > 0 then
-- 				local hl_group = marks[1][4]["sign_hl_group"]
-- 				self.highlight = hl_group
-- 			else
-- 				self.highlight = nil
-- 			end
-- 		end
-- 	end,
-- 	provider = tools.ui.icons.v_border,
-- 	hl = function(self)
-- 		return self.highlight or "blue"
-- 	end,
-- }
--
-- local Padding = {
-- 	provider = " ",
-- 	hl = function()
-- 		if not conditions.is_active() then
-- 			return { bg = "bg" }
-- 		-- elseif vim.v.lnum == vim.fn.getcurpos()[2] then
-- 		-- 	return { bg = "purple" }
-- 		else
-- 			return { bg = "bg" }
-- 		end
-- 	end,
-- }
-- -- return { Number, Fold, Padding }
-- return { Border, Padding, Number, Fold }
