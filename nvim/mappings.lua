local M = {}

M.general = {
	n = {
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
		["<A-i>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
		["<C-a>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
		["<C-e>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },

		["<leader>fm"] = {
			function()
				require("conform").format({ async = true })
				vim.cmd("write")
			end,
			"Format buffer (Conform)",
		},
	},
}

M.diffview = {
	n = {
		["df"] = { "<cmd>DiffviewOpen<CR>", "Open diffview" },
	},
}

return M
