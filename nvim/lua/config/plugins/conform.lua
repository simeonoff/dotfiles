local M = {
  'stevearc/conform.nvim',
  event = { 'BufReadPre' },
  command = { 'ConformInfo' },
  keys = {
    {
      '<leader>i',
      function() vim.cmd('Format') end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  enabled = true,
}

M.init = function()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  -- Format the current buffer using conform.nvim
  vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, end_line:len() },
      }
    end
    require('conform').format({ async = true, lsp_format = 'fallback', range = range })
  end, { range = true })

  -- Format the current buffer using con
  -- Format on save
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  -- 	pattern = "*",
  -- 	callback = function(args)
  -- 		require("conform").format({ bufnr = args.buf })
  -- 	end,
  -- })
end

M.config = function()
  require('conform').setup({
    formatters_by_ft = {
      astro = { 'prettierd' },
      lua = { 'stylua' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      css = { 'prettierd', 'stylelint' },
      scss = { 'prettierd', 'stylelint' },
      html = { 'prettierd' },
      json = { 'prettierd' },
      jsonc = { 'prettierd' },
      md = { 'prettierd' },
      mdx = { 'prettierd' },
      yaml = { 'prettierd' },
      svelte = { 'prettierd' },
      go = { 'goimports' },
      nix = { 'nixpkgs_fmt' },
    },
    -- format_on_save = {
    -- 	-- These options will be passed to conform.format()
    -- 	timeout_ms = 500,
    -- 	lsp_format = "fallback",
    -- },
  })
end

return M
