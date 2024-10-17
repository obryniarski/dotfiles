local options = {
	-- Set default options
	default_format_opts = {
		lsp_format = "fallback",
	},

	-- format_on_save = { timeout_ms = 500 },

	formatters_by_ft = {
		python = { "isort", "ruff_format" },

		lua = { "stylua" },

		rust = { "rustfmt" },

		sh = { "shfmt" },
	},

	formatters = {
		shfmt = {
			prepend_args = { "-ln", "bash" },
		},
		isort = {
			prepend_args = { "--sl" },
		},
	},
}

require("conform").setup(options)
