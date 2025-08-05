-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Store the layout window IDs
local layout = {
	main = nil,
	headers = nil,
	help = nil,
	term = nil,
}

-- Saves previous buffers for all windows before rerouting
local window_prev_bufs = {}

local function is_buffer_already_opened(target_win, buf)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if win ~= target_win and vim.api.nvim_win_get_buf(win) == buf then
			return true
		end
	end
	return false
end

local function scan_current_win_bufs()
	print 'starting WinEnter - caching window bufs'

	local current_window_bufs = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		current_window_bufs[win] = vim.api.nvim_win_get_buf(win)
	end
	window_prev_bufs = current_window_bufs
end

local function get_buf_type(buf)
	local bufname = vim.api.nvim_buf_get_name(buf)
	if vim.bo[buf].buftype == 'help' or vim.bo[buf].filetype == 'help' then
		return 'help'
	end
	if bufname:match '%.h$' or bufname:match '%.hpp$' then
		return 'headers'
	end
	if vim.api.nvim_buf_get_name(buf) ~= '' and vim.bo[buf].modifiable and vim.bo[buf].buftype == '' then
		return 'main'
	end
	return nil
end

local function setup_autocmds()
	vim.api.nvim_create_autocmd('WinEnter', {
		callback = scan_current_win_bufs,
	})
	vim.api.nvim_create_autocmd('BufWinEnter', {
		callback = function(args)
			print 'starting BufWinEnter'

			local bufnr = args.buf
			local bufname = vim.api.nvim_buf_get_name(bufnr)

			print('entered buf: ' .. bufnr .. ', buf name: ' .. bufname)

			local target_win = nil

			print 'listing current layout...'
			for n, v in pairs(layout) do
				print('layout ' .. n .. ': ' .. v)
			end

			local buf_type = get_buf_type(bufnr)
			if buf_type == 'help' then
				if not layout.help or not vim.api.nvim_win_is_valid(layout.help) then
					local split_target = layout.headers and vim.api.nvim_win_is_valid(layout.headers) and layout.headers or layout.main
					layout.help = vim.api.nvim_open_win(bufnr, true, { win = split_target, noautocmd = true, vertical = true, split = 'right' })
					print('setting layout.help to: ' .. layout.help)
					vim.cmd 'wincmd =' -- balance all windows
				end
				target_win = layout.help
			elseif buf_type == 'headers' then
				if not layout.headers or not vim.api.nvim_win_is_valid(layout.headers) then
					if layout.main and vim.api.nvim_win_is_valid(layout.main) then
						layout.headers = vim.api.nvim_open_win(bufnr, true, { win = layout.main, noautocmd = true, vertical = true, split = 'right' })
					elseif layout.help and vim.api.nvim_win_is_valid(layout.help) then
						layout.headers = vim.api.nvim_open_win(bufnr, true, { win = layout.help, noautocmd = true, vertical = true, split = 'left' })
					else
						layout.headers = vim.api.nvim_get_current_win()
					end
					print('setting layout.headers to: ' .. layout.headers)
				end
				target_win = layout.headers
			elseif buf_type == 'main' then
				if not layout.main or not vim.api.nvim_win_is_valid(layout.main) then
					if layout.headers and vim.api.nvim_win_is_valid(layout.headers) then
						layout.main = vim.api.nvim_open_win(bufnr, true, { win = layout.main, noautocmd = true, vertical = true, split = 'left' })
						print('splitting headers and setting layout.main to: ' .. layout.main)
					elseif layout.help and vim.api.nvim_win_is_valid(layout.help) then
						layout.main = vim.api.nvim_open_win(bufnr, true, { win = layout.main, noautocmd = true, vertical = true, split = 'left' })
						print('splitting help and setting layout.main to: ' .. layout.main)
					else
						layout.main = vim.api.nvim_get_current_win()
						print('no layout to split found; setting layout.main to: ' .. layout.main)
					end
				end

				target_win = layout.main
			end

			if not target_win then
				print 'no valid target_win; aborting!'
				return
			end

			print('target_win found: ' .. target_win)

			print 'starting cleanup'
			print('cleanup target window: ' .. target_win .. ', target buf: ' .. bufnr)

			print 'listing current window_prev_bufs...'
			for win_, buf_ in pairs(window_prev_bufs) do
				print('win: ' .. win_ .. ', buf: ' .. buf_)
			end
			print 'going through existing windows...'
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local win_buf = vim.api.nvim_win_get_buf(win)
				print('win: ' .. win .. ', buf: ' .. win_buf)
				if win ~= target_win and win_buf == bufnr then
					print 'found window that uses a reserved buffer...'
					local prev_buf = window_prev_bufs[win]
					if prev_buf and vim.api.nvim_buf_is_valid(prev_buf) and not is_buffer_already_opened(win, prev_buf) then
						print('restoring window [' .. win .. '] current buf [' .. win_buf .. '] to prev buf [' .. prev_buf .. ']')
						vim.api.nvim_win_set_buf(win, prev_buf)
					else
						print('closing window [' .. win .. '] current buf [' .. win_buf .. ']')
						vim.api.nvim_win_close(win, true)
					end
				end
			end
			if target_win and vim.api.nvim_win_is_valid(target_win) and vim.api.nvim_buf_is_valid(bufnr) then
				print('focusing target win: ' .. target_win .. ', with buffer: ' .. bufnr)
				vim.api.nvim_set_current_win(target_win)
				vim.cmd('buffer ' .. bufnr)
			end
			print 'ending cleanup'
		end,
	})
end

local function setup_window_manager()
	local persistence = require 'persistence'
	local current = persistence:current()
	if current and vim.fn.filereadable(current) ~= 0 then
		persistence.load()
		scan_current_win_bufs()
		for win, buf in pairs(window_prev_bufs) do
			local buf_type = get_buf_type(buf)
			if buf_type == 'help' then
				layout.help = win
			elseif buf_type == 'headers' then
				layout.headers = win
			elseif buf_type == 'main' then
				layout.main = win
			end
		end
	end
	setup_autocmds()
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'VeryLazy',
	callback = function()
		vim.schedule(function()
			setup_window_manager()
		end)
	end,
})

-- setup_window_manager()

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
