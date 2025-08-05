return {
	'uga-rosa/ccc.nvim',
	enabled = true,
	config = function()
		require('ccc').setup {
			bar_len = 40,
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		}
	end,
}
