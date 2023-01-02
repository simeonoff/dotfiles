local M = {}

M.icons = {
	Namespace = "",
	Text = "  ",
	Method = " ",
	Function = " ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
	Table = "",
	Object = " ",
	Tag = "",
	Array = "[]",
	Boolean = " ",
	Number = " ",
	Null = "ﳠ",
	String = " ",
	Calendar = "",
	Watch = " ",
	Package = "",
	Copilot = " ",
}

M.format = function()
	return function(entry, vim_item)
		-- vim_item.kind = string.format("%s %s", M.icons[vim_item.kind], vim_item.kind)
		vim_item.kind = M.icons[vim_item.kind]

		vim_item.menu = ({
			buffer = "[Buffer]",
			nvim_lsp = "[LSP]",
			luasnip = "[Snippet]",
			nvim_lua = "[Lua]",
			latex_symbols = "[LaTeX]",
		})[entry.source.name]

		return vim_item
	end
end

return M
