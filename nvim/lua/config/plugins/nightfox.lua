return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	config = function()
		require("nightfox").setup()
		vim.cmd.colorscheme("carbonfox")
	end,
}
