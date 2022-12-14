lua << EOF
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
   },
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'html',
    'css',
    'json',
    'lua',
  },
  indent = {
    enable = true,
  }
})
EOF
