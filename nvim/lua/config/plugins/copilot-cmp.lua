local M = {
	"zbirenbaum/copilot-cmp",
	event = { "InsertEnter", "LspAttach" },
}

M.config = function()
	require("copilot_cmp").setup()
end

return M
