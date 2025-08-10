return {
	'rmagatti/auto-session',
	enabled = false,
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>as", "<cmd>SessionSearch<CR>",         desc = "[S]earch sessions" },
		{ "<leader>aw", "<cmd>SessionSave<CR>",           desc = "[W]rite session" },
		{ "<leader>at", "<cmd>SessionToggleAutoSave<CR>", desc = "[T]oggle session autosave" },
	},
	opts = {
		enabled = true,
		-- Root dir where sessions will be stored
		root_dir = vim.fn.stdpath "data" .. "/sessions/",
		-- Enables/disables auto saving session on exit
		auto_save = true,
		-- Enables/disables auto restoring session on start
		auto_restore = true,
		-- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
		auto_create = true,
		-- Suppress session restore/create in certain directories
		suppressed_dirs = nil,
		-- Allow session restore/create in certain directories
		allowed_dirs = nil,
		-- On startup, loads the last saved session if session for cwd does not exist
		auto_restore_last_session = false,
		-- Include git branch name in session name
		git_use_branch_name = false,
		-- Should we auto-restore the session when the git branch changes. Requires git_use_branch_name
		git_auto_restore_on_branch_change = false,
		-- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
		lazy_support = true,
		-- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
		bypass_save_filetypes = nil,
		-- List of filetypes to close buffers of before saving a session, ignores checkhealth by default
		ignore_filetypes_on_save = { "checkhealth" },
		-- Close windows that aren't backed by normal file before autosaving a session
		close_unsupported_windows = true,
		-- Follow normal session save/load logic if launched with a single directory as the only argument
		args_allow_single_directory = true,
		-- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
		args_allow_files_auto_save = false,
		-- Keep loading the session even if there's an error
		continue_restore_on_error = true,
		-- Whether to show a notification when auto-restoring
		show_auto_restore_notif = true,
		-- Follow cwd changes, saving a session before change and restoring after
		cwd_change_handling = true,
		-- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
		lsp_stop_on_restore = false,
		-- Called when there's an error restoring. By default, it ignores fold errors otherwise it displays the error and returns false to disable auto_save
		restore_error_handler = nil,
		-- Sessions older than purge_after_minutes will be deleted asynchronously on startup, e.g. set to 14400 to delete sessions that haven't been accessed for more than 10 days, defaults to off (no purging), requires >= nvim 0.10
		purge_after_minutes = nil,
		-- Sets the log level of the plugin (debug, info, warn, error).
		log_level = "error",

		session_lens = {
			-- Initialize on startup (requires Telescope)
			load_on_setup = true,

			-- Table passed to Telescope / Snacks to configure the picker. See below for more information
			picker_opts = {
				-- For Telescope, you can set theme options here, see:
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
				--
				border = true,
				-- layout_config = {
				--   width = 0.8, -- Can set width and height as percent of window
				--   height = 0.5,
				-- },
			},

			mappings = {
				-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
				delete_session = { { 'i', 'n' }, "<C-D>" },
				alternate_session = { { 'i', 'n' }, "<C-S>" },
				copy_session = { { 'i', 'n' }, "<C-Y>" },
			},

			session_control = {
				-- Auto session control dir, for control files, like alternating between two sessions with session-lens
				control_dir = vim.fn.stdpath "data" .. "/auto_session/",
				-- File name of the session control file
				control_filename = "session_control.json",
			},
		},
	}
}
