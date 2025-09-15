return { -- Collection of various small independent plugins/modules
	'echasnovski/mini.nvim',
	enabled = true,
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require('mini.ai').setup { n_lines = 500 }

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require('mini.surround').setup()

		-- -- Simple and easy statusline.
		-- --  You could remove this setup call if you don't like it,
		-- --  and try some other statusline plugin
		-- local statusline = require 'mini.statusline'
		-- -- set use_icons to true if you have a Nerd Font
		-- statusline.setup { use_icons = vim.g.have_nerd_font }
		--
		-- -- You can configure sections in the statusline by overriding their
		-- -- default behavior. For example, here we set the section for
		-- -- cursor location to LINE:COLUMN
		-- ---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		-- 	return '%2l:%-2v'
		-- end
		require('mini.move').setup {}
		-- require('mini.animate').setup {}

		-- require('mini.starter').setup {
		-- 	-- Whether to open starter buffer on VimEnter. Not opened if Neovim was
		-- 	-- started with intent to show something else.
		-- 	autoopen = true,
		--
		-- 	-- Whether to evaluate action of single active item
		-- 	evaluate_single = true,
		--
		-- 	-- Items to be displayed. Should be an array with the following elements:
		-- 	-- - Item: table with <action>, <name>, and <section> keys.
		-- 	-- - Function: should return one of these three categories.
		-- 	-- - Array: elements of these three types (i.e. item, array, function).
		-- 	-- If `nil` (default), default items will be used (see |mini.starter|).
		-- 	-- items = {
		-- 	-- 	{ action = ':Telescope help_tags', name = 'Help', section = 'h' },
		-- 	-- },
		--
		-- 	-- Header to be displayed before items. Converted to single string via
		-- 	-- `tostring` (use `\n` to display several lines). If function, it is
		-- 	-- evaluated first. If `nil` (default), polite greeting will be used.
		-- 	header = '',
		--
		-- 	-- Footer to be displayed after items. Converted to single string via
		-- 	-- `tostring` (use `\n` to display several lines). If function, it is
		-- 	-- evaluated first. If `nil` (default), default usage help will be shown.
		-- 	footer = nil,
		--
		-- 	-- Array  of functions to be applied consecutively to initial content.
		-- 	-- Each function should take and return content for 'Starter' buffer (see
		-- 	-- |mini.starter| and |MiniStarter.content| for more details).
		-- 	content_hooks = nil,
		--
		-- 	-- Characters to update query. Each character will have special buffer
		-- 	-- mapping overriding your global ones. Be careful to not add `:` as it
		-- 	-- allows you to go into command mode.
		-- 	query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
		--
		-- 	-- Whether to disable showing non-error feedback
		-- 	silent = false,
		-- }
	end,
}
