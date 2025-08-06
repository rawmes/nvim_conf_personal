return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"xzbdmw/colorful-menu.nvim",
	},
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<C-1>"] = {
				function(cmp)
					cmp.accept({ index = 1 })
				end,
			},
			["<C-2>"] = {
				function(cmp)
					cmp.accept({ index = 2 })
				end,
			},
			["<C-3>"] = {
				function(cmp)
					cmp.accept({ index = 3 })
				end,
			},
			["<C-4>"] = {
				function(cmp)
					cmp.accept({ index = 4 })
				end,
			},
			["<C-5>"] = {
				function(cmp)
					cmp.accept({ index = 5 })
				end,
			},
			["<C-6>"] = {
				function(cmp)
					cmp.accept({ index = 6 })
				end,
			},
			["<C-7>"] = {
				function(cmp)
					cmp.accept({ index = 7 })
				end,
			},
			["<C-8>"] = {
				function(cmp)
					cmp.accept({ index = 8 })
				end,
			},
			["<C-9>"] = {
				function(cmp)
					cmp.accept({ index = 9 })
				end,
			},
			["<C-0>"] = {
				function(cmp)
					cmp.accept({ index = 10 })
				end,
			},
			["<C-k>"] = {},
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"cmdline",
			},
		},
		completion = {
			ghost_text = {
				enabled = true,
				show_with_menu = false,
			},
			menu = {
				auto_show = true,
				border = "single",
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "item_idx" },
						{ "kind_icon" },
						{ "label", gap = 1 },
					},
					components = {
						item_idx = {
							text = function(ctx)
								return ctx.idx == 10 and "0"
									or ctx.idx >= 10 and " "
									or tostring(ctx.idx)
							end,
							highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
						},
						-- label = {
						-- 	text = function(ctx)
						-- 		return require("colorful-menu").blink_components_text(
						-- 			ctx
						-- 		)
						-- 	end,
						-- 	highlight = function(ctx)
						-- 		return require("colorful-menu").blink_components_highlight(
						-- 			ctx
						-- 		)
						-- 	end,
						-- },
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 1000,
				window = {
					border = "single",
				},
			},
		},
		signature = { enabled = true, window = { border = "single" } },
	},
	opts_extend = { "sources.default" },
}
