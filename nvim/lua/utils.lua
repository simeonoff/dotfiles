local M = {}

local iswin = vim.uv.os_uname().version:match('Windows')

-- Open the location under the cursor
M.open_location = function()
  local loc = vim.fn.expand('<cfile>')
  local executable = nil

  if vim.fn.has('mac') == 1 then
    executable = 'open'
  elseif vim.fn.has('unix') == 1 then
    executable = 'xdg-open'
  end

  if executable then
    vim.loop.spawn(executable, {
      args = { loc },
    })
  else
    print('Error: opening locations is not supported on this OS')
  end
end

M.get_root = function()
  local path = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0)) or vim.loop.cwd()

  -- Utilize early return to avoid deep nesting
  if path == '' then return vim.loop.cwd() end

  for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
    local workspace_folders = client.config.workspace_folders or {}
    local root_dirs = vim.tbl_map(function(ws) return vim.uri_to_fname(ws.uri) end, workspace_folders)
    if client.config.root_dir then table.insert(root_dirs, client.config.root_dir) end

    for _, p in ipairs(root_dirs) do
      local r = vim.loop.fs_realpath(p)
      if r and path and path:find(r, 1, true) then
        return r -- Return immediately upon finding the first matching root
      end
    end
  end

  -- Fallback to searching for a .git directory or using cwd
  local root = vim.fs.find({ '.git' }, { path = path, upward = true })[1]
  return root and vim.fs.dirname(root) or vim.loop.cwd()
end

-- Returns the visual selection text the cursor
local get_visual_selection = function()
  local supported = pcall(vim.fn.getregion, vim.fn.getpos('.'), vim.fn.getpos('v'), { mode = vim.fn.mode() })

  if supported then
    return vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { mode = vim.fn.mode() })
  else
    return { vim.fn.expand('<cword>') }
  end
end

-- Rename word under cursor or visual selection
M.rename_cword = function()
  local current_word

  if vim.fn.mode() == 'v' then
    current_word = table.concat(get_visual_selection())
  else
    current_word = vim.fn.expand('<cword>')
  end

  -- Use input the new name
  vim.ui.input({
    prompt = 'Rename: ',
    default = current_word,
  }, function(new_name)
    -- Check if the new name is not nil or the same as the current word
    if new_name and new_name ~= current_word then
      -- Escape special characters
      local escaped_word = vim.fn.escape(current_word, "\\/.*'$^~[]")
      -- Form the pattern, considering very nomagic option
      local pattern = '\\V' .. escaped_word
      -- Perform the replacement
      local cmd = ':%s/' .. pattern .. '/' .. vim.fn.escape(new_name, '/') .. '/g'
      vim.cmd(cmd)
    end
  end)
end

-- Navigate to the next tmux pane or Neovim window
M.navigate = function(direction)
  local current_win = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. direction)

  -- Check if we are in a tmux session and if the current window is at the edge
  if current_win == vim.api.nvim_get_current_win() and vim.env.TMUX then
    local tmux_commands = {
      h = 'select-pane -L',
      j = 'select-pane -D',
      k = 'select-pane -U',
      l = 'select-pane -R',
    }

    local zoom_command = 'tmux display-message -p "#{window_zoomed_flag}"'
    local is_zoomed = vim.fn.trim(vim.fn.system(zoom_command))

    if is_zoomed == '0' then vim.fn.system('tmux ' .. tmux_commands[direction]) end
  end
end

-- Find the root directory of the project by searching for specific markers
M.root_pattern = function(markers, start_path)
  local path = start_path or vim.fn.getcwd()
  local root_file = vim.fs.find(markers, { path = path, upward = true })[1]
  return root_file and vim.fs.dirname(root_file) or path
end

-- Sets the sign icons for diagnostics
M.set_sign_icons = function(opts)
  local ds = vim.diagnostic.severity
  local levels = {
    [ds.ERROR] = 'error',
    [ds.WARN] = 'warn',
    [ds.INFO] = 'info',
    [ds.HINT] = 'hint',
  }

  local text = {}

  for i, l in pairs(levels) do
    if type(opts[l]) == 'string' then text[i] = opts[l] end
  end

  vim.diagnostic.config({ signs = { text = text } })

  local sign = function(args)
    if opts[args.name] == nil then return end

    vim.fn.sign_define(args.hl, {
      texthl = args.hl,
      text = opts[args.name],
      numhl = '',
    })
  end

  sign({ name = 'error', hl = 'DiagnosticSignError' })
  sign({ name = 'warn', hl = 'DiagnosticSignWarn' })
  sign({ name = 'hint', hl = 'DiagnosticSignHint' })
  sign({ name = 'info', hl = 'DiagnosticSignInfo' })
end

-- Insert package.json to config_files if it contains the specified field
M.insert_package_json = function(config_files, field, fname)
  local path = vim.fn.fnamemodify(fname, ':h')
  local root_with_package = vim.fs.dirname(vim.fs.find('package.json', { path = path, upward = true })[1])

  if root_with_package then
    -- only add package.json if it contains field parameter
    local path_sep = iswin and '\\' or '/'
    for line in io.lines(root_with_package .. path_sep .. 'package.json') do
      if line:find(field) then
        config_files[#config_files + 1] = 'package.json'
        break
      end
    end
  end
  return config_files
end

return M
