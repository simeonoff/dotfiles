local M = {
  'augmentcode/augment.vim',
  event = 'VeryLazy',
  enabled = false,
}

M.keys = {
  { '<leader>aa', '<cmd>Augment chat<cr>', desc = 'Augment Chat' },
  { '<leader>at', '<cmd>Augment chat-toggle<cr>', desc = 'Augment Chat Toggle' },
  { '<leader>ac', '<cmd>Augment apply-changes<cr>', desc = 'Apply Changes' },
}

M.init = function()
  vim.g.augment_workspace_folders = {
    '/Users/SSimeonov/dotfiles',
    '/Users/SSimeonov/Projects/igniteui-angular',
    '/Users/SSimeonov/Projects/igniteui-theming',
    '/Users/SSimeonov/Projects/igniteui-webcomponents',
    '/Users/SSimeonov/Projects/nvim-plugins',
    '/Users/SSimeonov/Projects/igniteui-sassdoc-theme',
    '/Users/SSimeonov/Projects/igniteui-sassdoc-theme-new',
    '/Users/SSimeonov/Projects/sassdoc-plugin-localization',
    '/Users/SSimeonov/Projects/typedoc-plugin-localization',
  }
end

return M
