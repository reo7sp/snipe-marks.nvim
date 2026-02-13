local config = require("snipe-marks.config")
local source = require("snipe-marks.source")
local formatter = require("snipe-marks.format")
local menu = require("snipe-marks.menu")

local M = {}

function M.setup(opts)
	config.setup(opts)
end

function M.open_marks_menu(scope)
	local resolved_scope = scope == "all" and "all" or "local"
	local marks = source.collect(resolved_scope)
	local items = formatter.prepare(marks, config.options)
	menu.open(items, resolved_scope, config.options)
end

return M
