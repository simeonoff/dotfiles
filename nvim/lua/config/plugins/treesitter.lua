return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
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
