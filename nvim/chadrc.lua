---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "gruvchad",
	nvdash = {
		load_on_startup = true,
	},
	transparency = true,

	statusline = {
		theme = "default",
		separator_style = "default",
	},
}
M.plugins = "custom.plugins"

M.mappings = require("custom.mappings")

return M
