local M = {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{
			"<leader>f",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = require("utils").get_root() })
			end,
			desc = "NeoTree",
		},
	},
}
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

M.config = function()
	local neotree = require("neo-tree")

	neotree.setup({
		filesystem = {
			follow_current_file = true,
			hijack_netrw_behavior = "open_current",
		},
		source_selector = {
			winbar = false,
			content_layout = "center",
			separator = { left = " ", right = " " },
		},
		use_popups_for_input = true,
	})
end

return M
