local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("toggling-numbers", { clear = true })
local log = require("dynumbers.log")
local ignores = {}

local default_opts = {
	log_level = "warn",
	ignore = {},
}

assert(log, "failed to create logger")

local function evaluate()
	if ignores[vim.bo.filetype] then
		return
	end

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
	opts = vim.tbl_extend("force", default_opts, opts or {})
	log.new({
		plugin = "dynumbers.nvim",
		level = "warn",
	})

	for _, v in ipairs(opts.ignore) do
		ignores[v] = true
	end

	assert(log, "failed to create logger")

	vim.o.number = true
	vim.o.relativenumber = true

	autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
		pattern = "*",
		group = group,
		callback = function(event)
			assert(log, "log not initialized")

			log.trace("switching to absolute numbers because event: ", event)
			vim.wo.relativenumber = false
		end,
	})

	autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
		pattern = { "*" },
		group = group,
		callback = function(event)
			assert(log, "log not initialized")

			log.trace("evaluating numbers because event: ", event)
			evaluate()
		end,
	})

	autocmd("ModeChanged", {
		pattern = { "*:*" },
		group = group,
		callback = function(event)
			assert(log, "log not initialized")

			log.trace("evaluating numbers because event: ", event)
			evaluate()
		end,
	})
end

return {
	setup = setup,
}
