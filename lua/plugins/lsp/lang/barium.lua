--[[ return {

	"neovim/nvim-lspconfig",
    @class PluginLspOpts
	opts = {
		---@type lspconfig.options
		servers = {
			barium = {},
		},
		setup = {
			-- barium for brazil-config completion
			-- https://w.amazon.com/bin/view/Barium
			-- toolbox install barium
			barium = function()
				local lspconfig = require("lspconfig")
				local configs = require("lspconfig.configs")
				configs.barium = {
					default_config = {
						cmd = { "barium" },
						filetypes = { Config = "brazilconfig" },
						root_dir = function(fname)
							return lspconfig.util.find_git_ancestor(fname)
						end,
						settings = {},
					},
				}
			end,
		},
	},
}
--]]

return {
	dir = "/home/cturnrq/workplace/NinjaHooks/src/NinjaHooks/",
	lazy = false,
	config = function(plugin)
		vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")
		-- Make my own filetype thing to override neovim applying ".conf" file type.
		-- You may or may not need this depending on your setup.
		vim.filetype.add({
			filename = { Config = "brazil-config" },
		})
	end,
}
