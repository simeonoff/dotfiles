local M = {
	"goolord/alpha-nvim",
	lazy = false,
}

-- vim:ft=lua
M.config = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	-- Set header
	dashboard.section.header.val = require("banners").hydra

	-- Set menu
	dashboard.section.buttons.val = {
		dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("f", "  > Find file", ":cd $HOME/Projects | Telescope find_files<CR>"),
		dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
		dashboard.button("p", "  > Projects", ":Telescope projects<CR>"),
		dashboard.button("l", "  > Update Plugins", ":Lazy sync<CR>"),
		dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
	}

	-- Send config to alpha
	alpha.setup(dashboard.opts)

	vim.api.nvim_create_autocmd("User", {
		pattern = "AlphaReady",
		desc = "disable status and tabline for alpha",
		callback = function()
			vim.go.laststatus = 0
			vim.opt.showtabline = 0
		end,
	})
	vim.api.nvim_create_autocmd("BufUnload", {
		buffer = 0,
		desc = "enable status and tabline after alpha",
		callback = function()
			vim.opt.showtabline = 2
		end,
	})
end

return M
