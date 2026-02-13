local M = {}

function M.open_item(item, opts)
	if not item then
		return
	end

	if item.file and item.file ~= "" then
		vim.cmd(string.format("%s %s", opts.open_command, vim.fn.fnameescape(item.file)))
	elseif item.bufnr and vim.api.nvim_buf_is_valid(item.bufnr) then
		vim.api.nvim_set_current_buf(item.bufnr)
	else
		return
	end

	vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { item.lnum, item.col - 1 })
end

return M
