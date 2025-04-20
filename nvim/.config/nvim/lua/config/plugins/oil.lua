local M = {
  'stevearc/oil.nvim',
  event = 'BufReadPre',
  cmd = { 'Oil' },
}

M.config = function()
  require('oil').setup({
    default_file_explorer = false,
    columns = { 'icon' },
    win_options = {
      signcolumn = 'no',
      conceallevel = 3,
    },
    float = {
      max_width = 120,
      padding = 2,
      border = 'rounded',
      win_options = {
        winblend = 0,
      },
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = false,
    },
  })
end

M.keys = {
  {
    '-',
    function() require('oil').open() end,
    mode = 'n',
    desc = 'Open parent directory',
  },
}

return M
