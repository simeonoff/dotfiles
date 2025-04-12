local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	commit = "1e1900b",

	dependencies = {
		-- Sources
		{
			"hrsh7th/cmp-buffer",
			commit = "c46b668",
		},
		{
			"hrsh7th/cmp-path",
			commit = "91ff86c",
		},
		"saadparwaiz1/cmp_luasnip",
		{
			"hrsh7th/cmp-nvim-lsp",
			commit = "99290b3",
		},
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

	local has_words_before = function()
		if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
	end

	local cmp_config = {
		enabled = function()
			local files = {
				"oil",
			}

			local buffer = vim.bo.filetype

			for _, f in ipairs(files) do
				if buffer == f then
					return false
				end
			end

			return true
		end,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		view = {
			entries = {
				follow_cursor = true,
			},
		},
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:CmpDocsMenu,FloatBorder:CmpDocsBorder,CursorLine:Visual,Search:None",
			}),
		},
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = false }),

			["<Tab>"] = vim.schedule_wrap(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end),

			["<S-Tab>"] = vim.schedule_wrap(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end),
		}),
		sources = cmp.config.sources({
			-- AI CMP plugins always first
			{ name = "codeium", group_index = 2 },
			-- Other sources
			{ name = "nvim_lsp", group_index = 2 },
			{ name = "path", group_index = 2 },
			{ name = "buffer", group_index = 2 },
			{ name = "luasnip", group_index = 2 },
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = require("kind").cmp_format(),
		},
		experimental = {
			ghost_text = false,
		},
		preselect = cmp.PreselectMode.None,
		completion = { completeopt = "menu,menuone,noselect" },
	}

	cmp.setup(cmp_config)
end

return M
