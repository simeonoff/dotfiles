local M = {
	"natecraddock/workspaces.nvim",
    enabled = false,
	cmd = { "WorkspacesList", "Telescope workspaces" },
	keys = {
		{ "<leader>P", "<cmd>Telescope workspaces<cr>", desc = "List workspaces" },
	},
}

M.config = function()
	local workspaces = require("workspaces")
	workspaces.setup({
		hooks = {
			open = function()
				require("utils").telescope_project_files()
			end,
		},
	})
end

return M
