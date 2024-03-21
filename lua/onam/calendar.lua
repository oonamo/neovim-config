---@class Calendar
---@field width number
---@field height number
---@field curDay number
---@field curMonth number
---@field curYear number
---@field header Header
---@field body Body
---@field bufnr number
---@field winopts table
---@field first_day number
---@field hover_day number
local Calendar = {}

---@class Header
---@field days string[]
---@field header string
---@field ui string
---@field divider string
local Header = {}

---@class Body
---@field days Day[]
---@field body string
---@field divider string
---@field width number
---@field height number
---@field loc_list string[]

---@class Day
---@field header string
---@field day_of_month number
---@field ui string
---@field divider string

local DAYS = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }
local DAYS_LEN = 21
local MONTHS = {
	"January",
	"February",
	"March",
	"April",
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December",
}
local MONTH_DAYS = {
	31,
	28,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31,
}

local function get_ui_size()
	local ui = vim.api.nvim_list_uis()[1]
	return ui.width, ui.height
end

local function floor(num)
	return math.floor(num)
end

local function zellers_congruence(month, year)
	local k = year % 100
	if month < 3 then
		month = month + 12
	end
	local j = floor(year / 100)
	-- return 1 + floor((13(month + 1)) / 5) + k + floor(k / 4) + floor(j / 4) - 2 * j) % 7
	return (1 + floor((13 * (month + 1)) / 5) + k + floor(k / 4) + floor(j / 4) - 2 * j) % 7
end
local round = function(x)
	return math.floor(x + 0.5)
end

function Calendar:init()
	-- self.curDay = tonumber(os.date("%d"))
	-- self.curMonth = tonumber(os.date("%m"))
	-- self.curYear = tonumber(os.date("%Y"))

	self.curDay = tonumber(os.date("%d"))
	self.curMonth = 2
	self.curYear = tonumber(os.date("%Y"))
end

function Calendar:show()
	local width, height = get_ui_size()
	self:init()
	self.winopts = {
		relative = "editor",
		border = "single",
		title_pos = "center",
		style = "minimal",
		focusable = false,
		width = round(width * 0.7),
		height = round(height * 0.7),
		title = MONTHS[self.curMonth] .. " " .. tostring(self.curYear),
	}

	self.winopts.row = (height - self.winopts.height) / 2
	self.winopts.col = (width - self.winopts.width) / 2
	local bufnr = vim.api.nvim_create_buf(false, true)
	self.bufnr = bufnr
	self.first_day = zellers_congruence(self.curMonth, self.curYear)

	self:header_init()
	self:draw_header()
	self:draw_body()

	vim.api.nvim_open_win(bufnr, true, self.winopts)

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", "<Cmd>q<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<Cmd>q<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-t>", "<Cmd>lua CAL_MOVE_CURRENT()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "l", "<Cmd>lua CAL_MOVE_NEXT()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "h", "<Cmd>lua CAL_MOVE_PREV()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "j", "<Cmd>lua CAL_MOVE_DOWN()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "k", "<Cmd>lua CAL_MOVE_UP()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "?", "<Cmd>=CAL_GET_CURRENT_POS()<CR>", { silent = false })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "a", "<Cmd>=CAL_GET_CURRENT_DAY_POS()<CR>", { silent = false })

	function CAL_GET_CURRENT_POS()
		return vim.api.nvim_win_get_cursor(0)
	end
	function CAL_GET_CURRENT_DAY_POS()
		return self.body.loc_list[self.hover_day]
	end
	function CAL_MOVE_CURRENT()
		vim.schedule(function()
			vim.api.nvim_win_set_cursor(0, self.body.loc_list[self.curDay])
			vim.notify("Current Day: " .. self.curDay)
			self.hover_day = self.curDay
		end)
	end
	function CAL_MOVE_NEXT()
		vim.schedule(function()
			if self.hover_day + 1 > MONTH_DAYS[self.curMonth] then
				self.hover_day = 1
			end
			vim.notify("Current hover: " .. self.hover_day)
			vim.api.nvim_win_set_cursor(0, self.body.loc_list[self.hover_day + 1])
			self.hover_day = self.hover_day + 1
			vim.notify("next hover: " .. self.hover_day)
		end)
	end
	function CAL_MOVE_PREV()
		vim.schedule(function()
			if self.hover_day - 1 < 1 then
				self.hover_day = #self.body.loc_list
			end
			vim.api.nvim_win_set_cursor(0, self.body.loc_list[self.hover_day - 1])
			vim.notify("Current hover: " .. self.hover_day)
			self.hover_day = self.hover_day - 1
			vim.notify("next hover: " .. self.hover_day)
		end)
	end
	function CAL_MOVE_DOWN()
		vim.schedule(function()
			if self.hover_day + 7 > #self.body.loc_list then
				self.hover_day = 1
			end
			vim.api.nvim_win_set_cursor(0, self.body.loc_list[self.hover_day + 7])
			vim.notify("Current hover: " .. self.hover_day)
			self.hover_day = self.hover_day + 7
			vim.notify("next hover: " .. self.hover_day)
		end)
	end
	function CAL_MOVE_UP()
		vim.schedule(function()
			if self.hover_day - 7 < 1 then
				self.hover_day = #self.body.loc_list
			end
			vim.api.nvim_win_set_cursor(0, self.body.loc_list[self.hover_day - 7])
			vim.notify("Current hover: " .. self.hover_day)
			self.hover_day = self.hover_day - 7
			vim.notify("next hover: " .. self.hover_day)
		end)
	end
	CAL_MOVE_CURRENT()
