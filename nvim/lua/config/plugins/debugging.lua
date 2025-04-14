local M = {
  'rcarriga/nvim-dap-ui',

  dependencies = {
    {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
    },
  },
}

function M.init()
  vim.fn.sign_define('DapBreakpoint', {
    text = '■',
    texthl = 'DiagnosticSignError',
    linehl = '',
    numhl = '',
  })

  vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })

  vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Continue' })

  vim.keymap.set('n', '<leader>do', function() require('dap').step_over() end, { desc = 'Step Over' })

  vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'Step Into' })

  vim.keymap.set('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = 'Widgets' })

  vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Repl' })

  vim.keymap.set('n', '<leader>du', function() require('dapui').toggle({}) end, { desc = 'Dap UI' })

  vim.keymap.set('n', '<leader>dgt', function() require('dap-go').debug_test() end, { desc = 'Debug Go Test' })
end

function M.config()
  local dap, dapui, dapgo = require('dap'), require('dapui'), require('dap-go')

  --- @diagnostic disable: missing-fields
  dapui.setup({
    layouts = {
      {
        -- You can change the order of elements in the sidebar
        elements = {
          -- Provide IDs as strings or tables with "id" and "size" keys
          {
            id = 'scopes',
            size = 0.25, -- Can be float or integer > 1
          },
          { id = 'breakpoints', size = 0.25 },
          { id = 'stacks', size = 0.25 },
          { id = 'watches', size = 0.25 },
        },
        size = 40,
        position = 'right', -- Can be "left" or "right"
      },
      {
        elements = {
          'repl',
        },
        size = 10,
        position = 'bottom', -- Can be "bottom" or "top"
      },
    },
  })
  dapgo.setup()

  dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
  dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
  dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
end

return M
