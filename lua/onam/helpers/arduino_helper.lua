local M = {}
M.fqbn = "arduino:avr:mega"
M.ide = "vim"
M.board = "ATmega2560"
M.port = "COM3"
M.compile_command = "arduino-cli compile -b " .. M.board
M.pio_compile = "pio run"
vim.keymap.set("n", "<leader>ac", function() end)
M.pio_init_cmd = "pio project init --ide vim --board " .. M.board

function M.pio_init()
	print("Initializing arduino project")
	local cwd = vim.api.nvim_buf_get_name(0)
	if vim.bo.filetype == "oil" then
		cwd = string.match(cwd, "oil:///(.+)")
		cwd = string.sub(cwd, 2, -1)
		cwd = "C:" .. cwd
	end
	_ = vim.fn.jobstart(M.pio_init_cmd, {
		cwd = cwd,
		on_stdout = function(_, data, _)
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_stderr = function(_, data, _)
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_exit = function(_, data, _)
			print(data)
		end,
	})
end

function M.compile()
	print("Compiling arduino project...")
	local handle = io.popen(M.pio_compile)
	if not handle then
		vim.notify("Error: " .. M.pio_init_cmd, vim.log.levels.ERROR)
		return
	end
	local output = handle:read("*a")
	handle:close()
	print(output)
end

function M.test()
	print("Testing arduino project...")
	local cwd = vim.api.nvim_buf_get_name(0)
	cwd = "oil:///C/Users/onam7/projects"
	cwd = string.match(cwd, "oil:///(.+)")
	cwd = string.sub(cwd, 2, -1)
	cwd = "C:" .. cwd
	print("cwd: " .. cwd)
	vim.fn.jobstart("echo test", {
		cwd = cwd,
		on_stdout = function(_, data, _)
			print("on_stdout")
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_stderr = function(_, data, _)
			print("on_stderr")
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_exit = function(_, data, _)
			print("on_exit")
			print(data)
		end,
	})
end

function M.hydra()
	local Hydra = require("hydra")
	local hint = [[
                            +5VDC
                     |
                     \
                     /  270 ohms
                     \
                     /
Control|\ 7407       |
-------| >-----------+
       |/            |
Control = 1 LED on   |
Control = 0 LED off  |
                     |
                    LED
        _c_: Compile
        _u_: Upload
        _t_: Test
        _q_: Quit
    ]]

	Hydra({
		name = "Arduino",
		hint = hint,
		config = {
			color = "teal",
			invoke_on_body = true,
			hint = {
				position = "bottom",
				border = "rounded",
			},
		},
		mode = "n",
		body = "<leader>ih",
		heads = {
			-- {
			-- 	"i",
			-- 	function()
			-- 		M.init_arduino()
			-- 	end,
			-- 	{ desc = "Init" },
			-- },
			{
				"u",
				function()
					M.arduino_upload()
				end,
				{ desc = "Upload" },
			},
			{
				"c",
				function()
					M.arduino_compile()
				end,
				{ desc = "Compile" },
			},
			{
				"t",
				function()
					M.test()
				end,
				{ desc = "Test" },
			},
			{ "q", nil, { exit = true } },
		},
	})
	return Hydra
end

function M.arduino_compile()
	local current_file = vim.api.nvim_buf_get_name(0)
	M.arduino_compile = "arduino-cli compile --fqbn " .. M.fqbn .. " " .. current_file
	vim.fn.jobstart(M.arduino_compile, {
		on_stdout = function(_, data, _)
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_stderr = function(_, data, _)
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_exit = function(_, data, _)
			print(data)
		end,
	})
end

function M.arduino_upload()
	local current_file = vim.api.nvim_buf_get_name(0)
	print(current_file)
	local command = "arduino-cli upload -p " .. M.port .. " --fqbn " .. M.fqbn .. " " .. current_file
	print("command: " .. command)
	vim.fn.jobstart(command, {
		on_stdout = function(_, data, _)
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_stderr = function(_, data, _)
			for _, line in ipairs(data) do
				print(line)
			end
		end,
		on_exit = function(_, data, _)
			print(data)
		end,
	})
end

return M
