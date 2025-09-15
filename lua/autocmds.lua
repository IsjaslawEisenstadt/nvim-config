--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
-- vim.api.nvim_create_autocmd('TextYankPost', {
-- 	desc = 'Highlight when yanking (copying) text',
-- 	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
-- 	callback = function()
-- 		vim.hl.on_yank()
-- 	end,
-- })

-- Auto equalize window sizes whenever vim is resized
-- vim.api.nvim_create_autocmd("VimResized", {
-- 	callback = function()
-- 		vim.cmd("wincmd =")
-- 	end,
-- })

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspNotify' }, {
	pattern = "*",
	callback = function()
		local clients = vim.lsp.get_clients({ name = "roslyn" })
		if not clients or #clients == 0 then
			return
		end

		local client = assert(vim.lsp.get_client_by_id(clients[1].id))
		local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
		for _, buf in ipairs(buffers) do
			local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
			client:request("textDocument/diagnostic", params, nil, buf)
		end
	end,
})
