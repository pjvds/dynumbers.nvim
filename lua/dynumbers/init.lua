local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local group = augroup("toggling-numbers", { clear = true })

---@param opts {}
local function setup(opts)
	vim.o.number = true
	vim.o.relativenumber = true

	autocmd("BufLeave,FocusLost,InsertEnter,WinLeave", {
		pattern = "*",
		group = group,
		callback = function()
			vim.o.relativenumber = false
		end,
	})

	autocmd("ModeChanged", {
		pattern = { "*:i*", "i*:*" },
		group = group,
		callback = function()
			vim.o.relativenumber = vim.v.event.new_mode:match("^i") == nil
		end,
	})
end

return {
	setup = setup,
}
