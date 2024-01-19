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
        "rust-analyzer",
        "ruff"
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

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      }
    },
    opts = function()
      return require "custom.configs.telescope"
    end,
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    config = function ()
      require "custom.configs.treesittercontext"
    end
  },

  {
    "sindrets/diffview.nvim",
    keys = {
      { "d", mode = "n", desc = "Open diffview" },
    },
    init = function ()
      require("core.utils").load_mappings "diffview"
    end,
    opts = {
      view = {
        merge_tool = {
          layout = "diff4_mixed"
        }
      }
    }
  }

}

return plugins
