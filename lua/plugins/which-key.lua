return {
	'folke/which-key.nvim',
	enabled = true,
	event = 'VimEnter',
	opts = {
		delay = 0,
		icons = {
			mappings = true,
			keys = {},
		},
		spec = {
			{ '<leader>s', group = '[S]earch' },
			-- { '<leader>t', group = '[T]oggle' },
			-- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
		},
	},
}
