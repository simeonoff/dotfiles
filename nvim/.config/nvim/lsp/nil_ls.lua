local utils = require('utils')
local root_dir = utils.root_pattern({ 'flake.nix' })

return {
  default_config = {
    cmd = { 'nil' },
    filetypes = { 'nix' },
    single_file_support = true,
    root_dir = root_dir,
  },
}
