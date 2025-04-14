local M = {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
}

M.config = function()
  require('gitsigns').setup({
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 500,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>, <abbrev_sha>',
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      vim.api.nvim_create_user_command('Git', function(opts)
        if opts.args == 'blame' then gs.toggle_current_line_blame() end

        if opts.args == 'status' then require('telescope.builtin').git_status() end

        if opts.args == 'branches' then require('telescope.builtin').git_branches() end

        if opts.args == 'commits' then require('telescope.builtin').git_commits() end

        if opts.args == 'stash' then require('telescope.builtin').git_stash() end

        if opts.args == 'preview' then gs.preview_hunk() end

        if opts.args == 'diff' then gs.diffthis('~') end
      end, { nargs = 1 })

      local function map(mode, l, r, opts)
        opts = opts or {}
        if type(opts) == 'string' then opts = { desc = opts, silent = true } end
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk({ navigation_message = false }) end)
        return '<Ignore>'
      end, { expr = true, desc = 'Next Hunk' })

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk({ navigation_message = false }) end)
        return '<Ignore>'
      end, { expr = true, desc = 'Prev Hunk' })
    end,
  })
end

return M
