return {
	-- Eyecandy
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "BufReadPre",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = false,
				show_current_context_start = false,
			})
		end,
	},
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/popup.nvim",

	-- A collection of nvim APIs
	"nvim-lua/plenary.nvim",

	-- Fuzzy finding
	"junegunn/fzf.vim",
	{ "junegunn/fzf", build = ":call fzf#install()" },

	-- Project management
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
		end,
	},

	-- Sensible defaults
	"tpope/vim-sensible",

	-- Provides mappings to easily delete, change targets.
	"wellle/targets.vim",

	-- Comment stuff out. Use gcc to comment out a line.
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Make '.' work with plugin motions
	"tpope/vim-repeat",

	-- Read .editorconfig rules.
	"editorconfig/editorconfig-vim",

	-- Handle buffer deletion
	{
		"famiu/bufdelete.nvim",
		config = function()
			vim.keymap.set("n", "<leader>bd", require("bufdelete").bufdelete, { desc = "Deletes the current buffer" })
		end,
	},

	-- Version Control
	{ "tpope/vim-fugitive", cmd = { "Git" }, lazy = true },
	"tpope/vim-rhubarb",

	-- Auto pair characters
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- A pretty list for showing diagnostics, references, etc.
	{ "folke/trouble.nvim", lazy = true },
}
