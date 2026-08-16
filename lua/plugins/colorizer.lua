return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			filetypes = { "gdscript", "lua", "css", "html", "javascript" }, -- add gdscript here
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "red", "blue", etc.
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- rgb() and rgba()
				hsl_fn = true, -- hsl() and hsla()
				css = true, -- Enable all CSS features
				css_fn = true, -- Enable all CSS *functions*
				mode = "background", -- or "foreground"
			},
		})
	end,
}
