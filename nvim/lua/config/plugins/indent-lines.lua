local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	main = "ibl",
}

M.config = function()
	local hooks = require("ibl.hooks")
	hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
	hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

	require("ibl").setup({
		indent = {
			char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
		},
		scope = {
			show_start = false,
			show_end = false,
		},
	})
end

return M
