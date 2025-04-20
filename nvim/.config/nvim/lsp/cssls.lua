local utils = require('utils')
local root_dir = utils.root_pattern({ 'package.json', '.git' })

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'less', 'typescriptreact', 'javascriptreact' },
  init_options = {
    provideFormatter = true,
  },
  root_dir = root_dir,
  single_file_support = true,
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
  capabilities = capabilities,
}
