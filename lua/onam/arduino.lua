---@class M
---@field boards table
local M = {}

M.boards = {
	"Adafruit Circuit Playground      arduino:avr:circuitplay32u4cat",
	"Arduino BT                       arduino:avr:bt",
	"Arduino Duemilanove or Diecimila arduino:avr:diecimila",
	"Arduino Esplora                  arduino:avr:esplora",
	"Arduino Ethernet                 arduino:avr:ethernet",
	"Arduino Fio                      arduino:avr:fio",
	"Arduino Gemma                    arduino:avr:gemma",
	"Arduino Industrial 101           arduino:avr:chiwawa",
	"Arduino Leonardo                 arduino:avr:leonardo",
	"Arduino Leonardo ETH             arduino:avr:leonardoeth",
	"Arduino Mega ADK                 arduino:avr:megaADK",
	"Arduino Mega or Mega 2560        arduino:avr:mega",
	"Arduino Micro                    arduino:avr:micro",
	"Arduino Mini                     arduino:avr:mini",
	"Arduino NG or older              arduino:avr:atmegang",
	"Arduino Nano                     arduino:avr:nano",
	"Arduino Pro or Pro Mini          arduino:avr:pro",
	"Arduino Robot Control            arduino:avr:robotControl",
	"Arduino Robot Motor              arduino:avr:robotMotor",
	"Arduino Uno                      arduino:avr:uno",
	"Arduino Uno Mini                 arduino:avr:unomini",
	"Arduino Uno WiFi                 arduino:avr:unowifi",
	"Arduino Y├║n                      arduino:avr:yun",
	"Arduino Y├║n Mini                 arduino:avr:yunmini",
	"LilyPad Arduino                  arduino:avr:lilypad",
	"LilyPad Arduino USB              arduino:avr:LilyPadUSB",
	"Linino One                       arduino:avr:one",
}

function M:init()
	local fzf = require("fzf-lua")
	fzf.fzf_exec(self.boards, {
		actions = {
			["default"] = function(selected)
				vim.print(selected) -- selected
			end,
		},
	})
end
M:init()
return M
