return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	enabled = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ignore_install = {
				"help"
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				-- disable = { "typescript" },
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
			ensure_installed = {
				"bash",
				"help",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"json",
				"jsonc",
				"jsdoc",
				"regex",
				"lua",
				"svelte",
				"yaml",
                "help",
				"markdown",
				"markdown_inline",
				"vim",
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
