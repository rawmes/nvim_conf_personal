return {
	{
		enabled = true,
		-- there is no cat here
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
	},
	{
		"LazyVim/LazyVim",
		opts = {},
	},
	{
		"scottmckendry/cyberdream.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd("colorscheme cyberdream")
		end,
	}, -- import/override with your plugins
}
