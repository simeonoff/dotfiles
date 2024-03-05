-- bootstrap lazy.nvim from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local colorscheme = require("config.ui").colorscheme

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"git@github.com:folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("config.plugins", {
	dev = {
		path = "~/Projects",
		patterns = {},
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { colorscheme },
	},
	checker = {
		enabled = true,
	},
	ui = {
		icons = {
			cmd = "󰝶 ",
			config = "󰮎 ",
			event = "󰲼 ",
			ft = "󱨧 ",
			init = "󰮍 ",
			import = "󰳞 ",
			keys = "󱞇 ",
			lazy = "󰒲 ",
			loaded = "󰦕 ",
			not_loaded = "󰦖 ",
			plugin = "󰗐 ",
			runtime = "󰪞 ",
			require = "󰗐 ",
			source = "󰮍 ",
			start = "󰣿 ",
			task = "󰾩 ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
})

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>")
