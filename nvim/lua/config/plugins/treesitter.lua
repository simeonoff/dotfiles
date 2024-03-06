return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	enabled = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		local treesitter = require("nvim-treesitter.configs")

		-- Use a fork of the tree-sitter-scss parser for better highlighting
		local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
		parser_configs.scss.install_info.url = "https://github.com/savetheclocktower/tree-sitter-scss"
		parser_configs.scss.install_info.revision = "97a48700a2cd8bf851c4b8edc29a8a8631c419a0"

		treesitter.setup({
			ignore_install = {
				"help",
			},
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				-- disable = { "scss" },
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select the outer part of a function/method" },
						["if"] = { query = "@function.inner", desc = "Select the inner part of a function/method" },
						["ac"] = { query = "@class.outer", desc = "Select the outer part of a class" },
						["ic"] = { query = "@class.inner", desc = "Select the inner part of a class" },
						["a="] = { query = "@assignment.outer", desc = "Select the outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select the inner part of an assignment" },
						-- ["l="] = { query = "@assignment.lhs", desc = "Select the lhs of an assignment" },
						-- ["r="] = { query = "@assignment.rhs", desc = "Select the lhs of an assignment" },
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
				enable = false,
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
