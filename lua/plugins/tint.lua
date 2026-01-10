return {
	"levouh/tint.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		local tint = require("tint")

		opts.tint = -45
		opts.saturation = 0.6
		opts.transforms = tint.transforms.SATURATE_TINT
		opts.tint_background_colors = true
		opts.highlight_ignore_patterns = {
			"WinSeparator",
			"Status.*",
		}
		opts.window_ignore_function = function(winid)
			local bufid = vim.api.nvim_win_get_buf(winid)
			local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
			local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

			return buftype == "terminal" or floating
		end
	end,
}
