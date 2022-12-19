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
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})

-- Mappings
vim.keymap.set("n", "<leader>f", function()
	vim.cmd("NvimTreeToggle")
end, { desc = "Toggle File Explorer" })
