local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local has_barium = false
local f = io.open("plugins.lsp.lang.barium", "r")
if f ~= nil then
	io.close(f)
	has_barium = true
end

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
	{ import = "plugins.lsp.lang.docker" },
	{ import = "plugins.lsp.lang.go" },
	{ import = "plugins.lsp.lang.typescript" },
	{ import = "plugins.lsp.lang.json" },
	{ import = "plugins.lsp.lang.yaml" },
})
if has_barium then
	require("lazy").setup({
		{ import = "plugins.lsp.lang.barium" },
	})
else
	require("lazy").setup({
		{ import = "plugins.lsp.lang.java" },
	})
end
require("config.keymaps")
require("config.autocmds")

vim.cmd([[colorscheme dracula_pro]])
