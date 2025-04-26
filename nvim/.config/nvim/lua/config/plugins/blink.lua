local M = {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'fang2hou/blink-copilot',
      enabled = false,
    },
  },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  event = 'InsertEnter',
  lazy = false,
  ---@module 'blink.cmp'
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'enter' },

    enabled = function() return not vim.tbl_contains({ 'oil', 'markdown' }, vim.bo.filetype) end,

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      ghost_text = {
        enabled = false,
      },
      menu = {
        border = 'single',
        draw = {
          columns = {
            { 'kind_icon', 'label', gap = 1 },
            { 'source_name' },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                local dev_icon = require('kind').get_icon(ctx.kind)

                if dev_icon then icon = dev_icon end

                return icon .. ctx.icon_gap
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = 'single' },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lazydev', 'lsp', 'buffer', 'snippets', 'path' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- Make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        lsp = {
          min_keyword_length = 2, -- Number of characters to trigger provider
          score_offset = 5, -- Boost/penalize the score of the items
        },
        path = {
          min_keyword_length = 0,
        },
        snippets = {
          min_keyword_length = 2,
          score_offset = 0,
        },
        -- copilot = {
        --   name = 'copilot',
        --   module = 'blink-copilot',
        --   score_offset = 100,
        --   async = true,
        -- },
        buffer = {
          min_keyword_length = 4,
          max_items = 5,
        },
      },
    },
    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = {
      sorts = {
        function(a, b)
          if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then return end
          return b.client_name == 'emmetls'
        end,
        -- 'exact',
        -- defaults
        'score',
        'sort_text',
        'kind',
      },
      implementation = 'prefer_rust_with_warning',
    },
  },
  opts_extend = { 'sources.default' },
}

return M
