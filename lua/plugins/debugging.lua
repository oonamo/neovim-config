return {
	"mfussenegger/nvim-dap",
	dependencies = { "nvim-neotest/nvim-nio", "rcarriga/nvim-dap-ui" },
	config = function(_, opts)
		local dap, ui = require("dap"), require("dapui")
		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		ui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "C:/Users/onam7/codelldb/extension/adapter/codelldb.exe",
				args = { "--port", "${port}" },

				-- Might need on windows
				detached = false,
			},
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
	keys = {
		{
			"<leader>dt",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<F1>",
			function()
				require("dap").continue()
			end,
			desc = "Continue Debugging",
		},
		{
			"<F2>",
			function()
				require("dap").step_into()
			end,
			desc = "Continue Debugging",
		},
		{
			"<F3>",
			function()
				require("dap").step_over()
			end,
			desc = "Continue Debugging",
		},
		{
			"<F4>",
			function()
				require("dap").step_out()
			end,
		},
		{
			"<F5>",
			function()
				require("dap").step_back()
			end,
		},
		{
			"<F6>",
			function()
				require("dap").restart()
			end,
		},
	},
}
