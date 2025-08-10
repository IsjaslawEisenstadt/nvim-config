-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[Q]uickfix list' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-A-Insert>', '')
vim.keymap.set('i', '<C-A-Insert>', '<Esc>')
vim.keymap.set('t', '<C-A-Insert>', '<C-\\><C-n>')

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Paste without losing the register
vim.keymap.set('x', '<leader>p', '"_dP')

-- Term Toggle Function
local term_buf = nil
local term_win = nil

function TermToggle()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, false)
	else
		vim.cmd 'vertical new'
		local new_buf = vim.api.nvim_get_current_buf()
		if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
			vim.cmd('buffer ' .. term_buf) -- go to terminal buffer
			vim.cmd('bd ' .. new_buf) -- cleanup new buffer
		else
			vim.cmd 'terminal'
			term_buf = vim.api.nvim_get_current_buf()
			vim.wo.number = false
			vim.wo.relativenumber = false
			vim.wo.signcolumn = 'no'
		end
		vim.cmd 'startinsert!'
		term_win = vim.api.nvim_get_current_win()
	end
end

function TermClose()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, true)
		term_win = nil
	end
	if term_buf then
		vim.api.nvim_buf_delete(term_buf, { force = true })
		term_buf = nil
	end
end

-- Term Toggle Keymaps
vim.keymap.set('n', '<A-t>', ':lua TermToggle()<CR>', { desc = '[T]oggle [T]erminal', silent = true })
vim.keymap.set('i', '<A-t>', '<Esc>:lua TermToggle()<CR>', { desc = '[T]oggle [T]erminal', silent = true })
vim.keymap.set('t', '<A-t>', '<C-\\><C-n>:lua TermToggle()<CR>', { desc = '[T]oggle [T]erminal', silent = true })
vim.keymap.set('n', '<A-c>', ':lua TermClose()<CR>', { desc = '[C]lose [T]erminal', silent = true })
vim.keymap.set('i', '<A-c>', '<Esc>:lua TermClose()<CR>', { desc = '[C]lose [T]erminal', silent = true })
vim.keymap.set('t', '<A-c>', '<C-\\><C-n>:lua TermClose()<CR>', { desc = '[T]oggle [T]erminal', silent = true })

-- color picker
-- vim.keymap.set('n', '<leader>cc', '<cmd>CccPick<cr>', { desc = '[C]olor pick', silent = true })

vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
	require('tiny-code-action').code_action {}
end, { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>wt', '<cmd>NoNeckPain<cr>', { desc = 'Toggle NoNeckPain', silent = true })
-- vim.keymap.set('n', '<leader>wr', '<cmd>NoNeckPainResize 180<cr>', { desc = 'Resize NoNeckPain', silent = true })
-- vim.keymap.set('n', '<leader>wi', '<cmd>NoNeckPainWidthUp<cr>', { desc = 'WidthUp NoNeckPain', silent = true })
-- vim.keymap.set('n', '<leader>wo', '<cmd>NoNeckPainWidthDown<cr>', { desc = 'WidthDown NoNeckPain', silent = true })
-- vim.keymap.set('n', '<leader>wh', '<cmd>NoNeckPainToggleLeftSide<cr>', { desc = 'ToggleLeftSide NoNeckPain', silent = true })
-- vim.keymap.set('n', '<leader>wl', '<cmd>NoNeckPainToggleRightSide<cr>', { desc = 'ToggleRightSide NoNeckPain', silent = true })
