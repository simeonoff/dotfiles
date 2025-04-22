return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  enabled = true,
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = '<C-y>',
        accept_word = false,
        accept_line = false,
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = false,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function() vim.b.copilot_suggestion_hidden = true end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuClose',
      callback = function() vim.b.copilot_suggestion_hidden = false end,
    })
  end,
}
