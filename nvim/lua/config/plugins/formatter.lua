local M = {
	"mhartington/formatter.nvim",
	event = "BufReadPre",
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
			},
			scss = {
				require("formatter.filetypes.css").prettierd,
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
