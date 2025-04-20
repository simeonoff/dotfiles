local M = {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  enabled = false,
}

M.config = function()
  local colorscheme = require('config.ui').colorscheme.value
  local palette = require('nightfox.palette').load(colorscheme)

  require('nightfox').setup({
    options = {
      styles = {
        comments = 'italic',
        keywords = 'bold',
        types = 'italic,bold',
      },
    },
    groups = {
      all = {
        TelescopeNormal = {
          bg = palette.bg2,
          fg = palette.fg0,
        },
        TelescopeBorder = {
          bg = palette.bg2,
          fg = palette.bg2,
        },
        TelescopePromptNormal = {
          bg = palette.bg3,
        },
        TelescopePromptBorder = {
          bg = palette.bg3,
          fg = palette.bg3,
        },
        TelescopePromptTitle = {
          bg = palette.bg3,
          fg = palette.orange.base,
        },
        TelescopePreviewTitle = {
          bg = palette.bg2,
          fg = palette.bg2,
        },
        TelescopePreviewNormal = {
          bg = palette.bg1,
        },
        TelescopeResultsTitle = {
          bg = palette.bg2,
          fg = palette.bg2,
        },
        NeoTreeWinSeparator = {
          bg = palette.bg0,
          fg = palette.bg0,
        },
        NeoTreeTitleBar = {
          fg = palette.orange.base,
        },
        FloatBorder = {
          fg = palette.bg2,
          bg = palette.bg2,
        },
        FloatTitle = {
          fg = palette.orange.base,
          bg = palette.bg2,
        },
        NormalFloat = {
          bg = palette.bg2,
        },
        CmpDocsMenu = {
          fg = palette.fg0,
          bg = palette.bg2,
        },
        CmpDocsBorder = {
          fg = palette.bg2,
          bg = palette.bg2,
        },
        NotifyINFOBorder = {
          fg = palette.bg2,
          bg = palette.bg2,
        },
        NotifyINFOBody = {
          bg = palette.bg2,
        },
        NotifyINFOTitle = {
          fg = palette.green.base,
          bg = palette.bg2,
        },
        NotifyWARNBorder = {
          fg = palette.bg2,
          bg = palette.bg2,
        },
        NotifyWARNBody = {
          bg = palette.bg2,
        },
        NotifyWARNTitle = {
          fg = palette.orange.base,
          bg = palette.bg2,
        },
        NotifyERRORBorder = {
          fg = palette.bg2,
          bg = palette.bg2,
        },
        NotifyERRORBody = {
          bg = palette.bg2,
        },
        NotifyERRORTitle = {
          fg = palette.red.base,
          bg = palette.bg2,
        },
        NotifyTRACEBorder = {
          fg = palette.bg2,
          bg = palette.bg2,
        },
        NotifyTRACEBody = {
          bg = palette.bg2,
        },
        NotifyTRACETitle = {
          fg = palette.magenta.base,
          bg = palette.bg2,
        },
        NotifyDEBUGBorder = {
          fg = palette.bg2,
          bg = palette.bg2,
        },
        NotifyDEBUGBody = {
          bg = palette.bg2,
        },
        NotifyDEBUGTitle = {
          fg = palette.black.base,
          bg = palette.bg2,
        },
        FlashPromptIcon = {
          fg = palette.orange.base,
        },
        GitSignsCurrentLineBlame = {
          fg = palette.fg3,
        },
        WinBarIcon = {
          bg = palette.bg3,
          fg = palette.fg0,
        },
        WinBarPath = {
          bg = palette.bg3,
          fg = palette.fg0,
        },
        WinBarPathModified = {
          bg = palette.bg3,
          fg = palette.fg0,
        },
        WinBarModified = {
          bg = palette.bg3,
          fg = palette.orange.bright,
        },
        WinBarExtras = {
          fg = palette.bg3,
          bg = palette.bg1,
        },
      },
    },
  })

  vim.cmd.colorscheme(colorscheme)
end

return M
