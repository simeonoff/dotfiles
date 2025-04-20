local utils = require('utils')

local root_dir = utils.root_pattern({ 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' })

local function get_probe_dir(dir)
  local project_root = utils.root_pattern({ 'node_modules' }, dir)
  return project_root and (project_root .. '/node_modules/typescript/lib') or ''
end

return {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_dir = root_dir,
  init_options = {
    typescript = {
      tsdk = get_probe_dir(root_dir),
    },
  },
  on_new_config = function(new_config, new_root_dir)
    if vim.tbl_get(new_config.init_options, 'typescript') and not new_config.init_options.typescript.tsdk then
      new_config.init_options.typescript.tsdk = get_probe_dir(new_root_dir)
    end
  end,
}
