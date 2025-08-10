-- stylua: ignore start
local purple                   = "#c678dd"
local cursorline               = "#2d313b"
local blue                     = "#61afef"
local yellow                   = "#e5c07b"
local green                    = "#98c379"
local red                      = "#e06c75"
local white                    = "#abb2bf"
local indentline               = "#3b4048"
local highlight                = "#e2be7d"
local virtual_text_hint        = "#7ec7d1"
local virtual_text_information = "#90c7f4"
local virtual_text_warning     = "#edd2a1"
local virtual_text_error       = "#e8939a"
local fg_gutter_inactive       = "#abb2bf"
local fg_gutter                = "#3d4350"
local bg_statusline            = "#22262d"
local diff_text                = "#005869"
local diff_delete              = "#501b20"
local diff_add                 = "#003e4a"
local git_hunk_delete_inline   = "#6f2e2d"
local git_hunk_change_inline   = "#41483d"
local git_hunk_add_inline      = "#3f534f"
local line_number              = "#495162"
local git_hunk_delete          = "#502d30"
local fold                     = "#30333d"
local git_hunk_add             = "#43554d"
local comment                  = "#7f848e"
local git_delete               = "#9a353d"
local selection                = "#414858"
local git_change               = "#948B60"
local black                    = "#282c34"
local git_add                  = "#109868"
local gray                     = "#5c6370"
local color_column             = "#2d313b"
local float_bg                 = "#21252b"
local orange                   = "#d19a66"
local inlay_hint               = "#4c525c"
local fg                       = "#abb2bf"
local cyan                     = "#56b6c2"
local bg                       = "#282c34"
-- stylua: ignore end

return {
	'olimorris/onedarkpro.nvim',
	enabled = false,
	lazy = false,
	priority = 1000,
	config = function()
		require('onedarkpro').setup {
			options = {
				cursorline = false,    -- Use cursorline highlighting?
				transparency = true,   -- Use a transparent background?
				terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
				lualine_transparency = true, -- Center bar transparency?
				highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
			},
		}
		vim.cmd 'colorscheme onedark'
	end,
}
