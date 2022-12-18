local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Visuals
	use("EdenEast/nightfox.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		tag = "nightly",
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = false,
				show_current_context_start = false,
			})
		end,
	})

	-- Utilities
	-- Enable fuzzy search
	use({ "junegunn/fzf", run = ":call fzf#install()" })
	use({ "junegunn/fzf.vim" })
	use({ "nvim-lua/popup.nvim", requires = { { "nvim-lua/plenary.nvim" } } })

	-- The nicest visual explorer
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-fzy-native.nvim")

	-- A collection of language packs (syntax, indent, etc.)
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("leafOfTree/vim-svelte-plugin")
	use("tpope/vim-sensible")

	-- Provides mappings to easily delete, change targets.
	use("wellle/targets.vim")

	-- Short normal mode aliases for commonly used ex commands.
	use("tpope/vim-unimpaired")

	-- Comment stuff out. Use gcc to comment out a line.
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Make '.' work with plugin motions
	use("tpope/vim-repeat")

	-- Read .editorconfig rules.
	use("editorconfig/editorconfig-vim")

	-- Version Control
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Language Server
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Linting, Formatting, and Diagnostics
			{ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- A pretty list for showing diagnostics, references, etc.
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	})

	-- Terminal toggler
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	-- Distraction free coding
	use("folke/zen-mode.nvim")

	-- Project manager
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
