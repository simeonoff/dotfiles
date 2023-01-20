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
					signcolumn = "yes",
				},
			},
			plugins = {
        options = {
          enabled = true,
        },
				gitsigns = {
					enabled = true,
				},
			},
			on_open = function()
				vim.o.laststatus = 0
				vim.wo.wrap = false
			end,
			on_close = function()
				vim.o.laststatus = 3
				vim.wo.wrap = true
			end,
		})

		vim.keymap.set("n", "<leader>zz", function()
			require("zen-mode").toggle()
		end, { desc = "Toggle Zen mode" })
	end,
}
