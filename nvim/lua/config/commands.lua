local utils = require("utils")
local group_id = vim.api.nvim_create_augroup("rooter", { clear = true })
local personal_augroup = vim.api.nvim_create_augroup("personal_augroup", { clear = true })
local bufonly = require("bufonly")
local lualine = require("lualine")

vim.api.nvim_create_user_command("BufOnly", function()
	bufonly.BufOnly()
end, {})

-- Pressing q closes the quickfix, help and other windows
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"oil",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Change conceallevel for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "md", "markdown" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
	group = personal_augroup,
})

-- Add keyboard navigation for terminals
-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	pattern = {
-- 		"term://*",
-- 	},
-- 	callback = function()
-- 		local opts = { buffer = 0 }
-- 		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
-- 		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
-- 		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
-- 		vim.keymap.set("t", "<C-t>", [[<Cmd>ToggleTerm<CR>]])
-- 	end,
-- 	group = personal_augroup,
-- })

-- Clears 'root_dir' variable for buffers on open/reload
vim.api.nvim_create_autocmd("BufRead", {
	group = group_id,
	callback = function()
		vim.api.nvim_buf_set_var(0, "root_dir", nil)
	end,
})

-- Change the current working directory to the root dir of the buffer
vim.api.nvim_create_autocmd("BufEnter", {
	group = group_id,
	nested = true,
	callback = function()
		local excluded_filetypes = {
			["neo-tree"] = true,
			["NvimTree"] = true, -- Example of adding another filetype
		}
		local ft = vim.bo.filetype

		if not excluded_filetypes[ft] then
			-- Proceed with setting root_dir and changing directory
			local root = vim.b.root_dir or utils.get_root()

			if not vim.b.root_dir then
				vim.b.root_dir = root
				vim.api.nvim_buf_set_var(0, "root_dir", root)
			end
		end
	end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		lualine.refresh({
			place = { "statusline" },
		})
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		-- This is going to seem really weird!
		-- Instead of just calling refresh we need to wait a moment because of the nature of
		-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
		-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
		-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
		-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
		local timer = vim.loop.new_timer()
		timer:start(
			50,
			0,
			vim.schedule_wrap(function()
				lualine.refresh({
					place = { "statusline" },
				})
			end)
		)
	end,
})

-- Automatically jump to the last known cursor position
vim.api.nvim_create_autocmd("BufRead", {
	callback = function(opts)
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			buffer = opts.buf,
			callback = function()
				local ft = vim.bo[opts.buf].filetype
				local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
				if
					not (ft:match("commit") and ft:match("rebase"))
					and last_known_line > 1
					and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
				then
					vim.api.nvim_feedkeys([[g`"]], "nx", false)
				end
			end,
		})
	end,
})
