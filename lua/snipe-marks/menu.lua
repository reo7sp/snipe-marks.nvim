local Menu = require("snipe.menu")
local hl = require("snipe.highlights")
local actions = require("snipe-marks.actions")

local M = {}

local function add_keymaps(menu, opts)
	menu:add_new_buffer_callback(function(m)
		vim.keymap.set("n", "<esc>", function()
			m:close()
		end, { nowait = true, buffer = m.buf })

		vim.keymap.set("n", "<cr>", function()
			local hovered = m:hovered()
			local item = m.items[hovered]
			m:close()
			actions.open_item(item, opts)
		end, { nowait = true, buffer = m.buf })

		for i, _ in ipairs(m.items) do
			local ns_id = hl.highlight_ns
			vim.api.nvim_buf_add_highlight(m.buf, ns_id, opts.highlights.mark, i - 1, 0, 1)
			vim.api.nvim_buf_add_highlight(m.buf, ns_id, opts.highlights.line, i - 1, 2, 8)
			vim.api.nvim_buf_add_highlight(m.buf, ns_id, opts.highlights.col, i - 1, 9, 13)
			vim.api.nvim_buf_add_highlight(m.buf, ns_id, opts.highlights.text, i - 1, 14, -1)
		end
	end)
end

function M.open(items, scope, opts)
	if vim.tbl_isempty(items) then
		if opts.notify_no_marks then
			vim.notify("No marks found", vim.log.levels.INFO)
		end
		return
	end

	local menu = Menu:new({
		position = opts.position,
		open_win_override = {
			title = scope == "all" and opts.title.all_marks or opts.title.local_marks,
		},
	})

	add_keymaps(menu, opts)

	menu:open(items, function(m, i)
		m:close()
		actions.open_item(items[i], opts)
	end, function(mark_item)
		return mark_item.line
	end)
end

return M
