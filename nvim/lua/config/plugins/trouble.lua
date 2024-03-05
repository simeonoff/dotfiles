-- A pretty list for showing diagnostics, references, etc.
local M = {
	"folke/trouble.nvim",
	event = "BufReadPre",
}

M.config = function()
	local trouble = require("trouble")

	trouble.setup({
		auto_open = false,
		indent_lines = false,
		use_diagnostic_signs = true,
		padding = false,
		icons = false,
		fold_open = " - ", -- icon used for open folds
		fold_closed = " + ", -- icon used for closed folds
	})

	vim.keymap.set("n", "<leader>tt", function()
		trouble.toggle()
	end, { desc = "Toggle Trouble" })

	vim.keymap.set("n", "<leader>tn", function()
		trouble.next({
			skip_groups = true,
			jump = true,
		})
	end, { desc = "Go to next trouble" })

	vim.keymap.set("n", "<leader>tp", function()
		trouble.previous({
			skip_groups = true,
			jump = true,
		})
	end, { desc = "Go to previous trouble" })
end

return M
