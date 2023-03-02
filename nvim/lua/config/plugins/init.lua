return {
	-- Eyecandy
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = false,
				show_current_context_start = false,
			})
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		enabled = false,
	},
	"MunifTanjim/nui.nvim",

	-- A collection of nvim APIs
	"nvim-lua/plenary.nvim",

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

	-- Make '.' work with plugin motions
	{ "tpope/vim-repeat", event = "BufReadPre" },

	-- Read .editorconfig rules.
	{ "editorconfig/editorconfig-vim", event = "BufReadPre" },

	-- Handle buffer deletion
	{
		"famiu/bufdelete.nvim",
		event = "BufAdd",
		config = function()
			vim.keymap.set("n", "<leader>bd", require("bufdelete").bufdelete, { desc = "Deletes the current buffer" })
		end,
	},

	-- Version Control
	{ "tpope/vim-fugitive", event = "BufEnter" },

	-- Auto pair characters
	{
		"windwp/nvim-autopairs",
		event = "BufReadPre",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{ "windwp/nvim-ts-autotag", event = "BufReadPre" },

	-- A pretty list for showing diagnostics, references, etc.
	{ "folke/trouble.nvim", cmd = { "Trouble" } },

	{
		"shortcuts/no-neck-pain.nvim",
		cmd = { "NoNeckPain" },
		version = "*",
        enabled = false
	},

	-- Track file changes in the undo tree
	{
		"mbbill/undotree",
		event = "BufReadPre",
        enabled = true
	},
}
