-- Setup
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
		float = {
			enable = false,
		},
		hide_root_folder = true,
	},
	renderer = {
		group_empty = true,
		highlight_git = true,
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = "after",
		},
	},
	filters = {
		dotfiles = false,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
})

-- Mappings
vim.keymap.set("n", "<leader>f", function()
	require("nvim-tree").toggle()
end, { desc = "Toggle File Explorer" })
