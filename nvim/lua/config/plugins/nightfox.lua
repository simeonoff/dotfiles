local M = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 999,
}

M.colorscheme = "duskfox"

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
				NeoTreeTitleBar = {
					fg = palette.orange.base,
				},
				FloatBorder = {
					fg = palette.bg2,
					bg = palette.bg2,
				},
				FloatTitle = {
					fg = palette.orange.base,
					bg = palette.bg2,
				},
				NormalFloat = {
					bg = palette.bg2,
				},
				CmpDocsMenu = {
					fg = palette.fg0,
					bg = palette.bg2,
				},
				CmpDocsBorder = {
					fg = palette.bg2,
					bg = palette.bg2,
				},
			},
		},
	})
	vim.cmd.colorscheme(M.colorscheme)
end

return M
