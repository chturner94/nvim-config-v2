return {
	{
		"dracula_pro",
		lazy = false,
		dir = "~/.config/dracula_pro",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = { style = "moon" },
	},
	{
		"zaldih/themery.nvim",
		opts = {
			themes = {
				{
					name = "Tokyo Night",
					colorscheme = "tokyonight",
				},
				{
					name = "Dracula",
					colorscheme = "dracula_pro",
				},
			},
			themeConfigFile = "~/.local/share/nvim/theme.lua",
		},
		keys = {
			{ "<leader>ut", "<cmd>Themery<cr>", desc = "Theme Selection: Themery" },
		},
		config = function(_, opts)
			require("themery").setup(opts)
		end,
	},
}
