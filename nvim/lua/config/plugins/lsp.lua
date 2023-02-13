local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format_on_save = false

local prettier_filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"vue",
	"less",
	"html",
	"json",
	"jsonc",
	"yaml",
	"markdown",
	"markdown.mdx",
	"graphql",
	"handlebars",
	"svelte",
}

local format_buffer = function(bufnr, async)
	vim.lsp.buf.format({
		bufnr = bufnr,
		async = async,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end

local M = {
	"VonHeikemen/lsp-zero.nvim",
	event = "BufReadPre",
	cmd = { "Mason" },
}

M.dependencies = {
	-- LSP Support
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Diagnostics and Formatting
	"jose-elias-alvarez/null-ls.nvim",

	-- JSON schemas
	"b0o/SchemaStore.nvim",
}

M.config = function()
	local lsp = require("lsp-zero")
	local null_ls = require("null-ls")

	lsp.set_preferences({
		suggest_lsp_servers = true,
		setup_servers_on_start = true,
		set_lsp_keymaps = true,
		configure_diagnostics = true,
		cmp_capabilities = true,
		manage_nvim_cmp = false,
		call_servers = "local",
		sign_icons = {
			error = "●",
			warn = "●",
			hint = "●",
			info = "●",
		},
	})

	lsp.ensure_installed({
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
	})

	local null_opts = lsp.build_options("null-ls", {
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						if format_on_save then
							format_buffer(bufnr, false)
						end
					end,
				})
			end
		end,
	})

	lsp.on_attach(function(_, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "<leader>i", function()
			format_buffer(bufnr, true)
		end, opts)
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
			vim.cmd("Telescope lsp_dynamic_workspace_symbols")
		end, opts)
		vim.keymap.set("n", "gr", function()
			vim.cmd("Telescope lsp_references")
		end, opts)
		vim.keymap.set("n", "<leader>ds", function()
			vim.cmd("Telescope lsp_document_symbols")
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

	null_ls.setup({
		on_attach = null_opts.on_attach,
		sources = {
			null_ls.builtins.formatting.stylelint,
			null_ls.builtins.formatting.eslint,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier.with({ filetypes = prettier_filetypes }),
		},
	})

	lsp.configure("stylelint_lsp", {
		filetypes = { "css", "scss", "sass", "less", "typescriptreact", "javascriptreact" },
	})

	lsp.configure("html", {
		filetypes = { "typescriptreact", "javascriptreact" },
	})

	lsp.configure("emmet_ls", {
		filetypes = { "html", "typescriptreact", "javascriptreact", "svelte" },
	})

	lsp.configure("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})

	lsp.configure("jsonls", {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	})

	lsp.setup()
end

return M
