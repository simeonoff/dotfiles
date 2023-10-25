local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",

	dependencies = {
		-- Sources
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
}

M.config = function()
	local lsp = require("lsp-zero")
	local luasnip = require("luasnip")
	local cmp = require("cmp")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")

	local cmp_config = lsp.defaults.cmp_config({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = {
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		},
		sources = {
            { name = "copilot", group_index = 2 },
			{ name = "luasnip", group_index = 2 },
			{ name = "nvim_lsp", group_index = 2 },
			{ name = "buffer", group_index = 2 },
			{ name = "path", group_index = 2 },
		},
		preselect = "item",
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = require("kind").cmp_format(),
		},
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:CmpDocsMenu,FloatBorder:CmpDocsBorder,CursorLine:Visual,Search:None",
			}),
		},
	})

	cmp.setup(cmp_config)
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
