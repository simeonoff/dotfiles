return {
	-- Theme
	"EdenEast/nightfox.nvim",

	-- A UI library for Neovim
	"MunifTanjim/nui.nvim",

	-- A collection of nvim APIs
	"nvim-lua/plenary.nvim",

	-- A collection of icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					go = {
						icon = "󰟓",
						color = "#519aba",
						cterm_color = "74",
						name = "Go",
					},
				},
				override_by_filename = {
					[".gitignore"] = {
						icon = "",
						color = "#41535b",
						ctermfg = "239",
						name = "GitIgnore",
					},
					[".gitattributes"] = {
						icon = "",
						color = "#41535b",
						ctermfg = "239",
						name = "GitAttributes",
					},
					[".gitmodules"] = {
						icon = "",
						color = "#41535b",
						ctermfg = "239",
						name = "GitModules",
					},
					["commit_editmsg"] = {
						icon = "",
						color = "#41535b",
						ctermfg = "239",
						name = "GitCommit",
					},
					[".sassdocrc"] = {
						icon = "",
						color = "#f55385",
						cterm_color = "204",
						name = "Sassdoc",
					},
					[".stylelintrc.json"] = {
						icon = "",
						name = "Stylelint",
					},
					[".browserslistrc"] = {
						icon = "",
						name = "Browserlist",
					},
					["license"] = {
						icon = "󰌆",
						color = "#d0bf41",
						ctermfg = "185",
						name = "License",
					},
				},
			})
		end,
	},

	-- Reload plugins lazily
	"MaximilianLloyd/lazy-reload.nvim",

	-- Show indent lines and highlight scope
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		main = "ibl",
		config = function()
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

			require("ibl").setup({
				indent = {
					char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
				},
				scope = {
					show_start = false,
					show_end = false,
				},
			})
		end,
	},

	-- Fuzzy finding
	"junegunn/fzf.vim",
	{ "junegunn/fzf", build = ":call fzf#install()" },

	-- Provides mappings to easily delete, change targets.
	{ "wellle/targets.vim", event = "BufReadPre" },

	-- Comment stuff out. Use gcc to comment out a line.
	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Handle buffer deletion
	{
		"famiu/bufdelete.nvim",
		event = "BufAdd",
		config = function()
			vim.keymap.set("n", "<leader>bd", require("bufdelete").bufdelete, { desc = "Deletes the current buffer" })
		end,
	},

	-- Tmux naviation plugin
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- A utility function that allows inspecing Lua tables
	{
		"kikito/inspect.lua",
		lazy = false,
	},

	{
		import = "config.plugins.local",
	},
}