end

function Calendar:header_init()
	local header = {
		days = DAYS,
	}

	self.header = header
	local spaces = self.winopts.width - DAYS_LEN
	local space_per_day = round(spaces / 14)
	self.body = {}

	self.body.width = round(space_per_day * 2 + 3)
	self.body.height = round(self.winopts.height / 5)

	local header_str = ""
	for i, day in ipairs(DAYS) do
		for j = 1, space_per_day do
			header_str = header_str .. " "
		end
		header_str = header_str .. day
		for j = 1, space_per_day do
			if #header_str > self.winopts.width - 8 then
				break
			end
			header_str = header_str .. " "
		end
		if i ~= 7 then
			header_str = header_str .. "|"
		end
	end
	self.header.ui = header_str
	self.header.divider = ""
	for i = 1, self.winopts.width do
		self.header.divider = self.header.divider .. "-"
	end
end

function Calendar:draw_body()
	local count = 1
	local has_passed_first_day = false
	local day = 1
	local row = ""

	local row_num = 0
	local col_num = 3

	self.body.loc_list = {}

	local limit_reached = false

	while day <= MONTH_DAYS[self.curMonth] do
		for i = 1, 7 do
			if day > MONTH_DAYS[self.curMonth] then
				break
			end
			local sub = 1

			if day >= 10 then
				sub = 2
			end

			if has_passed_first_day then
				-- row = row .. "
				if day == self.curDay then
					row = row .. "x"
					table.insert(self.body.loc_list, { col_num, row_num })
					row_num = row_num + 1
				else
					row = row .. day
					if sub == 2 then
						table.insert(self.body.loc_list, { col_num, row_num + i })
					else
						table.insert(self.body.loc_list, { col_num, row_num })
					end
					row_num = row_num + 1
				end
				day = day + 1
			else
				row = row .. " "
				row_num = row_num + 1
			end

			for j = 1, self.body.width - sub do
				if #row + 1 > self.winopts.width then
					limit_reached = true
					break
				end
				row = row .. " "
				row_num = row_num + 1
			end

			if i + 1 == self.first_day and not has_passed_first_day then
				has_passed_first_day = true
			end

			if not limit_reached then
				row = row .. "|"
				row_num = row_num + 1
			end
			limit_reached = false
			if i == 7 then
				if day == 3 then
					print("31 got here: ", day)
					print("row 31: ", row)
				end
				if day == 30 then
					print("30 got here: ", day)
					print("row 30: ", row)
				end
				count = count + 1

				if count > self.winopts.height then
					break
				end
				vim.api.nvim_buf_set_lines(self.bufnr, count, self.winopts.height, false, { row })
				if count + 1 > self.winopts.height then
					break
				end
				-- for k = 1, self.body.height - 1 do
				--     vim.api.nvim_buf_set_lines(self.bufnr, count + k, self.winopts.height, false, { self.header.divider })
				-- end
				vim.api.nvim_buf_set_lines(self.bufnr, count + 1, self.winopts.height, false, { self.header.divider })
				count = count + 1
				row_num = 0
				col_num = col_num + 2
			end
			if day == MONTH_DAYS[self.curMonth] then
				local new_row = tostring(day)
				for j = 1, self.body.width - sub do
					if #row + 1 > self.winopts.width then
						limit_reached = true
						break
					end
					new_row = new_row .. " "
					row_num = row_num + 1
				end
				vim.api.nvim_buf_set_lines(self.bufnr, count + 1, self.winopts.height, false, { new_row })
				table.insert(self.body.loc_list, { col_num, row_num })
				break
			end
		end
		row = ""
	end
end

function Calendar:draw_header()
	vim.api.nvim_buf_set_lines(self.bufnr, 0, 1, false, { self.header.ui })
	vim.api.nvim_buf_set_lines(self.bufnr, 1, 2, false, { self.header.divider })
end

Calendar:show()
