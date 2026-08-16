-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.signcolumn = "yes"
o.scrolloff = 15
o.colorcolumn = "80"
o.number = true
o.numberwidth = 1
o.expandtab = false
o.cursorline = true
o.listchars = { tab = ">-" }
vim.diagnostic.config({
	update_in_insert = false,
	virtual_lines = false,
	virtual_text = {
		spacing = 2,
		source = false,
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	float = {
		source = false,
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	signs = true,
	underline = true,
})
