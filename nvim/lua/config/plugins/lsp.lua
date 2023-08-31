local M = {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	event = "BufReadPre",
	cmd = { "Mason" },
}

M.dependencies = {
	-- LSP Support
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		build = function()
			pcall(vim.cmd, "MasonUpdate")
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },

	-- Diagnostics and Formatting
	{ "jose-elias-alvarez/null-ls.nvim" },

	-- JSON schemas
	{ "b0o/SchemaStore.nvim" },
}

M.config = function()
	local lsp = require("lsp-zero")
	pcall(vim.cmd, "MasonUpdate")

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
