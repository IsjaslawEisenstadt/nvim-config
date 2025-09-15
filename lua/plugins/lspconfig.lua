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

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

				-- Find references for the word under your cursor.
				map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

				map('K', vim.lsp.buf.hover, 'Hover Documentation')

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
				vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd('LspDetach', {
					group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
					end,
				})

				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				map('<leader>ti', function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
				end, '[t]oggle [i]nlay hints')
			end,
		})
	end
}
