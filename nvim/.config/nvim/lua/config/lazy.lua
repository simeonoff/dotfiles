-- bootstrap lazy.nvim from github
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local colorscheme = require('config.ui').colorscheme

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.runtimepath:prepend(lazypath)

local icons = {
  cmd = '󰝶 ',
  config = '󰮎 ',
  event = '󰲼 ',
  ft = '󱨧 ',
  init = '󰮍 ',
  import = '󰳞 ',
  keys = '󱞇 ',
  lazy = '',
  loaded = '󰦕 ',
  not_loaded = '󰦖 ',
  plugin = '󰗐 ',
  runtime = '󰪞 ',
  require = '󰗐 ',
  source = '󰮍 ',
  start = '󰣿 ',
  task = '󰾩 ',
  list = {
    '●',
    '➜',
    '★',
    '‒',
  },
}

local no_icons = {
  cmd = '',
  config = '',
  event = '',
  ft = '',
  init = '',
  import = '',
  keys = '',
  lazy = '',
  loaded = '',
  not_loaded = '',
  plugin = '',
  runtime = '',
  require = '',
  source = '',
  start = '',
  task = '',
  list = {
    '●',
    '➜',
    '★',
    '‒',
  },
}

require('lazy').setup('config.plugins', {
  dev = {
    path = '~/Projects/nvim-plugins/',
    patterns = {},
  },
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { colorscheme.value },
  },
  checker = {
    enabled = true,
  },
  ui = {
    border = 'rounded',
    title = 'Plugins',
    title_align = 'center',
    icons = no_icons,
  },
})

vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<cr>')
