local M = {
	"stevearc/oil.nvim",
	event = "BufReadPre",
	cmd = { "Oil" },
}

M.config = function()
	require("oil").setup({
		columns = {'icon'},
		float = {
            max_width = 120,
			padding = 2,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
		},
	})
end

return M
