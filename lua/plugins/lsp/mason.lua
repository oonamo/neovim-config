-- "williamboman/mason.nvim",
		-- cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog" },
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })
