return {
	-- Remote Development Plugin
	-- [Distant.nvim](https://distant.dev/editors/neovim/)
	"chipsenkbeil/distant.nvim",
	branch = "v0.3.0",
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
