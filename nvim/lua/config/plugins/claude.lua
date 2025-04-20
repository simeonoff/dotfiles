local M = {
  'greggh/claude-code.nvim',
  event = 'VeryLazy',
  command = 'ClaudeCode',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for git operations
  },
  keys = {
    { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Claude Code' },
  },
}

M.config = function()
  require('claude-code').setup({
    window = {
      split_ratio = 0.3,
      position = 'vertical',
    },
  })
end

return M
