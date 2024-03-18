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

local icons = {
	cmd = "󰝶 ",
	config = "󰮎 ",
	event = "󰲼 ",
	ft = "󱨧 ",
	init = "󰮍 ",
	import = "󰳞 ",
	keys = "󱞇 ",
	lazy = "",
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
}

local no_icons = {
	cmd = "",
	config = "",
	event = "",
	ft = "",
	init = "",
	import = "",
	keys = "",
	lazy = "",
	loaded = "",
	not_loaded = "",
	plugin = "",
	runtime = "",
	require = "",
	source = "",
	start = "",
	task = "",
	list = {
		"●",
		"➜",
		"★",
		"‒",
	},
}

require("lazy").setup("config.plugins", {
	dev = {
		path = "~/Projects/nvim-plugins/",
		patterns = {},
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { colorscheme.value },
	},
	checker = {
		enabled = true,
	},
	ui = {
		icons = no_icons,
	},
})

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>")
