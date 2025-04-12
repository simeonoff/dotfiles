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
	astro = function()
		local util = require("formatter.util")
		local filepath = util.escape_path(util.get_current_buffer_file_path())
		local root_patterns = { ".package.json", ".prettierrc" }
		local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

		return {
			exe = "prettierd",
			stdin = true,
			args = { filepath, "--write" },
			root_dir = root_dir,
			try_node_modules = true,
		}
	end,
	eslint = function()
		local util = require("formatter.util")
		local filepath = util.escape_path(util.get_current_buffer_file_path())
		local root_patterns = { "package.json", ".prettierrc" }
		local eslint_config_files =
			{ "eslint.config.js", "eslint.config.mjs", ".eslintrc", ".eslintrc.js", ".eslintrc.json" }

		local root_file = vim.fs.find(root_patterns, { upward = true })[1]

		if not root_file then
			return nil -- No project root found
		end

		local root_dir = vim.fs.dirname(root_file)

		-- Check if any ESLint config exists in the project root
		local has_eslint_config = false

		for _, config_file in ipairs(eslint_config_files) do
			if vim.fn.filereadable(vim.fn.resolve(root_dir .. "/" .. config_file)) == 1 then
				has_eslint_config = true
				break
			end
		end

		if has_eslint_config then
			return {
				exe = "eslint_d",
				args = {
					"--stdin",
					"--stdin-filename",
					filepath,
					"--fix-to-stdout",
				},
				root_dir = root_dir,
				stdin = true,
				try_node_modules = true,
			}
		else
			return nil
		end
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
				formatters.eslint,
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
			go = {
				require("formatter.filetypes.go").goimports,
			},
			scss = {
				require("formatter.filetypes.css").prettierd,
				formatters.stylelint,
			},
			html = {
				require("formatter.filetypes.html").prettierd,
			},
			astro = {
				formatters.astro,
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
