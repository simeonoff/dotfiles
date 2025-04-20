local M = {
  'cbochs/grapple.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-web-devicons' },
}

M.opts = {
  scope = 'git_branch',
  icons = true,
  status = false,
}

M.keys = {
  { '<leader>a', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
  { '<c-a-p>', '<cmd>Grapple cycle backward<cr>', desc = 'Go to previous tag' },
  { '<c-a-n>', '<cmd>Grapple cycle forward<cr>', desc = 'Go to next tag' },
}

return M
