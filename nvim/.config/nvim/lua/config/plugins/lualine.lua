---@diagnostic disable: undefined-field
local M = {
  'nvim-lualine/lualine.nvim',
  event = 'ColorScheme',
}

M.config = function()
  local lualine = require('lualine')
  local List = require('plenary.collections.py_list')
  local plugin_checker = require('lazy.manage.checker')
  local palette = require('rose-pine.palette')
  local diagnostic_signs = require('kind').diagnostic_signs
  local diff_signs = require('kind').diff_icons

  local window_width_limit = 100
  local branch_icon = '󰘬 '
  local gstatus = { ahead = 0, behind = 0 }

  local disabled_filetypes = List({
    'TelescopePrompt',
    'lazy',
    'oil',
    'lazygit',
    'Trouble',
    'trouble',
    'lspinfo',
    'mason',
    'snacks_dashboard'
  })

  local lsp_kind = {
    tsserver = 'TSServer',
    eslint = 'ESLint',
    angularls = 'Angular LS',
    cssls = 'CSS LS',
    emmet_ls = 'Emmet',
    html = 'HTML',
    jsonls = 'JSON',
    lua_ls = 'Lua LS',
    marksman = 'Marksman',
    stylelint_lsp = 'Stylelint',
    svelte = 'Svelte',
    bashls = 'Bash',
  }

  -- Get info from git about ahead/behind commits in branch
  local function update_gstatus()
    local Job = require('plenary.job')
    Job:new({
      command = 'git',
      args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
      on_exit = function(job, _)
        local res = job:result()[1]
        if type(res) ~= 'string' then
          gstatus = { ahead = 0, behind = 0 }
          return
        end
        local ok, ahead, behind = pcall(string.match, res, '(%d+)%s*(%d+)')
        if not ok then
          ahead, behind = 0, 0
        end
        gstatus = { ahead = ahead, behind = behind }
      end,
    }):start()
  end

  -- Start a timer to check for git status updates
  if _G.Gstatus_timer == nil then
    _G.Gstatus_timer = vim.loop.new_timer()
  else
    _G.Gstatus_timer:stop()
  end
  _G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

  local function show_macro_recording()
    local base = ''
    local recording_register = vim.fn.reg_recording()
    if recording_register == base then
      return base
    else
      return 'Recording @' .. recording_register
    end
  end

  local conditions = {
    buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
    hide_in_width = function() return vim.o.columns > window_width_limit end,
    hide_in_disabled_ft = function()
      local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
      return not disabled_filetypes:contains(buf_ft)
    end,
  }

  local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end

  local mode = {
    'mode',
    separator = { right = '', left = '' },
  }

  local branch = {
    'b:gitsigns_head',
    icon = branch_icon,
    separator = { right = '', left = '' },
  }

  local status = {
    function() return ' ' .. gstatus.behind .. '  ' .. gstatus.ahead end,
    cond = function()
      local gitsigns = vim.b.gitsigns_status_dict
      local shouldShow = gitsigns and (tonumber(gstatus.behind) > 0 or tonumber(gstatus.ahead) > 0)
      return shouldShow
    end,
    padding = { left = 0, right = 1 },
    separator = { right = '', left = '' },
  }

  local diff = {
    'diff',
    source = diff_source,
    symbols = {
      added = diff_signs.added,
      modified = diff_signs.modified,
      removed = diff_signs.removed,
    },
    padding = { left = 2, right = 1 },
    cond = nil,
  }

  local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
      error = diagnostic_signs.error .. ' ',
      warn = diagnostic_signs.warn .. ' ',
      info = diagnostic_signs.info .. ' ',
      hint = diagnostic_signs.hint .. ' ',
    },
  }

  local treesitter = {
    function() return ' ' end,
    padding = { left = 1, right = 1 },
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and palette.foam or palette.love }
    end,
    cond = conditions.hide_in_disabled_ft,
  }

  local location = {
    'location',
    color = {
      fg = palette.muted,
    },
  }

  local spaces = {
    function()
      local shiftwidth = vim.api.nvim_get_option_value('shiftwidth', { buf = 0 })
      return 'Spaces: ' .. shiftwidth
    end,
    color = {
      fg = palette.muted,
    },
  }

  local encoding = {
    'o:encoding',
    fmt = string.upper,
    color = {
      fg = palette.muted,
    },
    cond = conditions.hide_in_width,
  }

  local filetype = {
    'filetype',
    icon_only = true,
    separator = { right = '', left = '' },
    padding = { left = 1, right = 0 },
    cond = conditions.hide_in_disabled_ft,
  }

  local filename = {
    'filename',
    padding = { left = 1, right = 0 },
    file_status = true, -- displays file status (readonly status, modified status)
    newfile_status = false,
    path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    symbols = {
      modified = '●',
      readonly = '',
      unnamed = '',
    },
    separator = { right = '', left = '' },
    cond = conditions.hide_in_disabled_ft,
  }

  local lsp = {
    function() return ' ' end,
    on_click = function() vim.cmd('checkhealth lsp') end,
    padding = { left = 1, right = 2 },
    color = function()
      local clients = vim.lsp.get_clients()
      local c = {}

      for _, client in pairs(clients) do
        table.insert(c, lsp_kind[client.name] or client.name)
      end

      return { fg = #c > 0 and palette.foam or palette.love }
    end,
    cond = conditions.hide_in_disabled_ft,
  }

  local plugins = {
    function() return '󰦗  Updates' end,
    cond = function() return #plugin_checker.updated > 0 end,
    on_click = function() vim.cmd('Lazy') end,
    color = {
      fg = palette.rose,
      bg = palette.highlight_med,
    },
    padding = { left = 1, right = 0 },
    separator = { right = '', left = '' },
  }

  local macros = {
    'macro-recording',
    fmt = show_macro_recording,
    color = {
      fg = palette.base,
      bg = palette.love,
    },
    separator = { right = '', left = '' },
  }

  lualine.setup({
    options = {
      theme = 'auto',
      icons_enabled = true,
      component_separators = '',
      section_separators = { left = '', right = '' },
      ignore_focus = {},
    },
    sections = {
      lualine_a = {
        mode,
        plugins,
      },
      lualine_b = {
        filetype,
        filename,
      },
      lualine_c = {},
      lualine_x = {
        macros,
        location,
        spaces,
        encoding,
        diagnostics,
        treesitter,
        lsp,
      },
      lualine_y = {},
      lualine_z = {
        status,
        branch,
      },
    },
    inactive_sections = {
      lualine_a = {
        mode,
        plugins,
      },
      lualine_b = {
        filetype,
        filename,
      },
      lualine_c = {},
      lualine_x = {
        spaces,
        encoding,
      },
      lualine_y = {},
      lualine_z = {
        status,
        branch,
      },
    },
    winbar = {},
    tabline = {},
    extensions = {
      'man',
      'lazy',
      'mason',
      'trouble',
      'nvim-dap-ui',
      'quickfix',
      'oil',
    },
  })
end

return M
