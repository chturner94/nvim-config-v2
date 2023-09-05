local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("config.options")
require("lazy").setup({ -- Additional imports should go here.
	{ import = "plugins" },
	{ import = "plugins.lsp.lang.go" },
})

require("config.keymaps")
require("config.autocmds")

vim.cmd([[colorscheme moonfly]])
