local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}

M.config = function()
	local harpoon = require("harpoon")
	local pickers = require("telescopePickers")

	harpoon:setup({
		default = {
			sync_on_ui_close = true,
		}
	})

	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():append()
	end, { desc = "Add file to harpoon" })

	vim.keymap.set("n", "<leader><leader>", function()
		-- Use telescope to show list of marks
		pickers.prettyHarpoonPicker(harpoon:list())

		-- Use harpoon UI to show list of marks
		-- harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Toggle harpoon menu" })

	vim.keymap.set("n", "<leader>j", function()
		harpoon:list():prev()
	end, { desc = "Navigate to previous harpoon mark" })

	vim.keymap.set("n", "<leader>k", function()
		harpoon:list():next()
	end, { desc = "Navigate to next harpoon mark" })
end

return M
