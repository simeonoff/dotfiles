local M = {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	enabled = true,
}

M.config = function()
	require("copilot").setup({
		panel = {
			enabled = false,
			auto_refresh = true,
		},
		suggestions = {
			enabled = false,
			auto_trigger = true,
		},
	})
end

return M
