local M = {}

local function get_line_text(bufnr, lnum)
	if not bufnr or bufnr <= 0 or not vim.api.nvim_buf_is_valid(bufnr) then
		return ""
	end

	local line_count = vim.api.nvim_buf_line_count(bufnr)
	if lnum < 1 or lnum > line_count then
		return ""
	end

	local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]
	return line or ""
end

local function normalize_mark(mark_data, mark_type, current_buf)
	if not mark_data or not mark_data.mark or not mark_data.pos then
		return nil
	end

	local raw_mark = tostring(mark_data.mark)
	local mark = raw_mark:sub(2, 3)
	local pos = mark_data.pos
	local buf = pos[1]
	local lnum = pos[2]
	local col = pos[3]

	if type(lnum) ~= "number" or lnum <= 0 or type(col) ~= "number" or col <= 0 then
		return nil
	end

	if type(buf) ~= "number" or buf <= 0 then
		buf = current_buf
	end

	local text = ""
	local file = mark_data.file or ""
	if mark_type == "global" and file ~= "" then
		local mark_pos = vim.api.nvim_get_mark(mark, {})
		text = mark_pos[4] or ""
	end

	if text == "" then
		text = get_line_text(buf, lnum)
	end

	return {
		mark = mark,
		bufnr = buf,
		file = file,
		lnum = lnum,
		col = col,
		text = text,
		is_global = mark_type == "global",
	}
end

function M.collect(scope)
	local current_buf = vim.api.nvim_get_current_buf()
	local groups = {
		{ type = "local", items = vim.fn.getmarklist(current_buf) },
	}

	if scope == "all" then
		table.insert(groups, { type = "global", items = vim.fn.getmarklist() })
	end

	local out = {}
	for _, group in ipairs(groups) do
		for _, mark_data in ipairs(group.items) do
			local item = normalize_mark(mark_data, group.type, current_buf)
			if item then
				table.insert(out, item)
			end
		end
	end

	return out
end

return M
