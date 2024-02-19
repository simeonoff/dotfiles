local M = {
	"goolord/alpha-nvim",
	lazy = false,
}

M.config = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	local pickers = require("telescopePickers")

	-- Set header
	dashboard.section.header.val = require("banners").delta_corps_priest

	-- Set menu
	dashboard.section.buttons.val = {
		dashboard.button("<leader>e", "  > New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button(
			"<leader>f",
			"  > Find file",
			":cd $HOME/Projects | lua require('telescopePickers').prettyFilesPicker({ picker = 'find_files' })<CR>"
		),
		dashboard.button("<leader>r", "  > Recent", function()
			pickers.prettyFilesPicker({ picker = "oldfiles" })
		end),
		dashboard.button("<leader>P", "  > Workspaces", ":Telescope workspaces<CR>"),
		dashboard.button("<leader>l", "  > Plugins", ":Lazy<CR>"),
		dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
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
			vim.go.laststatus = 3
			vim.opt.showtabline = 2
		end,
	})
end

return M
