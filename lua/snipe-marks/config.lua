local M = {}

local defaults = {
	title = {
		local_marks = "Local Marks",
		all_marks = "All Marks",
	},
	highlights = {
		mark = "WarningMsg",
		line = "MoreMsg",
		col = "Search",
		text = "Normal",
	},
	include_non_alnum = true,
	notify_no_marks = true,
	position = "cursor",
	open_command = "edit",
}

M.options = vim.deepcopy(defaults)

function M.setup(user_opts)
	M.options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), user_opts or {})
	return M.options
end

return M
