local M = {
	"zbirenbaum/copilot-cmp",
	event = { "InsertEnter", "LspAttach" },
	fix_pairs = true,
	enabled = true,
}

M.config = function()
	require("copilot_cmp").setup()
end

return M
