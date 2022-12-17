require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            }
        }
    },
    ensure_installed = {
        'javascript',
        'typescript',
        'tsx',
        'html',
        'css',
        'json',
        'lua',
        'svelte',
        'yaml',
        'markdown',
        'vim',
    },
    indent = {
        enable = true,
    }
})