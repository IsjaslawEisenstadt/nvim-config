if vim.g.neovide then
	vim.o.guifont = 'FiraCode Nerd Font:h10'
	vim.opt.linespace = 1

	vim.g.neovide_padding_top = 5
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 5
	vim.g.neovide_padding_left = 5

	vim.g.neovide_opacity = 0.55
	vim.g.neovide_normal_opacity = 1.0

	vim.g.neovide_title_background_color = '#22272E'
	vim.g.neovide_title_text_color = 'white'
	vim.g.neovide_window_blurred = true

	vim.g.neovide_cursor_animation_length = 0.150
	vim.g.neovide_cursor_trail_size = 0.2
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_scroll_animation_far_lines = 0
end

-- vim.g.OmniSharp_server_use_mono = 1

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = false
vim.o.shiftwidth = 4

vim.o.winborder = 'solid'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor'

vim.o.shell = 'pwsh.exe'
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command $PSStyle.OutputRendering = 'PlainText';"
vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellquote = ''
vim.o.shellxquote = ''

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = false
vim.opt.listchars = { trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- vim.o.foldmethod = 'fold-indent'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 20

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.diagnostic.config {
	virtual_text = {
		severity = nil, -- show all severities
		source = 'if_many',
	},
	signs = true,
	underline = true,
	update_in_insert = true, -- ensure updates happen during insert
	severity_sort = true,
}

-- Edgy:
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = 'screen'
