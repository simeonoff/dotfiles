local M = {}

-- Variable to store the colorscheme
local colorscheme = "rose-pine"

-- Function to be called when the colorscheme changes
local function onColorSchemeChange(newScheme)
  local loader = require('lazy.core.loader')
  local config = require('lazy.core.config')

  -- List of plugin names to reload
  local pluginsToReload = {
    'lualine.nvim',
    'rose-pine',
  }

  -- Iterate over the list and reload each plugin
  for _, pluginName in ipairs(pluginsToReload) do
    local plugin = config.plugins[pluginName]
    if plugin then
      loader.reload(plugin)
    else
      vim.notify('Plugin not found: ' .. pluginName)
    end
  end

  vim.cmd.colorscheme(newScheme)
end

-- Table to act as a proxy for the colorscheme variable
M.colorscheme = setmetatable({}, {
  __index = function(_, key)
    if key == 'value' then return colorscheme end
  end,

  __newindex = function(_, key, value)
    if key == 'value' then
      colorscheme = value
      onColorSchemeChange(value)
    end
  end,
})

return M
