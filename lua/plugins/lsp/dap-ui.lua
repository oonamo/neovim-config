return {
	{
		"rcarriga/nvim-dap-ui",
		enabled = false,
		dependencies = { { "mfussenegger/nvim-dap", lazy = true } },
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.after.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.after.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		keys = {
			{ "<leader>dt", ":DapToggleBreakpoint<CR>", desc = "toggle breakpoint" },
			{ "<leader>dx", ":DapTerminate<CR>", desc = "dap terminate" },
			{ "<leader>do", ":DapStepOver<CR>", desc = "dap step over" },
		},
		lazy = true,
	},
}
