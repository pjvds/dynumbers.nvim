local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local group = augroup("toggling-numbers", { clear = true })
local log = require("dynumbers.log").new({
	plugin = "dynumbers.nvim",
	level = "warn",
})

assert(log, "failed to create logger")

local function evaluate()
	local mode = vim.api.nvim_get_mode().mode
	local relative = mode == "n" or mode == "v"

	if relative then
		log.trace("switching to relative numbers because mode: ", mode)
	else
		log.trace("switching to absolute numbers because mode: ", mode)
	end

	vim.wo.relativenumber = relative
end

---@param opts { log_level: string }
local function setup(opts)
	if opts.log_level then
		log.level = opts.log_level
	end

	vim.o.number = true
	vim.o.relativenumber = true

	autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
		pattern = "*",
		group = group,
		callback = function(event)
			log.trace("switching to absolute numbers because event: ", event)
			vim.wo.relativenumber = false
		end,
	})

	autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
		pattern = { "*" },
		group = group,
		callback = function(event)
			log.trace("evaluating numbers because event: ", event)
			evaluate()
		end,
	})

	autocmd("ModeChanged", {
		pattern = { "*:*" },
		group = group,
		callback = function(event)
			log.trace("evaluating numbers because event: ", event)
			evaluate()
		end,
	})
end

return {
	setup = setup,
}
