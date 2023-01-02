local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
}

M.dependencies = {
	-- Autocompletion
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",

	-- Snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
}

M.config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp_window = require("cmp.utils.window")

	cmp_window.info_ = cmp_window.info
	cmp_window.info = function(self)
		local info = self:info_()
		info.scrollable = false
		return info
	end

	local options = {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
			}),
		},
	}

	cmp.setup(options)
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
