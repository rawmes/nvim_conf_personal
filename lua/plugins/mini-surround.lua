---@type LazyPluginSpec
return {
	"nvim-mini/mini.surround",
	recommended = true,
	opts = {
		mappings = {
			add = "gsa", -- Add surrounding in Normal and Visual modes
			replace = "gsr", -- Replace surrounding
		},
	},
}
