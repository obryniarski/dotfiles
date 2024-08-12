local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },

    rust = { "rustfmt" },

    sh = { "shfmt" }
  }
}

require("conform").setup(options)
