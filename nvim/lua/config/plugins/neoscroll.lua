local M = {
	"karb94/neoscroll.nvim",
	event = "BufReadPre",
    enabled = false
}

M.config = function()
	require("neoscroll").setup({
		respect_scrolloff = true,
        easing_function = "quadratic",
	})
end

return M
