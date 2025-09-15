return {
	'natecraddock/sessions.nvim',
	enabled = false,
	config = function()
		local sessions = require('sessions')
		sessions.setup({
			-- autocmd events which trigger a session save
			--
			-- the default is to only save session files before exiting nvim.
			-- you may wish to also save more frequently by adding "BufEnter" or any
			-- other autocmd event
			events = { 'User' },
			-- events = { "VimLeavePre" },

			-- default session filepath
			--
			-- if a path is provided here, then the path argument for commands and API
			-- functions will use session_filepath as a default if no path is provided.
			session_filepath = vim.fn.stdpath("data") .. "/sessions",

			-- treat the default session filepath as an absolute path
			-- if true, all session files will be stored in a single directory
			absolute = true,
		})
		vim.keymap.set('n', '<leader>wb', function() sessions.stop_autosave({ save = false }) end,
			{ desc = 'Stop Session Autosave' })
		vim.api.nvim_create_autocmd('VimLeavePre', {
			callback = function()
				vim.cmd("Neotree close")
				sessions.stop_autosave({ save = sessions.recording() })
			end
		})
	end
}
