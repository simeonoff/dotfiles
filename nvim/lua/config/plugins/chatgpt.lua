local M = {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
}

M.config = function ()
    local ChatGPT = require("chatgpt")
    ChatGPT.setup({
        api_key_cmd = "op read op://Personal/ChatGPT/token --no-newline"
    })
end

return M
