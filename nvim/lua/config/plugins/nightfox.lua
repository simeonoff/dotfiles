local M = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 999,
	enable = true,
}

M.colorscheme = "nordfox"

M.config = function()
	local palette = require("nightfox.palette").load(M.colorscheme)

	require("nightfox").setup({
		groups = {
			all = {
				TelescopeNormal = {
					bg = palette.bg2,
					fg = palette.fg0,
				},
				TelescopeBorder = {
					bg = palette.bg2,
					fg = palette.bg2,
				},
				TelescopePromptNormal = {
					bg = palette.bg3,
				},
				TelescopePromptBorder = {
					bg = palette.bg3,
					fg = palette.bg3,
				},
				TelescopePromptTitle = {
					bg = palette.bg3,
					fg = palette.orange.base,
				},
				TelescopePreviewTitle = {
					bg = palette.bg2,
					fg = palette.bg2,
				},
				TelescopeResultsTitle = {
					bg = palette.bg2,
					fg = palette.bg2,
				},
				NeoTreeWinSeparator = {
					bg = palette.bg0,
					fg = palette.bg0,
				},
			},
		},
	})
	vim.cmd.colorscheme(M.colorscheme)
end

return M
