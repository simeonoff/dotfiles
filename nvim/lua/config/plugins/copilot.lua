local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	enabled = true,
}

M.config = function()
	require("copilot").setup({
		panel = {
			enabled = false,
			auto_refresh = true,
			layout = {
				position = "right",
				ratio = 0.4,
			},
		},
		suggestions = {
			enabled = false,
			auto_trigger = true,
		},
	})
end

return M
