local M = {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "Mason" },
}

M.dependencies = {
	-- LSP Support
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "mattn/emmet-vim" },

	-- JSON schemas
	{ "b0o/SchemaStore.nvim" },
}

M.config = function()
	local lsp = require("lsp-zero")
	local pickers = require("telescopePickers")

	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	require("mason-lspconfig").setup({
		ensure_installed = {
			"angularls",
			"cssls",
			"emmet_ls",
			"eslint",
			"html",
			"jsonls",
			"lua_ls",
			"marksman",
			"stylelint_lsp",
			"svelte",
			"tsserver",
		},
		handlers = {
			lsp.default_setup,
			lua_ls = function()
				require("lspconfig").lua_ls.setup({
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
			jsonls = function()
				require("lspconfig").jsonls.setup({
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				})
			end,
			stylelint_lsp = function()
				require("lspconfig").stylelint_lsp.setup({
					filetypes = { "css", "scss", "sass", "less", "typescriptreact", "javascriptreact" },
					settings = {
						autoFixOnFormat = true,
					},
				})
			end,
			html = function()
				require("lspconfig").html.setup({
					filetypes = { "typescriptreact", "javascriptreact" },
				})
			end,
			emmet_ls = function()
				require("lspconfig").emmet_ls.setup({
					filetypes = { "html", "typescriptreact", "javascriptreact", "svelte" },
				})
			end,
		},
	})

	lsp.preset({
		setup_servers_on_start = true,
		set_lsp_keymaps = true,
		configure_diagnostics = true,
		manage_nvim_cmp = false,
		call_servers = "local",
	})

	lsp.set_sign_icons({
		error = "●",
		warn = "●",
		hint = "●",
		info = "●",
	})

	lsp.on_attach(function(_, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "gK", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<leader>ws", function()
			pickers.prettyWorkspaceSymbols()
		end, opts)
		vim.keymap.set("n", "gr", function()
			pickers.prettyLspReferences()
		end, opts)
		vim.keymap.set("n", "<leader>ds", function()
			pickers.prettyDocumentSymbols()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
	end)

	vim.diagnostic.config({
		virtual_text = false,
	})

	lsp.setup()
end

return M
