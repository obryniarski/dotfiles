local cmp = require("cmp")
local configs = require("nvchad.configs.cmp")

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

configs.sources = {
	{ name = "copilot", group_index = 2 },
	{ name = "buffer", group_index = 2 },
	{ name = "nvim_lsp", group_index = 2 },
	{ name = "path", group_index = 2 },
}

-- copied from https://github.com/onsails/lspkind.nvim?tab=readme-ov-file#option-2-nvim-cmp
local lspkind = require("lspkind")
configs.formatting = {
	format = function(entry, vim_item)
		-- Use lspkind to get the symbol and kind
		-- Append the source name in parentheses (except for copilot)
		if entry.source.name ~= "copilot" then
			vim_item = lspkind.cmp_format({ with_text = true, maxwidth = 50 })(entry, vim_item)
			vim_item.menu = string.format(" [%s]", entry.source.name)
		end
		return vim_item
	end,
}

configs.sorting = {
	priority_weight = 2,
	comparators = {
		require("copilot_cmp.comparators").prioritize,

		-- Below is the default comparitor list and order for nvim-cmp
		cmp.config.compare.offset,
		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
		cmp.config.compare.exact,
		cmp.config.compare.score,
		cmp.config.compare.recently_used,
		cmp.config.compare.locality,
		cmp.config.compare.kind,
		cmp.config.compare.sort_text,
		cmp.config.compare.length,
		cmp.config.compare.order,
	},
}

-- configs.mapping
configs.mapping = {
	["<C-p>"] = cmp.mapping.select_prev_item(),
	["<C-n>"] = cmp.mapping.select_next_item(),
	["<C-d>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.close(),
	-- I think eventually I will want to change this to use the second layer
	-- enter of my keyboard, but we'll see
	["<S-CR>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),
	["<Tab>"] = vim.schedule_wrap(function(fallback)
		if cmp.visible() and has_words_before() then
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		else
			fallback()
		end
	end),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
		else
			fallback()
		end
	end),
}

return configs
