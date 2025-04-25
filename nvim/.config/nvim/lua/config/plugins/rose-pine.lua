local M = {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
}

M.config = function()
  local colorscheme = require('config.ui').colorscheme.value

  require('rose-pine').setup({
    styles = {
      transparency = false,
      italic = false,
    },
    enable = {
      legacy_highlights = false,
    },
    highlight_groups = {
      TelescopeBorder = { fg = 'overlay', bg = 'overlay' },
      TelescopeNormal = { fg = 'subtle', bg = 'overlay' },
      TelescopeSelection = { fg = 'text', bg = 'highlight_med' },
      TelescopeSelectionCaret = { fg = 'love', bg = 'highlight_med' },
      TelescopeMultiSelection = { fg = 'text', bg = 'highlight_high' },

      TelescopeTitle = { fg = 'overlay', bg = 'overlay' },
      TelescopePromptTitle = { fg = 'gold', bg = 'surface' },
      TelescopePreviewTitle = { fg = 'overlay', bg = 'overlay' },
      TelescopePreviewNormal = { fg = 'text', bg = 'surface' },

      TelescopePromptNormal = { fg = 'text', bg = 'surface' },
      TelescopePromptBorder = { fg = 'surface', bg = 'surface' },

      CmpDocsMenu = { fg = 'text', bg = 'surface' },
      CmpDocsBorder = { fg = 'surface', bg = 'surface' },

      FloatBorder = { fg = 'surface', bg = 'surface' },
      FloatTitle = { fg = 'gold', bg = 'surface' },
      NormalFloat = { bg = 'surface' },
      WinSeparator = { fg = 'highlight_med' },
      IblIndent = { fg = 'highlight_med' },
      NotifyBackground = { fg = 'text', bg = 'surface' },

      NoiceCmdlinePopup = { bg = 'surface', fg = 'subtle' },
      NoiceCmdlinePopupBorder = { fg = 'surface', bg = 'surface' },
      NoiceCmdlinePopupTitle = { fg = 'gold' },
      NoiceCmdlineIcon = { fg = 'subtle' },

      NoiceLspProgressSpinner = { fg = 'rose' },
      NoiceLspProgressClient = { fg = 'rose', bg = 'overlay' },
      NoiceMini = { fg = 'subtle', bg = 'overlay' },
      NoiceVirtualText = { fg = 'highlight_high' },

      TroubleNormal = { bg = 'base' },
      Comment = { italic = true },
      Keyword = { italic = true },
    },
  })

  vim.cmd.colorscheme(colorscheme)
end

return M
