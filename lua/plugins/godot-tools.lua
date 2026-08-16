local gdscript_filetypes = { "gd", "gdscript", "gdscript3" }

return {
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			if not vim.tbl_contains(opts.ensure_installed, "gdtoolkit") then
				table.insert(opts.ensure_installed, "gdtoolkit")
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			for _, filetype in ipairs(gdscript_filetypes) do
				opts.formatters_by_ft[filetype] = { "gdformat" }
			end
			opts.format_on_save = function(bufnr)
				if vim.tbl_contains(gdscript_filetypes, vim.bo[bufnr].filetype) then
					return { timeout_ms = 1000, lsp_format = "never" }
				end
			end
		end,
	},
}
