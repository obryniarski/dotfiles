require("nvchad.mappings")
local map = vim.keymap.set

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Window left" })
map("n", "<A-i>", "<cmd> TmuxNavigateRight<CR>", { desc = "Window right" })
map("n", "<C-a>", "<cmd> TmuxNavigateDown<CR>", { desc = "Window down" })
map("n", "<C-e>", "<cmd> TmuxNavigateUp<CR>", { desc = "Window up" })

map("n", "<leader>fm", function()
	require("conform").format({
		async = true,
		on_complete = function(results)
			for _, result in ipairs(results) do
				if result.err then
					vim.notify("Formatting error: " .. result.err, vim.log.levels.ERROR)
				else
					vim.notify("Formatted with: " .. result.formatter, vim.log.levels.INFO)
				end
			end
		end,
	})
	vim.cmd("write")
end, { desc = "Format buffer (Conform)" })


-- extra telescope mappings
map("n", "<leader>fs", "<cmd>Telescope treesitter<CR>", { desc = "telescope pick from treesitter symbols" })

-- new nvchad defaults, not sure about these yet
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
