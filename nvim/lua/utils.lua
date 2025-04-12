local M = {}

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

-- This should only work in neovim 0.10
local get_visual_selection = function()
	local supported = pcall(vim.fn.getregion, vim.fn.getpos("."), vim.fn.getpos("v"), { mode = vim.fn.mode() })

	if supported then
		return vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { mode = vim.fn.mode() })
	else
		return { vim.fn.expand("<cword>") }
	end
end

M.rename_cword = function()
	local current_word

	if vim.fn.mode() == "v" then
		current_word = table.concat(get_visual_selection())
	else
		current_word = vim.fn.expand("<cword>")
	end

	-- Use input the new name
	vim.ui.input({
		prompt = "Rename: ",
		default = current_word,
	}, function(new_name)
		-- Check if the new name is not nil or the same as the current word
		if new_name and new_name ~= current_word then
			-- Escape special characters
			local escaped_word = vim.fn.escape(current_word, "\\/.*'$^~[]")
			-- Form the pattern, considering very nomagic option
			local pattern = "\\V" .. escaped_word
			-- Perform the replacement
			local cmd = ":%s/" .. pattern .. "/" .. vim.fn.escape(new_name, "/") .. "/g"
			vim.cmd(cmd)
		end
	end)
end

-- Navigate to the next tmux pane or Neovim window
M.navigate = function(direction)
	local current_win = vim.api.nvim_get_current_win()
	vim.cmd("wincmd " .. direction)

	-- Check if we are in a tmux session and if the current window is at the edge
	if current_win == vim.api.nvim_get_current_win() and vim.env.TMUX then
		local tmux_commands = {
			h = "select-pane -L",
			j = "select-pane -D",
			k = "select-pane -U",
			l = "select-pane -R",
		}

		local zoom_command = 'tmux display-message -p "#{window_zoomed_flag}"'
		local is_zoomed = vim.fn.trim(vim.fn.system(zoom_command))

		if is_zoomed == "0" then
			vim.fn.system("tmux " .. tmux_commands[direction])
		end
	end
end

return M
