local M = {
  'mfussenegger/nvim-lint',
  event = 'BufReadPre',
}

M.config = function()
  local lint = require('lint')

  -- Register linters
  lint.linters_by_ft = {
    go = {},
  }

  -- Listen for file writes and lint
  vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'BufWritePost' }, {
    callback = function() lint.try_lint() end,
  })
end

return M
