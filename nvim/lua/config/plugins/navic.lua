return {
	"SmiteshP/nvim-navic",
	event = "BufReadPre",
	init = function()
		vim.g.navic_silence = true
		require("utils").on_attach(function(client, buffer)
			require("nvim-navic").attach(client, buffer)
		end)
	end,
	config = {
		separator = " > ",
		highlight = true,
		depth_limit = 5,
		icons = require("kind").icons,
	},
}
