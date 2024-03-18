local M = {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
}

M.config = function()
	require("rose-pine").setup({
		styles = {
			transparency = true,
		},
		enable = {
			legacy_highlights = false,
		},
		highlight_groups = {
			TelescopeBorder = { fg = "overlay", bg = "overlay" },
			TelescopeNormal = { fg = "subtle", bg = "overlay" },
			TelescopeSelection = { fg = "text", bg = "highlight_med" },
			TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
			TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

			TelescopeTitle = { fg = "overlay", bg = "overlay" },
			TelescopePromptTitle = { fg = "gold", bg = "surface" },
			TelescopePreviewTitle = { fg = "overlay", bg = "overlay" },
			TelescopePreviewNormal = { fg = "text", bg = "surface" },

			TelescopePromptNormal = { fg = "text", bg = "surface" },
			TelescopePromptBorder = { fg = "surface", bg = "surface" },

			CmpDocsMenu = { fg = "text", bg = "surface" },
			CmpDocsBorder = { fg = "surface", bg = "surface" },

			FloatBorder = { fg = "surface", bg = "surface" },
			FloatTitle = { fg = "gold", bg = "surface" },
			NormalFloat = { bg = "surface" },
			WinSeparator = { fg = "highlight_med" },
			IblIndent = { fg = "highlight_med" },
		},
	})
	vim.cmd.colorscheme("rose-pine")
end

return M
