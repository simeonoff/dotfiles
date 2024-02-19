local M = {
	"mhartington/formatter.nvim",
	event = "BufReadPre",
}

local formatters = {
	stylelint = function()
		local util = require("formatter.util")
		local filepath = util.escape_path(util.get_current_buffer_file_path())
		local root_patterns = { ".package.json", ".stylelintrc.json" }
		local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

		return {
			exe = "stylelint",
			stdin = true,
			args = { "--fix", "--stdin", "--stdin-filename", filepath, "--config-basedir", root_dir },
			try_node_modules = true,
		}
	end,
}

M.config = function()
	require("formatter").setup({
		logging = true,
		log_level = vim.log.levels.WARN,
		filetype = {
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
			typescript = {
				require("formatter.filetypes.typescript").prettierd,
				require("formatter.filetypes.typescript").eslint_d,
			},
			typescriptreact = {
				require("formatter.filetypes.typescript").prettierd,
			},
			javascript = {
				require("formatter.filetypes.javascript").prettierd,
			},
			javascriptreact = {
				require("formatter.filetypes.javascript").prettierd,
			},
			css = {
				require("formatter.filetypes.css").prettierd,
				formatters.stylelint,
			},
			scss = {
				require("formatter.filetypes.css").prettierd,
				formatters.stylelint,
			},
			html = {
				require("formatter.filetypes.html").prettierd,
			},
			json = {
				require("formatter.filetypes.json").prettierd,
			},
			jsonc = {
				require("formatter.filetypes.json").prettierd,
			},
			md = {
				require("formatter.filetypes.markdown").prettierd,
			},
			mdx = {
				require("formatter.filetypes.markdown").prettierd,
			},
			yaml = {
				require("formatter.filetypes.yaml").prettierd,
			},
			svelte = {
				require("formatter.filetypes.svelte").prettier,
			},
		},
	})
end

return M
