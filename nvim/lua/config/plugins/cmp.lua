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
	local luasnip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()

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
			{ name = "nvim_lsp" },
			{ name = "copilot" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "luasnip" },
		}),
		preselect = "item",
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = require("kind").cmp_format(),
		},
		experimental = {
			ghost_text = false,
		},
	}

	cmp.setup(cmp_config)
end

return M
