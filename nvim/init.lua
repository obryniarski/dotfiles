vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<S-CR>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " " -- Set the leader key to space

-- KEYMAPS

local function swap_with_count(count, direction, object_type)
	local ts_swap = require("nvim-treesitter.textobjects.swap")
	local swap_next, swap_prev

	if object_type == "parameter" then
		swap_next = "@parameter.inner"
		swap_prev = "@parameter.inner"
	elseif object_type == "function" then
		swap_next = "@function.outer"
		swap_prev = "@function.outer"
	end

	for _ = 1, (count or 1) do
		if direction == "next" then
			ts_swap.swap_next(swap_next)
		elseif direction == "prev" then
			ts_swap.swap_previous(swap_prev)
		end
	end
end

vim.keymap.set("n", "ep", function()
	local count = vim.v.count1
	swap_with_count(count, "next", "parameter")
end, { noremap = true, silent = true, desc = "Swap parameter to the right" })

vim.keymap.set("n", "hp", function()
	local count = vim.v.count1
	swap_with_count(count, "prev", "parameter")
end, { noremap = true, silent = true, desc = "Swap parameter to the left" })

vim.keymap.set("n", "ef", function()
	local count = vim.v.count1
	swap_with_count(count, "next", "function")
end, { noremap = true, silent = true, desc = "Swap function to the right" })

vim.keymap.set("n", "hf", function()
	local count = vim.v.count1
	swap_with_count(count, "prev", "function")
end, { noremap = true, silent = true, desc = "Swap function to the left" })

-- VIM OPTIONS
vim.opt.relativenumber = true
vim.opt.scrolloff = 5

-- cmp window height
vim.opt.pumheight = 10

vim.g.python_recommended_style = 0

vim.g.user = {
	transparent = false,
	event = "UserGroup",
	config = {
		undodir = vim.fn.stdpath("cache") .. "/undo",
	},
}

vim.api.nvim_create_augroup(vim.g.user.event, {})

-- get copilot to work well with cmp
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- SET PYTHON VERSION
-- (if pyenv is installed, we're probably using it)
if vim.fn.executable("pyenv") == 1 then
	-- for some reason, this sometimes returns with a newline
	vim.cmd([[
    let $PYENV_VERSION = substitute(system('pyenv version-name'), '\n', '', '')
  ]])
end

-- REMEMBER LINE POSITION

-- From vim defaults.vim
-- ---
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.g.user.event,
	callback = function(args)
		local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
		local not_commit = vim.b[args.buf].filetype ~= "commit"

		if valid_line and not_commit then
			vim.cmd([[normal! g`"]])
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "copilot-*",
	callback = function()
		vim.opt_local.relativenumber = true
		vim.opt_local.number = true
	end,
})
