local function augroup(name)
	return vim.api.nvim_create_augroup("myAugroup_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGAined", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

