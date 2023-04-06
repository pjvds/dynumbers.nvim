local M = {}

---@param opts {}
function M.setup()
	local augroup = vim.api.nvim_create_augroup
	local autocmd = vim.api.nvim_create_autocmd

	local group = augroup("toggling-numbers", { clear = true })

	vim.wo.number = true
	vim.wo.relativenumber = true

	autocmd("ModeChanged", {
		pattern = { "*:i*", "i*:*" },
		group = group,
		callback = function()
			vim.o.relativenumber = vim.v.event.new_mode:match("^i") == nil
		end,
	})
end

return M
