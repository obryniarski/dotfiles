local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = { "pyright", "rust_analyzer" }

for _, lsp in ipairs(servers) do
  local default_config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if lsp == "pyright" and vim.fn.executable("pyenv") == 1 then
    default_config.settings = {
      python = {
        pythonPath = vim.fn.system('pyenv which python'):gsub('%s+', '')
      },
      typeCheckingMode = "standard",
    }
  end

  lspconfig[lsp].setup(default_config)
end
