local M = {}

local function with_display_line(item)
	local line = string.format("%s %6d %4d %s", item.mark, item.lnum, item.col - 1, item.text)
	item.line = line
	return item
end

function M.prepare(items, opts)
	local alnum = {}
	local non_alnum = {}

	for _, item in ipairs(items) do
		with_display_line(item)
		if item.mark:match("%w") then
			table.insert(alnum, item)
		elseif opts.include_non_alnum then
			table.insert(non_alnum, item)
		end
	end

	for _, item in ipairs(non_alnum) do
		table.insert(alnum, item)
	end

	return alnum
end

return M
