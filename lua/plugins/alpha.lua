return {
	'goolord/alpha-nvim',
	enabled = false,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local dash = require 'alpha.themes.dashboard'
		-- dash.file_icons.provider = "devicons"

		dash.section.header.val = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}
		dash.section.buttons.val = {
			dash.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dash.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
		}
		-- local handle = io.popen('fortune')
		-- local fortune = handle:read("*a")
		-- handle:close()
		-- dash.section.footer.val = fortune

		dash.config.opts.noautocmd = true
		-- dash.config = {
		--
		-- 	-- required
		--
		-- 	-- table of elements from top to bottom
		-- 	-- key is arbitrary, so you can use lua's array syntax
		-- 	layout = {},
		--
		-- 	-- optional
		-- 	opts = {
		-- 		-- number: how much space to pad on the sides of the screen
		-- 		margin = 0,
		--
		-- 		-- theme-specific setup,
		-- 		-- ran once before the first draw
		-- 		-- setup = function
		--
		-- 		-- when true,
		-- 		-- use 'noautocmd' when setting 'alpha' buffer local options.
		-- 		-- this can help performance, but it will prevent the
		-- 		-- FileType autocmd from firing, which may break integration
		-- 		-- with other plguins.
		-- 		-- default: false (disabled)
		-- 		noautocmd = false,
		--
		-- 		-- table of default keymaps
		-- 		keymap = {
		-- 			-- nil | string | string[]: key combinations used to press an
		-- 			-- item.
		-- 			press = '<CR>',
		-- 			-- nil | string | string[]: key combination used to select an item to
		-- 			-- press later.
		-- 			press_queue = '<M-CR>'
		-- 		}
		-- 	}
		-- }
		require("alpha").setup(dash.config)
	end,
};
