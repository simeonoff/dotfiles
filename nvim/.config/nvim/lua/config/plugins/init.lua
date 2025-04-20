return {
  -- A UI library for Neovim
  'MunifTanjim/nui.nvim',

  -- A collection of nvim APIs
  'nvim-lua/plenary.nvim',

  -- Reload plugins lazily
  'MaximilianLloyd/lazy-reload.nvim',

  -- Work with markdown tables
  {
    'dhruvasagar/vim-table-mode',
    event = 'BufEnter',
  },

  -- Fuzzy finding
  'junegunn/fzf.vim',
  { 'junegunn/fzf', build = ':call fzf#install()' },

  -- A utility function that allows inspecing Lua tables
  {
    'kikito/inspect.lua',
    lazy = false,
  },

  {
    import = 'config.plugins.local',
  },
}
