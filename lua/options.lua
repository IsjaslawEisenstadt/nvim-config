if vim.g.neovide then
	vim.o.guifont = 'FiraCode Nerd Font:h10'
	vim.opt.linespace = 0

	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_text_gamma = 0.0
	vim.g.neovide_text_contrast = 0.5

	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	vim.g.neovide_opacity = 1.0
	vim.g.neovide_normal_opacity = 1.0

	vim.g.neovide_title_background_color = '#1F1F28'
	vim.g.neovide_title_text_color = '#DCD7BA'
	vim.g.neovide_window_blurred = false

	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_position_animation_length = 0.1

	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_cursor_trail_size = 0.05
	vim.g.neovide_cursor_short_animation_length = 0.04
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_antialiasing = true

	vim.g.neovide_floating_corner_radius = 0.0
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 5
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_hide_mouse_when_typing = true

	vim.g.neovide_underline_stroke_scale = 3.0
	vim.g.neovide_cursor_unfocused_outline_width = 0.125

	vim.g.experimental_layer_grouping = false
	vim.g.neovide_confirm_quit = true
	vim.g.neovide_refresh_rate = 160
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_no_idle = false
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_profiler = false
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 0

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

vim.o.equalalways = true
vim.o.eadirection = "both"

-- when/where to show the statusline
-- 0: never
-- 1: only if there are at least two windows
-- 2: always
-- 3: always and ONLY the last window
vim.o.laststatus = 2

-- vim.o.ruler = true
vim.opt.whichwrap:append "<>[]hl"

-- vim.o.cmdheight = 30

vim.o.sessionoptions = 'folds,help,tabpages,winsize,terminal'
