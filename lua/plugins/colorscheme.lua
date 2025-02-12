return {
	{
		enabled = true,
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		name = "cyberdream",
		opts = {
			variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
			saturation = 1, -- accepts a value between 0 and 1. 0
			overrides = function(colors)
				return {
					Comment = {
						fg = colors.grey,
						bg = "NONE",
						italic = true,
					},
					Constant = {
						fg = colors.red,
						bg = "NONE",
						bold = true,
					},
					Todo = {
						fg = "#000000",
						bg = colors.blue,
						bold = true,
					},
					Function = {
						italic = true,
					},
					["@property"] = { fg = colors.yellow },
				}
			end,
		},
		config = function()
			require("cyberdream").setup({
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,

				borderless_pickers = false,

				-- Set terminal colors used in `:terminal`
				terminal_colors = true,

				-- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
				cache = false,

				-- Disable or enable colorscheme extensions
				extensions = {
					telescope = true,
					notify = false,
					mini = true,
				},
			})
		end,
	},
	{
		enabled = true,
		-- there is no cat here
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "cyberdream",
		},
	},
}
