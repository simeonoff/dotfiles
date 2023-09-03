local M = {
	"nvim-neo-tree/neo-tree.nvim",
    enabled = false,
	cmd = "Neotree",
	-- keys = {
	-- 	{
	-- 		"<C-e>",
	-- 		function()
	-- 			require("neo-tree.command").execute({ toggle = true })
	-- 		end,
	-- 		desc = "NeoTree",
	-- 	},
	-- },
}
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

M.config = function()
	local neotree = require("neo-tree")

	neotree.setup({
		default_component_configs = {
			git_status = {
				symbols = {
					added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = "✖", -- this can only be used in the git_status source
					renamed = "", -- this can only be used in the git_status source
					-- Status type
					untracked = "?",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = " ",
				},
			},
		},
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
