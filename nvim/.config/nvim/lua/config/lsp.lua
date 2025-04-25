local utils = require('utils')
local signs = require('kind').diagnostic_signs

-- Do stuff when an LSP is attached to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
  callback = function(args)
    local pickers = require('telescopePickers')
    local opts = { buffer = args.buf, remap = false }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- display inlay hints
    if client and client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    -- enable completion
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(false, client.id, args.buf, { autotrigger = true })
    end

    -- display diagnostics
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
    })

    -- keymaps
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'gK', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>ws', function() pickers.prettyWorkspaceSymbols() end, opts)
    vim.keymap.set('n', 'gr', function() pickers.prettyLspReferences() end, opts)
    vim.keymap.set('n', '<leader>ds', function() pickers.prettyDocumentSymbols() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action({ apply = true }) end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
  end,
})

-- Set sign icons
utils.set_sign_icons(signs)

-- Enable Language Servers
local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
  local server_name = vim.fn.fnamemodify(f, ':t:r')
  table.insert(lsp_configs, server_name)
end

vim.lsp.enable(lsp_configs)
