-- Opens a float for the next command
vim.api.nvim_create_user_command("Float", function(opts)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.8),
		row = math.floor(vim.o.lines * 0.1),
		col = math.floor(vim.o.columns * 0.1),
		style = 'minimal',
		border = 'rounded',
	})
	vim.cmd(opts.args)
end, { nargs = "+" })

-- Help command that always opens in the current buffer
-- Useful in combination with float:
-- :Float Help <topic>
vim.api.nvim_create_user_command("Help", function(opts)
	local topic = opts.args
	if topic == "" then
		print("Usage: :Help {topic}")
		return
	end

	-- Save the current &buftype so we can restore later
	local original_buftype = vim.bo.buftype

	-- Use help tags to get file + pattern
	local tag = vim.fn.taglist('^' .. topic .. '$')[1]
	if not tag then
		print("No help topic found for: " .. topic)
		return
	end

	-- Resolve to absolute path
	local filepath = vim.fn.fnamemodify(tag.filename, ":p")
	vim.cmd("edit " .. vim.fn.fnameescape(filepath))

	-- Search for the pattern in the file
	if tag.cmd:sub(1, 1) == '/' then
		local pattern = tag.cmd:sub(2, -2) -- remove leading/trailing /
		vim.fn.search(pattern, "w")
	end

	-- Remove 'help' buftype so it's a normal buffer
	vim.bo.buftype = original_buftype
	vim.bo.bufhidden = ""
	vim.bo.swapfile = true
end, { nargs = 1, complete = "help" })
