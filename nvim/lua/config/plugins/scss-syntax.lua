local M = {
	"cakebaker/scss-syntax.vim",
	event = "BufReadPre",
    enabled = false
}

M.config = function()
	local personal_augroup = vim.api.nvim_create_augroup("scss-syntax", { clear = true })

	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "scss" },
		callback = function()
			vim.bo.filetype = "scss.css"
		end,
		group = personal_augroup,
	})
end

return M
