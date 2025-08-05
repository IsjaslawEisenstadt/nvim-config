return {
	'lukas-reineke/indent-blankline.nvim',
	enabled = true,
	config = function()
		require('ibl').setup {
			exclude = {
				filetypes = { 'dashboard' },
			},
		}
		vim.g.indentLine_fileTypeExclude = { 'dashboard', 'startify' }
	end,
}
