require('config.set')
require('config.lazy')
require('config.lsp')

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('config.globals')
    require('config.commands')
    require('config.mappings')
  end,
})
