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

		vim.lsp.config("roslyn", {
			cmd = {
				"dotnet",
				"D:/apps/CsLsp/Microsoft.CodeAnalysis.LanguageServer.dll",
				"--logLevel=Information",
				"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
				"--stdio",
			},
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
				},
			},
		})

		vim.diagnostic.config {
			severity_sort = true,
			float = { border = 'rounded', source = 'if_many' },
			underline = { severity = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.ERROR } },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = '● ',
					[vim.diagnostic.severity.WARN] = '● ',
					[vim.diagnostic.severity.INFO] = '● ',
					[vim.diagnostic.severity.HINT] = '● ',
				},
			} or {},
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
