local plugins = {

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function (_)
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end


    -- opts = function()
      -- return require "custom.configs.copilot"
    -- end,
    -- config = function(_, opts)
    --   require("copilot").setup(opts)
    --
    -- vim.keymap.set("i", '<Tab>', function()
    --   if require("copilot.suggestion").is_visible() then
    --     require("copilot.suggestion").accept()
    --   else
    --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
    --   end
    -- end, {
    --   silent = true,
    -- })
    -- end,
  },

  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "custom.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,

  },

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
  },

  -- install without yarn or npm
{
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
},

}

return plugins
