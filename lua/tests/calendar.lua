local months = {
	["January"] = 1,
	["Feburary"] = 2,
	["March"] = 3,
	["April"] = 4,
	["May"] = 5,
	["June"] = 6,
	["July"] = 7,
	["August"] = 8,
	["Sepetember"] = 9,
	["October"] = 10,
	["November"] = 11,
	["December"] = 12,
}

local monthMap = {
	31, -- jan
	28, -- feb
	31, -- mar
	30, -- apr
	31, -- may
	30, -- jun
	31, -- jul
	31, -- aug
	30, -- sep
	31, -- oct
	30, -- nov
	31, -- dec
}

local dayNumberMap = {
	0,
	3,
	2,
	5,
	0,
	3,
	5,
	1,
	4,
	6,
	2,
	4,
}

local function dayNumber(day, month, year)
	-- year = year - month < 3
	if month < 3 then
		year = year - 1
	end
	return year + year / 4 - year / 100 + year / 400 + dayNumberMap[month] + day
end

local function num_days(month, year)
	if type(month) == "string" then
		month = months[month]
	end
	if month == 1 then
		return 31
	end

	if month == 2 then
		if year % 400 == 0 or year % 4 == 0 and year % 100 ~= 0 then
			return 29
		end
		return 28
	end

	return monthMap[month]
end

local function printCalendar(month)
	print("Calendar")
  local string = ""
	local days
	local current = dayNumber(1, month, 2024)
	days = num_days(1, 2024)
	string = string .. string.format("\n ------------%s-------------\n", months[month])
	-- print(" Sun Mon Tue Wed Thu Fri Sat\n")
	local k = 0
	for tmp = 0, current do
		string = string .. "     "
	end
	k = current

	for j = 0, days + 1 do
		string = string .. " " .. j .. " "
		k = k + 1
		if k > 6 then
			k = 0
			string = string .. "\n"
		end
	end

	if k then
		string = string .. "\n"
	end

	current = k
	print(string)
end

printCalendar(1)
