local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
}

M.config = function()
	require("gitsigns").setup({
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				if type(opts) == "string" then
					opts = { desc = opts, silent = true }
				end
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk({ navigation_message = false })
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next Hunk" })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk({ navigation_message = false })
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Prev Hunk" })
		end,
	})
end

return M
