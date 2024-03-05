local M = {
	"b0o/incline.nvim",
	event = "VeryLazy",
}

M.config = function()
	-- local helpers = require("incline.helpers")
	local colorscheme = require("config.ui").colorscheme
	local colors = require("nightfox.palette").load(colorscheme)
	local devicons = require("nvim-web-devicons")

	require("incline").setup({
		window = {
			padding = 0,
			margin = { horizontal = 1 },
		},
		render = function(props)
			local bg = colors.bg2
			local fg = colors.green.base
			local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			local modified = vim.bo[props.buf].modified
			local ft_icon, ft_color = devicons.get_icon_color(fname)
			local diagnostic_signs = require("kind").diagnostic_signs
			local diff_signs = require("kind").diff_icons

			local function get_git_diff()
				local icons = {
					added = diff_signs.added,
					changed = diff_signs.modified,
					removed = diff_signs.removed,
				}
				local signs = vim.b[props.buf].gitsigns_status_dict
				local labels = {}
				if signs == nil then
					return labels
				end
				for name, icon in pairs(icons) do
					if tonumber(signs[name]) and signs[name] > 0 then
						table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
					end
				end
				if #labels > 0 then
					table.insert(labels, { "┊ " })
				end
				return labels
			end

			local function get_diagnostic_label()
				local label = {}

				for severity, icon in pairs(diagnostic_signs) do
					local n =
						#vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
					if n > 0 then
						table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
					end
				end
				if #label > 0 then
					table.insert(label, { "┊ " })
				end
				return label
			end

			return {
				{ get_git_diff(), guibg = colors.bg1 },
				{ get_diagnostic_label(), guibg = colors.bg1 },
				{ "", guifg = bg, guibg = colors.bg1 },
				{
					ft_icon and { " ", ft_icon, " ", guifg = ft_color },
					{ " " .. fname .. " ", gui = modified and "italic" or "none" },
					modified and "○" or "",
					guibg = bg,
					guifg = fg,
				},
				{ "", guifg = bg, guibg = colors.bg1 },
			}
		end,
	})
end

return M
