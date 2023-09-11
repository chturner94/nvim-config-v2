return {
	"stevearc/overseer.nvim",
	opts = {
		dap = false, -- calling dap integration later in the DAP config manually
	},
	config = function(opts)
		require("overseer").setup(opts)
	end,
}
