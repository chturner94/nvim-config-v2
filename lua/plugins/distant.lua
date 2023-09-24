return {
	-- Remote Development Plugin
	-- [Distant.nvim](https://distant.dev/editors/neovim/)
	"chipsenkbeil/distant.nvim",
	opts = {
		network = {
			timeout = {
				max = 1000,
			},
		},
		keymap = {
			dir = {
				enabled = true,
			},
		},
	},
	config = function(_, opts)
		require("distant"):setup(opts)
	end,
}
