local M = {}


M.general = {
  n = {

    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    }
  }
}

M.diffview = {
  n = {
    ["df"] = { "<cmd>DiffviewOpen<CR>", "Open diffview" }
  }
}


return M
