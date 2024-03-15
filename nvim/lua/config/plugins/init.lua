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
						icon = "",
						color = "#519aba",
						cterm_color = "74",
						name = "Go",
					},
				},
				override_by_filename = {
					[".editorconfig"] = {
						icon = "",
						guifg = "#fff2f2",
						name = "EditorConfig",
					},
					[".eslintignore"] = {
						icon = "󰱺",
						guifg = "#a074c4",
						ctermfg = "140",
						name = "EslintIgnore",
					},
					[".eslintrc"] = {
						icon = "󰱺",
						guifg = "#a074c4",
						ctermfg = "140",
						name = "Eslintrc",
					},
					[".eslintrc.json"] = {
						icon = "󰱺",
						guifg = "#a074c4",
						ctermfg = "140",
						name = "Eslintrc",
					},
					["tsconfig.json"] = {
						icon = "󰛦",
						color = "#519aba",
						cterm_color = "74",
						name = "TSConfig",
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
			require("ibl").setup()
			vim.cmd.highlight("clear @ibl.scope.underline.1")
			vim.cmd.highlight("link @ibl.scope.underline.1 IndentBlankLineScope")
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
}
