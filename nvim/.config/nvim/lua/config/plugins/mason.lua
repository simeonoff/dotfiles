local M = {
  'williamboman/mason.nvim',
  init = function()
    -- Add the mason bin folder to PATH
    local mason_path = vim.fn.stdpath('data') .. '/mason'
    local path = mason_path .. '/bin'
    vim.env.PATH = path .. ':' .. vim.env.PATH
  end,
  cmd = { 'Mason' },
}

M.dependencies = {
  { 'b0o/SchemaStore.nvim' },
}

M.config = function()
  require('mason').setup({
    ui = {
      icons = {
        package_installed = '󰦕 ',
        package_pending = '󰦘 ',
        package_uninstalled = '󰦗 ',
      },
    },
  })
end

return M
