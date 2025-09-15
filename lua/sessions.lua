local util = {}
util.windows = (function()
	if jit then
		local os = string.lower(jit.os)
		return os == "windows"
	else
		return "\\" == package.config:sub(1, 1)
	end
end)()

-- system dependent path separator from plenary.nvim
util.path = {}
util.path.sep = (function()
	if util.windows then
		return "\\"
	else
		return "/"
	end
end)()

util.path.split = function(path)
	local parts = vim.split(path, util.path.sep)

	-- only a name given
	if #parts == 1 then
		return nil, parts[1]
	end

	-- else return dir and basename
	local dir = vim.fn.join(util.slice(parts, 1, #parts - 1), util.path.sep)
	local name = parts[#parts]

	return dir, name
end

util.slice = function(tbl, s, e)
	return { unpack(tbl, s, e) }
end

-- set to nil when no session recording is active
local session_file_path = nil
local session_dir = vim.fn.stdpath("data") .. "/sessions"

-- ensure full path to session file exists, and attempt to create intermediate
-- directories if needed
local ensure_path = function(path)
	local dir, name = util.path.split(path)
	if dir and vim.fn.isdirectory(dir) == 0 then
		if vim.fn.mkdir(dir, "p") == 0 then
			return false
		end
	end
	return name ~= ""
end

-- converts a given filepath to a string safe to be used as a session filename
local safe_path = function(path)
	if util.windows then
		return path:gsub(util.path.sep, "."):sub(4)
	else
		return path:gsub(util.path.sep, "."):sub(2)
	end
end

-- given a path (possibly empty or nil) returns the absolute session path or
-- the default session path if it exists. Will create intermediate directories
-- as needed. Returns nil otherwise.
local get_session_path = function(ensure)
	if ensure == nil then
		ensure = true
	end

	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
	local path = vim.fn.expand(session_dir, ":p") .. util.path.sep .. safe_path(cwd) .. "session"

	if path and path ~= "" then
		if ensure and not ensure_path(path) then
			return nil
		end
		return path
	end

	return nil
end

local write_session_file = function(path)
	local target_path = path or session_file_path
	vim.cmd(string.format("mksession! %s", target_path))
end

local start_autosave = function()
	session_file_path = get_session_path(false)
end

local stop_autosave = function()
	session_file_path = nil
end

local save = function()
	local path = get_session_path()
	write_session_file(path)
end

local load = function()
	local path = get_session_path(false)
	if not path or vim.fn.filereadable(path) == 0 then
		return false
	end

	vim.cmd(string.format('silent! source %s', path))

	local current_win = vim.api.nvim_get_current_win()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'buftype') == 'terminal' then
			vim.api.nvim_set_current_win(win)
			vim.cmd('term')
		end
	end
	vim.api.nvim_set_current_win(current_win)

	return true
end

local recording = function()
	return session_file_path ~= nil
end

vim.keymap.set('n', '<leader>wb', function() stop_autosave() end,
	{ desc = 'Stop Session Autosave' })
vim.api.nvim_create_autocmd('VimLeavePre', {
	callback = function()
		vim.cmd("Neotree close")
		if recording() then
			save()
		end
		stop_autosave()
	end
})

_G.sessions_load = load
_G.sessions_save = save
_G.sessions_start_autosave = start_autosave
_G.sessions_stop_autosave = stop_autosave
_G.sessions_recording = recording
