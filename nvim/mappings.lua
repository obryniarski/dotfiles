local M = {}


M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left"},
    ["<C-i>"] = { "<cmd> TmuxNavigateRight<CR>", "window right"},
    ["<C-a>"] = { "<cmd> TmuxNavigateDown<CR>", "window down"},
    ["<C-e>"] = { "<cmd> TmuxNavigateUp<CR>", "window up"},

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
