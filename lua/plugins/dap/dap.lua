return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			lazy = true,
		},
		{ "nvim-neotest/nvim-nio", lazy = true },
	},
	lazy = true,
	config = function()
		local c_conf = {
			{
				name = "Launch File",
				type = "codelldb",
				request = "launch",
				program = function()
					-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					require("fzf-lua").files({
						cmd = "fd .exe",
					})
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		dap.adapters = {
			codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "C:/Users/onam7/.vscode/extensions/extension/adapter/codelldb.exe",
					args = { "--port", "${port}" },

					-- TODO: Do I need this
					detached = false,
				},
				name = "lldb",
			},
		}

		dap.configurations = {
			cpp = c_conf,
			c = c_conf,
			rust = c_conf,
		}

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated.dapui_config = function()
		-- 	dapui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function()
		-- 	dapui.close()
		-- end

		-- vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		-- vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Debugging" })
		-- vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle UI" })
	end,
	keys = {
		{ "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
		{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue Debugging" },
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle UI",
		},
	},
}
