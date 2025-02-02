return {
	{
		enabled = false,
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		name = "cyberdream",
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
			colorscheme = "catppuccin",
		},
	},
}
