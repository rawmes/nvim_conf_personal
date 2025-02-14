return {
	"nvzone/typr",
	dependencies = "nvzone/volt",
	opts = {},
	cmd = { "Typr", "TyprStats" },
	config = {
		on_attach = function(buf)
			vim.b[buf].blink_cmp = false
		end,
	},
}
