local utils = require('utils')

return {
  cmd = { 'emmet-language-server', '--stdio' },
  filetypes = {
    'astro',
    'css',
    'eruby',
    'html',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'typescriptreact',
    'htmlangular',
    'svelte',
  },
  root_dir = utils.root_pattern({ '.git' }),
  single_file_support = true,
}
