local utils = require('utils')
local root_dir = utils.root_pattern({ 'package.json', '.git' })

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  name = 'somesass_ls',
  cmd = { 'some-sass-language-server', '--stdio' },
  filetypes = { 'scss', 'sass' },
  root_dir = root_dir,
  single_file_support = true,
  settings = {
    somesass = {
      suggestAllFromOpenDocument = true,
    },
  },
  capabilities = capabilities,
}
