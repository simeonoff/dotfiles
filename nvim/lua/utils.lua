local M = {}
local telescopePickers = require("telescopePickers")

M.open_location = function()
	local loc = vim.fn.expand("<cfile>")
	local executable = nil

	if vim.fn.has("mac") == 1 then
		executable = "open"
	elseif vim.fn.has("unix") == 1 then
		executable = "xdg-open"
	end

	if executable then
		vim.loop.spawn(executable, {
			args = { loc },
		})
	else
		print("Error: opening locations is not supported on this OS")
	end
end

M.delete_buffers = function()
	vim.cmd("%bd|e#|bd#")
end

M.toggle_diffview = function()
	local diffview = require("diffview.lib").get_current_view()

	if not diffview then
		vim.cmd("DiffviewOpen")
	else
		vim.cmd("DiffviewClose")
	end
end

M.get_root = function()
	local path = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0)) or vim.loop.cwd()

	-- Utilize early return to avoid deep nesting
	if path == "" then
		return vim.loop.cwd()
	end

	for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
		local workspace_folders = client.config.workspace_folders or {}
		local root_dirs = vim.tbl_map(function(ws)
			return vim.uri_to_fname(ws.uri)
		end, workspace_folders)
		if client.config.root_dir then
			table.insert(root_dirs, client.config.root_dir)
		end

		for _, p in ipairs(root_dirs) do
			local r = vim.loop.fs_realpath(p)
			if r and path and path:find(r, 1, true) then
				return r -- Return immediately upon finding the first matching root
			end
		end
	end

	-- Fallback to searching for a .git directory or using cwd
	local root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
	return root and vim.fs.dirname(root) or vim.loop.cwd()
end

M.on_attach = function(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

M.telescope_project_files = function()
	local opts = {}
	if vim.loop.fs_stat(".git") then
		opts.show_untracked = true
		telescopePickers.prettyFilesPicker({ picker = "git_files", options = opts })
	else
		local client = vim.lsp.get_active_clients()[1]
		if client then
			opts.cwd = client.config.root_dir
		end
		telescopePickers.prettyFilesPicker({ picker = "find_files", options = opts })
	end
end

M.rename_cword = function()
	-- Get the current word under the cursor
	local current_word = vim.fn.expand("<cword>")

	-- Use input the new name
	vim.ui.input({
		prompt = "Rename: ",
		default = current_word,
	}, function(new_name)
		-- Check if the new name is not nil or the same as the current word
		if new_name and new_name ~= current_word then
			-- Escape special characters in the current word to use it in a Lua pattern
			local escaped_word = current_word:gsub("([^%w])", "%%%1")

			-- Replace all occurrences in the buffer
			local pattern = "\\V\\<" .. escaped_word .. "\\>"
			local cmd = ":%s/" .. pattern .. "/" .. new_name .. "/g"
			vim.cmd(cmd)
		end
	end)
end

return M
