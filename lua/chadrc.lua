local M = {}

M.base_30 = {
	white = "#DCD7BA",
	darker_black = "#191922",
	black = "#1F1F28", --  nvim bg
	black2 = "#25252e",
	one_bg = "#272730",
	one_bg2 = "#2f2f38",
	one_bg3 = "#363646",
	grey = "#43434c",
	grey_fg = "#4c4c55",
	grey_fg2 = "#53535c",
	light_grey = "#5c5c65",
	red = "#d8616b",
	baby_pink = "#D27E99",
	pink = "#c8748f",
	line = "#31313a", -- for lines like vertsplit
	green = "#98BB6C",
	vibrant_green = "#a3c677",
	nord_blue = "#7E9CD8",
	blue = "#7FB4CA",
	yellow = "#FF9E3B",
	sun = "#FFA066",
	purple = "#a48ec7",
	dark_purple = "#9c86bf",
	teal = "#7AA89F",
	orange = "#fa9b61",
	cyan = "#A3D4D5",
	statusline_bg = "#24242d",
	lightbg = "#33333c",
	pmenu_bg = "#a48ec7",
	folder_bg = "#7E9CD8",
}

M.base_16 = {
	base00 = "#1f1f28",
	base01 = "#2a2a37",
	base02 = "#223249",
	base03 = "#363646",
	base04 = "#4c4c55",
	base05 = "#c8c3a6",
	base06 = "#d2cdb0",
	base07 = "#DCD7BA",
	base08 = "#d8616b",
	base09 = "#ffa066",
	base0A = "#dca561",
	base0B = "#98bb6c",
	base0C = "#7fb4ca",
	base0D = "#7e9cd8",
	base0E = "#9c86bf",
	base0F = "#d8616b",
}
return {
	base46 = {
		theme = "kanagawa",
		hl_add = {
			DiagnosticUnderlineError = { underline = false, undercurl = true, sp = "red" },
			DiagnosticUnderlineWarn  = { underline = false, undercurl = true, sp = "yellow" },
			DiagnosticUnderlineInfo  = { underline = false, undercurl = true, sp = "cyan" },
			DiagnosticUnderlineHint  = { underline = false, undercurl = true, sp = "blue" },
			DiagnosticUnderlineOk    = { underline = false, undercurl = true, sp = "green" },
		},
		hl_override = {
			-- Comment      = { italic = true },
			-- ["@comment"] = { italic = true },
		},
		integrations = {},
		changed_themes = {},
		transparency = false,
		theme_toggle = { "onedark", "kanagawa" },
	},

	ui = {
		cmp = {
			icons_left = false, -- only for non-atom styles!
			style = "default", -- default/flat_light/flat_dark/atom/atom_colored
			abbr_maxwidth = 60,
			-- for tailwind, css lsp etc
			format_colors = { lsp = true, icon = "󱓻" },
		},

		telescope = { style = "bordered" }, -- borderless / bordered

		statusline = {
			enabled = true,
			theme = "default", -- default/vscode/vscode_colored/minimal
			-- default/round/block/arrow separators work only for default statusline theme
			-- round and block will work for minimal theme only
			separator_style = "round",
			order = nil,
			modules = nil,
		},

		-- lazyload it when there are 1+ buffers
		tabufline = {
			enabled = false,
			lazyload = true,
			order = { "treeOffset", "buffers", "tabs", "btns" },
			modules = nil,
			bufwidth = 21,
		},
	},

	nvdash = {
		load_on_startup = true,
		header = {},
		-- header = {
		-- 	"                      ",
		-- 	"  ▄▄         ▄ ▄▄▄▄▄▄▄",
		-- 	"▄▀███▄     ▄██ █████▀ ",
		-- 	"██▄▀███▄   ███        ",
		-- 	"███  ▀███▄ ███        ",
		-- 	"███    ▀██ ███        ",
		-- 	"███      ▀ ███        ",
		-- 	"▀██ █████▄▀█▀▄██████▄ ",
		-- 	"  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀",
		-- 	"                      ",
		-- 	"  Powered By  eovim ",
		-- 	"                      ",
		-- },

		buttons = {
			{ txt = "  Workspaces ", keys = "w", cmd = "Telescope workspaces" },
			{ txt = "  Files", keys = "f", cmd = "Telescope find_files" },
			{ txt = "  Recent", keys = ".", cmd = "Telescope oldfiles" },
			{ txt = "󱥚  Themes", keys = "t", cmd = ":lua require('nvchad.themes').open()" },
			-- { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

			{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

			{
				txt = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime) .. " ms"
					return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
				end,
				hl = "NvDashFooter",
				no_gap = true,
			},

			{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
		},
	},

	term = {
		base46_colors = true,
		winopts = { number = false, relativenumber = false },
		sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
		float = {
			relative = "editor",
			row = 0.3,
			col = 0.25,
			width = 0.5,
			height = 0.4,
			border = "single",
		},
	},

	lsp = { signature = true },

	cheatsheet = {
		-- simple/grid
		theme = "grid",
		-- can add group name or with mode
		excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
	},

	mason = { pkgs = {}, skip = {} },

	colorify = {
		enabled = true,
		-- fg, bg, virtual
		mode = "virtual",
		virt_text = "󱓻 ",
		highlight = { hex = true, lspvars = true },
	},
}
