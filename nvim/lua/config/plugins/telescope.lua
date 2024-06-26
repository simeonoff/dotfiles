local M = {
	"nvim-telescope/telescope.nvim",
	lazy = false,

	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-lua/plenary.nvim" },
	},
}

M.recent_files = function()
	local telescopePickers = require("telescopePickers")
	local utils = require("utils")

	telescopePickers.prettyFilesPicker({
		picker = "oldfiles",
		options = { prompt_title = "Recent Files", cwd = utils.get_root(), cwd_only = true },
	})
end

M.project_files = function()
	local telescopePickers = require("telescopePickers")
	local opts = {}

	if vim.loop.fs_stat(".git") then
		opts.show_untracked = true
		telescopePickers.prettyFilesPicker({ picker = "git_files", options = opts })
	else
		local client = vim.lsp.get_clients()[1]
		if client then
			opts.cwd = client.config.root_dir
		end
		telescopePickers.prettyFilesPicker({ picker = "find_files", options = opts })
	end
end

M.config = function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")
	local telescopePickers = require("telescopePickers")

	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "     ",
			selection_caret = "  ",
			entry_prefix = "  ",
			multi_icon = " + ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				-- width = 0.75,
				-- prompt_position  "bottom",
				-- preview_cutoff = 90,
				horizontal = {
					mirror = false,
				},
				vertical = {
					-- width = 0.5,
					mirror = true,
					prompt_position = "top",
				},
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "node_modules" },
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			use_less = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

			mappings = {
				i = {
					["<C-q>"] = actions.send_to_qflist,
					["<C-n>"] = false,
					["<C-p>"] = false,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			},
		},
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
		},
	})

	-- Custom commands
	vim.api.nvim_create_user_command("RecentFiles", M.recent_files, {})

	-- Mappings
	vim.keymap.set("n", "<leader>f", M.project_files, { desc = "Find files" })

	vim.keymap.set("n", "<leader>r", M.recent_files, { desc = "Recent files" })

	vim.keymap.set("n", "<leader>/", function()
		telescopePickers.prettyGrepPicker({ picker = "live_grep" })
	end, { desc = "Global search" })

	vim.keymap.set("n", "<leader><leader>", function()
		telescopePickers.prettyGrapplePicker()
	end, { desc = "Pick from open buffeers" })

	vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Broser git branches in current project" })

	vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Resume the last opened telescope prompt" })
end

return M
