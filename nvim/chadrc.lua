---@type ChadrcConfig
local M = {}

M.ui = { 
  theme = 'gruvchad',
  nvdash = {
    load_on_startup = true
  },
  transparency = true
}
M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"


return M
