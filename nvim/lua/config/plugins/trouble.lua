-- A pretty list for showing diagnostics, references, etc.
local M = {
  'folke/trouble.nvim',
  branch = 'main',
  event = 'BufReadPre',
}

M.config = function()
  local trouble = require('trouble')
  local kind_icons = require('kind').icons

  trouble.setup({
    icons = {
      indent = {
        fold_closed = '+ ',
        fold_open = '- ',
      },
      kinds = kind_icons,
    },
  })

  vim.keymap.set(
    'n',
    '<leader>tt',
    function() trouble.toggle({ mode = 'diagnostics' }) end,
    { desc = 'Toggle Trouble' }
  )

  vim.keymap.set(
    'n',
    '<leader>tn',
    function()
      trouble.next({
        skip_groups = true,
        jump = true,
      })
    end,
    { desc = 'Go to next trouble' }
  )

  vim.keymap.set(
    'n',
    '<leader>tp',
    function()
      trouble.previous({
        skip_groups = true,
        jump = true,
      })
    end,
    { desc = 'Go to previous trouble' }
  )
end

return M
