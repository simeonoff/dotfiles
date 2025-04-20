local utils = require('utils')

return {
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_dir = utils.root_pattern({ 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }),
  single_file_support = true,
}
