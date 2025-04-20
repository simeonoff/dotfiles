local M = {
  'nvim-tree/nvim-web-devicons',
  lazy = false,
}

M.config = function()
  require('nvim-web-devicons').setup({
    override = {
      go = {
        icon = '󰟓',
        color = '#519aba',
        cterm_color = '74',
        name = 'Go',
      },
    },
    override_by_extension = {
      ['nuspec'] = {
        icon = '󰑫',
        color = '#e37933',
        cterm_color = 166,
        name = 'Nuspec',
      },
    },
    override_by_filename = {
      ['.eslintrc.json'] = {
        icon = '',
        color = '#4b32c3',
        cterm_color = 56,
        name = 'Eslintrc',
      },
      ['go.mod'] = {
        icon = '󰟓',
        color = '#f55385',
        cterm_color = '204',
        name = 'GoMod',
      },
      ['.gitignore'] = {
        icon = '',
        color = '#41535b',
        cterm_color = '239',
        name = 'GitIgnore',
      },
      ['.gitattributes'] = {
        icon = '',
        color = '#41535b',
        cterm_color = '239',
        name = 'GitAttributes',
      },
      ['.gitmodules'] = {
        icon = '',
        color = '#41535b',
        cterm_color = '239',
        name = 'GitModules',
      },
      ['changelog.md'] = {
        icon = '',
        name = 'Changelog',
      },
      ['custom-elements.json'] = {
        icon = '',
        color = '#e44d26',
        name = 'CustomElements',
      },
      ['readme.md'] = {
        icon = '',
        name = 'ReadMe',
      },
      ['roadmap.md'] = {
        icon = '',
        name = 'Roadmap',
      },
      ['code_of_conduct.md'] = {
        icon = '',
        color = '#a074c4',
        name = 'CodeOfConduct',
      },
      ['commit_editmsg'] = {
        icon = '',
        color = '#41535b',
        cterm_color = '239',
        name = 'GitCommit',
      },
      ['.prettierrc.json'] = {
        icon = '',
        color = '#4285f4',
        cterm_color = 33,
        name = 'PrettierConfig',
      },
      ['.sassdocrc'] = {
        icon = '',
        color = '#f55385',
        cterm_color = '204',
        name = 'Sassdoc',
      },
      ['.stylelintrc.json'] = {
        icon = '',
        name = 'Stylelint',
      },
      ['tsconfig.node.json'] = {
        icon = '',
        color = '#519aba',
        cterm_color = 74,
        name = 'TSConfig',
      },
      ['.browserslistrc'] = {
        icon = '',
        name = 'Browserlist',
      },
      ['license'] = {
        icon = '󰌆',
        color = '#d0bf41',
        cterm_color = '185',
        name = 'License',
      },
    },
  })
end

return M
