return {
	'kazhala/close-buffers.nvim',
	enabled = true,
	config = function()
		require('close_buffers').setup({
			-- Filetype to ignore when running deletions
			filetype_ignore = {},
			-- File name glob pattern to ignore when running deletions (e.g. '*.md')
			file_glob_ignore = {},
			-- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
			file_regex_ignore = {},
			-- Types of deletion that should preserve the window layout
			preserve_window_layout = { 'this', 'nameless' },
			-- Custom function to retrieve the next buffer when preserving window layout
			next_buffer_cmd = nil,
		})

		vim.api.nvim_set_keymap(
			'n',
			'<leader>th',
			[[<CMD>lua require('close_buffers').delete({type = 'hidden'})<CR>]],
			{ desc = 'close [h]idden buffers', noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			'n',
			'<leader>tn',
			[[<CMD>lua require('close_buffers').delete({type = 'nameless'})<CR>]],
			{ desc = 'close [n]ameless buffers', noremap = true, silent = true }
		)
		-- vim.api.nvim_set_keymap(
		-- 	'n',
		-- 	'<leader>tt',
		-- 	[[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]],
		-- 	{ description = 'close [t]his buffer', noremap = true, silent = true }
		-- )
	end
}
