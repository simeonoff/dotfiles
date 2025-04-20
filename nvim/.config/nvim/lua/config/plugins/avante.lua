local M = {
  'yetone/avante.nvim',
  command = { 'AvanteAsk', 'AvanteChat', 'AvanteToggle' },
  keys = {
    { '<leader>aa', '<cmd>AvanteToggle<cr>', desc = 'Toggle Avante' },
  },
  enabled = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.

  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',

  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'Avante' },
      },
      ft = { 'Avante' },
    },
  },
}

M.config = function()
  require('avante').setup({
    behaviour = {
      enable_token_counting = false,
    },
  })
  require('1password').load_env_vars({
    ANTHROPIC_API_KEY = 'Personal/Anthropic/API key',
  })
end

return M
