local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({ 
    'angularls',
    'tsserver',
    'eslint',
    'stylelint_lsp',
    'cssls',
    'html',
    'emmet_ls',
    'sumneko_lua',
    'svelte',
    'jsonls',
})

local null_ls = require('null-ls')

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sync_formatting = function(client, bufnr)
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            return client.name == "null-ls"
        end
    })
end

local null_opts = lsp.build_options('null-ls', {
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr });
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    sync_formatting(client, buffnr)
                end,
            })
        end
    end,
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "<leader>i", function() sync_formatting(client, bufnr) end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local prettier_filetypes = { 
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'less',
    'html',
    'json',
    'jsonc',
    'yaml',
    'markdown',
    'markdown.mdx',
    'graphql',
    'handlebars',
    'svelte'
}

null_ls.setup({
    on_attach = null_opts.on_attach,
    sources = {
        null_ls.builtins.formatting.stylelint,
        null_ls.builtins.formatting.eslint,
        require('null-ls').builtins.formatting.prettierd.with({filetypes = prettier_filetypes }),

    }
})

lsp.configure('stylelint_lsp', {
    filetypes = { 'css', 'scss', 'sass', 'less', 'typescriptreact', 'javascriptreact' }
})

lsp.configure('html', {
    filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }
})

lsp.configure('emmet_ls', {
    filetypes = { 'html', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'svelte' }
})

lsp.setup()
