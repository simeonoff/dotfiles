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
	local lspconfig = require("lspconfig.configs")
	local pickers = require("telescopePickers")
	local signs = require("kind").diagnostic_signs
	local goto_definition = require("utils").goto_definition

	--Enable (broadcasting) snippet capability for completion
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	require("mason").setup({
		ui = {
			icons = {
				package_installed = "󰦕 ",
				package_pending = "󰦘 ",
				package_uninstalled = "󰦗 ",
			},
		},
	})

	if not lspconfig.somesass_ls then
		lspconfig.somesass_ls = {
			default_config = {
				name = "somesass_ls",
				cmd = {
					"some-sass-language-server",
					"--stdio",
				},
				filetypes = { "scss", "sass" },
				root_dir = function()
					local root_patterns = { ".git", "node_modules" }
					return vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
				end,
				settings = {
					somesass = {
						scanImportedFiles = true,
						scannerDepth = 30,
						scanneerExclude = { "**/.git/**", "**/bower_components/**" },
						suggestAllFromOpenDocument = true,
						suggestFromUseOnly = false,
						suggestFunctionsInStringContextAfterSymbols = " (+-*%",
						suggestionStyle = "all",
					},
				},
			},
		}
	end

	require("lspconfig").somesass_ls.setup({
		capabilities = lsp.get_capabilities(),
	})

	require("mason-lspconfig").setup({
		ensure_installed = {
			"angularls",
			"bashls",
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
							completion = {
								callSnippet = "Replace",
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
			cssls = function()
				require("lspconfig").cssls.setup({
					filetypes = { "css", "scss", "sass", "less", "typescriptreact", "javascriptreact" },
					capabilities = capabilities,
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
			eslint = function()
				require("lspconfig").eslint.setup({
					root_dir = function()
						local root_patterns = { ".git", "node_modules", ".eslintrc.json", ".eslintrc.js" }
						local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
						return root_dir
					end,
				})
			end,
			angularls = function()
				local languageServerPath =
					vim.fn.expand("$HOME/.local/share/nvim/mason/packages/angular-language-server/node_modules")
				local cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					languageServerPath,
					"--ngProbeLocations",
					languageServerPath .. "/@angular/language-server/node_modules",
				}

				require("lspconfig").angularls.setup({
					filetypes = { "typescript", "html" },
					cmd = cmd,
					on_new_config = function(new_config)
						new_config.cmd = cmd
					end,
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

	lsp.set_sign_icons(signs)

	lsp.on_attach(function(_, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "gd", function()
			goto_definition()
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
