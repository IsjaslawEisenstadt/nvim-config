return {
	'neovim/nvim-lspconfig',
	enabled = true,
	dependencies = {
		-- Useful status updates for LSP.
		{
			'j-hui/fidget.nvim',
			opts = {}
		},

		-- Allows extra capabilities provided by blink.cmp
		{
			'saghen/blink.cmp',
		},
	},
	config = function()
		vim.lsp.enable({ 'clangd', 'lua_ls' })

		vim.diagnostic.config {
			severity_sort = true,
			update_in_insert = true,
			float = { border = 'rounded', source = 'if_many' },
			underline = { severity = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.ERROR } },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = '● ',
					[vim.diagnostic.severity.WARN] = '● ',
					[vim.diagnostic.severity.INFO] = '● ',
					[vim.diagnostic.severity.HINT] = '● ',
				},
			},
			virtual_text = {
				source = 'if_many',
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		}
	end
}
