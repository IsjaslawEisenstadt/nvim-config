return {
	'shortcuts/no-neck-pain.nvim',
	enabled = false,
	opts = {
		width = 180,
		autocmds = {
			enableOnVimEnter = true,
			skipEnteringNoNeckPainBuffer = true,
		},
		integrations = {
			dashboard = {
				enabled = true,
			},
		},
	},
}
