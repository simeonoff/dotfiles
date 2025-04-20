local M = {
  'mbbill/undotree',
  event = 'BufReadPre',
  enabled = true,
}

M.config = function()
  vim.g.undotree_WindowLayout = 2
  vim.g.undotree_SplitWidth = 42
  vim.g.undotree_TreeNodeShape = '•'

  vim.keymap.set('n', '<leader>u', function() vim.cmd('UndotreeToggle') end, { desc = 'Toggle undotree' })
end

return M
