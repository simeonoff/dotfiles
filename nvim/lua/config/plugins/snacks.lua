return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
      scope = {
        enabled = false,
      },
    },
    input = { enabled = true },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    {
      '<leader>bd',
      function() Snacks.bufdelete() end,
      mode = 'n',
      desc = 'Delete the current buffer',
    },
    {
      '<leader>bo',
      function() Snacks.bufdelete.other() end,
      mode = 'n',
      desc = 'Deletes all buffers except the current one',
    },
  },
  init = function()
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    vim.print = _G.dd

    -- Rename files
    vim.api.nvim_create_autocmd('User', {
      pattern = 'OilActionsPost',
      callback = function(event)
        if event.data.actions.type == 'move' then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
}
