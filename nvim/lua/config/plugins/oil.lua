local M = {
	"stevearc/oil.nvim",
	event = "BufReadPre",
	cmd = { "Oil" },
}

M.config = function()
	require("oil").setup({
		columns = { "icon" },
		win_options = {
			signcolumn = "no",
            conceallevel = 3,
		},
		float = {
			max_width = 120,
			padding = 2,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
		},
		view_options = {
			show_hidden = true,
		},
	})
end

return M
