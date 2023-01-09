return {
	"folke/zen-mode.nvim",
	event = "BufAdd",

	config = function()
		require("zen-mode").setup({
			window = {
				width = 120,
				options = {
					number = true,
					relativenumber = true,
				},
			},
			plugins = {
				gitsigns = {
					enabled = true,
				},
			},
			on_open = function()
				vim.go.laststatus = 0
				vim.wo.wrap = false
			end,
			on_close = function()
				vim.go.laststatus = 0
				vim.wo.wrap = true
			end,
		})

		vim.keymap.set("n", "<leader>zz", function()
			require("zen-mode").toggle()
		end, { desc = "Toggle Zen mode" })
	end,
}
