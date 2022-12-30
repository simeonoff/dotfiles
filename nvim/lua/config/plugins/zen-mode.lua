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
				gitsigns = true,
			},
		})

		vim.keymap.set("n", "<leader>zz", function()
			require("zen-mode").toggle()
			vim.wo.wrap = false
		end, { desc = "Toggle Zen mode" })
	end,
}
