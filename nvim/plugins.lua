local plugins = {

  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   opts = function()
  --     return require "custom.configs.copilot"
  --   end,
  --   config = function(_, opts)
  --     require("copilot").setup(opts)
  --
  --   vim.keymap.set("i", '<Tab>', function()
  --     if require("copilot.suggestion").is_visible() then
  --       require("copilot.suggestion").accept()
  --     else
  --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  --     end
  --   end, {
  --     silent = true,
  --   })
  --   end,
  --
  -- },

  -- {
  --   "NvChad/nvim-cmp",
  --   enabled = false,
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "python",
        "regex",
        "rust",
        "scss",
        "toml",
        "typescript",
        "yaml",
        "vimdoc"
      },
    }
  },

 {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "lua-language-server",
        "pyright",
        "ruff",
        "rust-analyzer",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },

}

return plugins
