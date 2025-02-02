local function custom_ascii_art()
	return {
		["Mulla"] = {
			"",
			"▄▄▄▄███▄▄▄▄   ███    █▄   ▄█        ▄█          ▄████████ ",
			"▄██▀▀▀███▀▀▀██▄ ███    ███ ███       ███         ███    ███ ",
			"███   ███   ███ ███    ███ ███       ███         ███    ███ ",
			"███   ███   ███ ███    ███ ███       ███         ███    ███ ",
			"███   ███   ███ ███    ███ ███       ███       ▀███████████ ",
			"███   ███   ███ ███    ███ ███       ███         ███    ███ ",
			"███   ███   ███ ███    ███ ███▌    ▄ ███▌    ▄   ███    ███ ",
			" ▀█   ███   █▀  ████████▀  █████▄▄██ █████▄▄██   ███    █▀  ",
			"",
		},

		["Allah"] = {
			"",
			"   ▄████████  ▄█        ▄█          ▄████████    ▄█    █▄    ",
			"  ███    ███ ███       ███         ███    ███   ███    ███   ",
			"  ███    ███ ███       ███         ███    ███   ███    ███   ",
			"  ███    ███ ███       ███         ███    ███  ▄███▄▄▄▄███▄▄ ",
			"▀███████████ ███       ███       ▀███████████ ▀▀███▀▀▀▀███▀  ",
			"  ███    ███ ███       ███         ███    ███   ███    ███   ",
			"  ███    ███ ███▌    ▄ ███▌    ▄   ███    ███   ███    ███   ",
			"  ███    █▀  █████▄▄██ █████▄▄██   ███    █▀    ███    █▀    ",
			"             ▀         ▀                                      ",
			"",
		},

		["Bismillah"] = {
			"",
			"▀█████████▄   ▄█     ▄████████   ▄▄▄▄███▄▄▄▄    ▄█   ▄█        ▄█          ▄████████    ▄█    █▄    ",
			"  ███    ███ ███    ███    ███ ▄██▀▀▀███▀▀▀██▄ ███  ███       ███         ███    ███   ███    ███   ",
			"  ███    ███ ███▌   ███    █▀  ███   ███   ███ ███▌ ███       ███         ███    ███   ███    ███   ",
			" ▄███▄▄▄██▀  ███▌   ███        ███   ███   ███ ███▌ ███       ███         ███    ███  ▄███▄▄▄▄███▄▄ ",
			"▀▀███▀▀▀██▄  ███▌ ▀███████████ ███   ███   ███ ███▌ ███       ███       ▀███████████ ▀▀███▀▀▀▀███▀  ",
			"  ███    ██▄ ███           ███ ███   ███   ███ ███  ███       ███         ███    ███   ███    ███   ",
			"  ███    ███ ███     ▄█    ███ ███   ███   ███ ███  ███▌    ▄ ███▌    ▄   ███    ███   ███    ███   ",
			"▄█████████▀  █▀    ▄████████▀   ▀█   ███   █▀  █▀   █████▄▄██ █████▄▄██   ███    █▀    ███    █▀    ",
			"                                                    ▀         ▀                                      ",
			"",
		},
	}
end

local function custom_header()
	local arts = custom_ascii_art()
	local keys = {}
	for key, _ in pairs(arts) do
		table.insert(keys, key)
	end
	local random_key = keys[math.random(#keys)]
	local art = arts[random_key] -- select the ascii art associated with that key
	local tbl = art
	local out = ""
	for i = 1, #tbl do
		out = out .. tbl[i] .. "\n"
	end
	return out
end

---@type lazypluginspec
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				header = custom_header(),
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "find file",
						action = "<leader><leader>",
					},
					{
						icon = " ",
						key = "n",
						desc = "new file",
						action = ":ene | startinsert",
					},
					{
						icon = " ",
						key = "g",
						desc = "find text",
						action = "<leader>/",
					},
					{
						icon = " ",
						key = "c",
						desc = "config",
						action = ":lua snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = " ",
						key = "s",
						desc = "restore session",
						section = "session",
					},
					{ icon = " ", key = "q", desc = "quit", action = ":qa" },
				},
			},
			-- sections = {
			-- 	{ section = "header" },
			-- 	{ section = "keys", gap = 1, padding = 1 },
			-- 	{ section = "startup" },
			-- 	{
			-- 		pane = 2,
			-- 		section = "terminal",
			-- 		cmd = "echo",
			-- 		height = 5,
			-- 		padding = 1,
			-- 	},
			-- },
		},
		debug = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true }, -- wrap notifications
			},
		},
		words = { enabled = true },
		win = { enable = true },
	},
	keys = {
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "lazygit",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "git blame line",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle
					.option("spell", { name = "Spelling" })
					:map("<leader>us")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.inlay_hints():map("<leader>uh")
			end,
		})
	end,
}
