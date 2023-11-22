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
	local cmp = require("cmp")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local luasnip = require("luasnip")

	local cmp_config = {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:CmpDocsMenu,FloatBorder:CmpDocsBorder,CursorLine:Visual,Search:None",
			}),
		},
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = false }),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "copilot", group_index = 2 },
			{ name = "luasnip", group_index = 2 },
			{ name = "nvim_lsp", group_index = 2 },
			{ name = "buffer", group_index = 2 },
			{ name = "path", group_index = 2 },
		}),
		preselect = "item",
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = require("kind").cmp_format(),
		},
	}

	cmp.setup(cmp_config)
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
