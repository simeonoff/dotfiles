local telescopePickers = require('telescopePickers')

local M = {
  'nvim-telescope/telescope.nvim',
  lazy = false,

  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-lua/plenary.nvim' },
  },
}

M.recent_files = function()
  local utils = require('utils')

  telescopePickers.prettyFilesPicker({
    picker = 'oldfiles',
    options = { prompt_title = 'Recent Files', cwd = utils.get_root(), cwd_only = true },
  })
end

M.project_files = function()
  local opts = {}

  if vim.loop.fs_stat('.git') then
    opts.show_untracked = true
    telescopePickers.prettyFilesPicker({ picker = 'git_files', options = opts })
  else
    local client = vim.lsp.get_clients()[1]
    if client then opts.cwd = client.config.root_dir end
    telescopePickers.prettyFilesPicker({ picker = 'find_files', options = opts })
  end
end

M.config_files = function()
  telescopePickers.prettyFilesPicker({
    picker = 'find_files',
    options = { prompt_title = 'Config Files', cwd = vim.fn.stdpath('config'), cwd_only = true },
  })
end

M.find_text = function() telescopePickers.prettyGrepPicker({ picker = 'live_grep' }) end

M.grapple_pick = function() telescopePickers.prettyGrapplePicker() end

M.config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local builtin = require('telescope.builtin')
  local trouble = require('trouble.sources.telescope')

  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
      prompt_prefix = '     ',
      selection_caret = '  ',
      entry_prefix = '  ',
      multi_icon = ' + ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        -- width = 0.75,
        -- prompt_position  "bottom",
        -- preview_cutoff = 90,
        horizontal = {
          mirror = false,
        },
        vertical = {
          -- width = 0.5,
          mirror = true,
          prompt_position = 'top',
        },
      },
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      file_ignore_patterns = { 'node_modules' },
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,

      mappings = {
        i = {
          ['<C-q>'] = actions.send_to_qflist,
          ['<C-n>'] = false,
          ['<C-p>'] = false,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-t>'] = trouble.open,
          ['<esc>'] = actions.close,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  })

  -- Custom commands
  vim.api.nvim_create_user_command('FindFiles', M.project_files, {})
  vim.api.nvim_create_user_command('RecentFiles', M.recent_files, {})
  vim.api.nvim_create_user_command('FindText', M.find_text, {})
  vim.api.nvim_create_user_command('GrapplePick', M.grapple_pick, {})
  vim.api.nvim_create_user_command('ConfigFiles', M.config_files, {})

  -- Mappings
  vim.keymap.set('n', '<leader>f', M.project_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>r', M.recent_files, { desc = 'Recent files' })
  vim.keymap.set('n', '<leader>/', M.find_text, { desc = 'Global search' })
  vim.keymap.set('n', '<leader><leader>', M.grapple_pick, { desc = 'Pick from Grapple' })
  vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Broser git branches in current project' })
  vim.keymap.set('n', "<leader>'", builtin.resume, { desc = 'Resume the last opened telescope prompt' })
end

return M
