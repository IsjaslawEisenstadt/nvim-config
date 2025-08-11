return {
	{
		'NvChad/NvChad',
		enabled = false,
		dependencies = {
			{ "nvim-lua/plenary.nvim", },
			{ "nvim-tree/nvim-web-devicons", lazy = true },
			{
				"nvchad/ui",
				enabled = true,
				config = function()
					require "nvchad"
				end
			},
			{
				"nvchad/base46",
				lazy = true,
				build = function()
					require("base46").load_all_highlights()
				end,
			},
			{ "nvchad/volt" },
			{ import = "nvchad.blink.lazyspec" }
		},
	},
}
