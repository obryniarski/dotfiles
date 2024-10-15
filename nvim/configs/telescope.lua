local configs = require("plugins.configs.telescope")
local telescope = require "telescope"
telescope.load_extension("fzf")


local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

configs.defaults.mappings = {
  n = { ["q"] = require("telescope.actions").close },
  i = { ['<CR>'] = select_one_or_multi },
}

configs.defaults.file_ignore_patterns = { ".git/", "%.png", "%.jpg", "%.jpeg" }

configs.pickers = {
  find_files = {
    hidden = true, -- show hidden files
    no_ignore = false, -- but exclude files in .gitignore
  }
}

return configs
