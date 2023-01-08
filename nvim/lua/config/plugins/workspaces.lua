local M = {
	"natecraddock/workspaces.nvim",
	cmd = { "WorkspacesList", "Telescope workspaces" },
	keys = {
		{ "<C-l>", "<cmd>Telescope workspaces<cr>", desc = "List workspaces" },
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
