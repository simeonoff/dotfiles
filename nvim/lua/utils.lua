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
	local path = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
	local roots = {}
	if path ~= "" then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path ~= nil and path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	local root = roots[1]
	if not root then
		path = path == "" and vim.loop.cwd() or vim.fs.dirname(path)
		root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	return root
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
		require("telescope.builtin").git_files(opts)
	else
		local client = vim.lsp.get_active_clients()[1]
		if client then
			opts.cwd = client.config.root_dir
		end
		require("telescope.builtin").find_files(opts)
	end
end

return M
