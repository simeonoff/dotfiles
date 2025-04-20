local utils = require('utils')

local root_file = {
  '.stylelintrc',
  '.stylelintrc.mjs',
  '.stylelintrc.cjs',
  '.stylelintrc.js',
  '.stylelintrc.json',
  '.stylelintrc.yaml',
  '.stylelintrc.yml',
  'stylelint.config.mjs',
  'stylelint.config.cjs',
  'stylelint.config.js',
}

root_file = utils.insert_package_json(root_file, 'stylelint')

return {
  cmd = { 'stylelint-lsp', '--stdio' },
  filetypes = {
    'astro',
    'css',
    'less',
    'scss',
    'sugarss',
    'vue',
    'wxss',
  },
  root_dir = utils.root_pattern(unpack(root_file)),
  settings = {
    autoFixOnFormat = true,
  },
}
