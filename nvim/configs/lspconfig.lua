local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local on_init = configs.on_init
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
local servers = { "pyright", "rust_analyzer" }

for _, lsp in ipairs(servers) do
	local default_config = {
		on_attach = on_attach,
		on_init = on_init,
		capabilities = lsp_capabilities,
	}

	if lsp == "pyright" and vim.fn.executable("pyenv") == 1 then
		default_config.settings = {
			python = {
				pythonPath = vim.fn.system("pyenv which python"):gsub("%s+", ""),
			},
			typeCheckingMode = "standard",
		}
	end

	lspconfig[lsp].setup(default_config)
end
