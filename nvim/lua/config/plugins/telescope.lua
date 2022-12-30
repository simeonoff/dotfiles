local function project_files()
	local opts = {}
	if vim.loop.fs_stat(".git") then
		opts.show_untracked = true
		require("telescope.builtin").git_files(opts)
	else
		local client = vim.lsp.get_active_clients()[1]
		if client then
			opts.cwd = client.config.root_dir
		end
		require("telescope.builtin").find_files(opts)
	end
end

return {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },

	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<C-p>", project_files, desc = "Find File" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

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
				prompt_prefix = "> ",
				selection_caret = "> ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "descending",
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.75,
					prompt_position = "bottom",
					preview_cutoff = 120,
					horizontal = {
						mirror = false,
					},
					vertical = {
						mirror = false,
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

		telescope.load_extension("projects")

		-- Mappings
		vim.keymap.set("n", "<C-F>", builtin.live_grep, { desc = "Search for files on the computer" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Search existing buffers" })
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Search git branches in current project" })
		vim.keymap.set("n", "<C-L>", function()
			telescope.extensions.projects.projects()
		end, { desc = "Search for projects" })
	end,
}
