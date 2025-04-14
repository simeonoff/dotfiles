local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    prompt = {
      enabled = false,
      prefix = { { ' ', 'FlashPromptIcon' } },
      win_config = {
        relative = 'editor',
        width = 1, -- when <=1 it's a percentage of the editor width
        height = 1,
        row = -1, -- when negative it's an offset from the bottom
        col = 0, -- when negative it's an offset from the right
        zindex = 1000,
      },
    },
  },
  enabled = true,
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump({
          continue = false,
        })
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function() require('flash').treesitter() end,
      desc = 'Flash Treesitter',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function() require('flash').toggle() end,
      desc = 'Toggle Flash Search',
    },
  },
}

return M
