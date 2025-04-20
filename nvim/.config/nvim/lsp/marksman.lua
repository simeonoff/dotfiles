local utils = require('utils')
local bin_name = 'marksman'
local cmd = { bin_name, 'server' }

local root_dir = utils.root_pattern({ '.marksman.toml', '.git' })

return {
  cmd = cmd,
  filetypes = { 'markdown', 'markdown.mdx' },
  root_dir = root_dir,
  single_file_support = true,
}
