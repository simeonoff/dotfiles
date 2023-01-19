local M = {
	"mfussenegger/nvim-dap",

	dependencies = {
		{
			"rcarriga/nvim-dap-ui",

			config = function()
				require("dapui").setup()
			end,
		},
	},
}

function M.init()
	vim.keymap.set("n", "<leader>db", function()
		require("dap").toggle_breakpoint()
	end, { desc = "Toggle Breakpoint" })

	vim.keymap.set("n", "<leader>dc", function()
		require("dap").continue()
	end, { desc = "Continue" })

	vim.keymap.set("n", "<leader>do", function()
		require("dap").step_over()
	end, { desc = "Step Over" })

	vim.keymap.set("n", "<leader>di", function()
		require("dap").step_into()
	end, { desc = "Step Into" })

	vim.keymap.set("n", "<leader>dw", function()
		require("dap.ui.widgets").hover()
	end, { desc = "Widgets" })

	vim.keymap.set("n", "<leader>dr", function()
		require("dap").repl.open()
	end, { desc = "Repl" })

	vim.keymap.set("n", "<leader>du", function()
		require("dapui").toggle({})
	end, { desc = "Dap UI" })
end

function M.config()
	local dap = require("dap")

	vim.fn.sign_define("DapBreakpoint", { text = "■", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

	local dapui = require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({})
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close({})
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close({})
	end
end

return M
