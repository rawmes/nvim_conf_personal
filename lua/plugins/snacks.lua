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
	opts = {
		bigfile = { enabled = true },
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
		terminal = {
			enabled = true,
			win = {
				position = "float",
				style = "terminal",
				wo = {
					winblend = 10,
				},
			},
		},
		win = { enable = true },
		---@class snacks.dashboard.Config
		---@field enabled? boolean
		---@field sections snacks.dashboard.Section
		---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
		dashboard = {
			width = 60,
			row = nil, -- dashboard position. nil for center
			col = nil, -- dashboard position. nil for center
			pane_gap = 4, -- empty columns between vertical panes
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			-- These settings are used by some built-in sections
			preset = {
				-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
				---@type fun(cmd:string, opts:table)|nil
				pick = nil,
				-- Used by the `keys` section to show keymaps.
				-- Set your custom keymaps here.
				-- When using a function, the `items` argument are the default keymaps.
				---@type snacks.dashboard.Item[]
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{
						icon = " ",
						key = "n",
						desc = "New File",
						action = ":ene | startinsert",
					},
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = " ",
						key = "s",
						desc = "Restore Session",
						section = "session",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				-- Used by the `header` section
				header = custom_header(),
			},
			-- item field formatters
			formats = {
				icon = function(item)
					if
						item.file and item.icon == "file"
						or item.icon == "directory"
					then
						return M.icon(item.file, item.icon)
					end
					return { item.icon, width = 2, hl = "icon" }
				end,
				footer = { "%s", align = "center" },
				header = { "%s", align = "center" },
				file = function(item, ctx)
					local fname = vim.fn.fnamemodify(item.file, ":~")
					fname = ctx.width
							and #fname > ctx.width
							and vim.fn.pathshorten(fname)
						or fname
					if #fname > ctx.width then
						local dir = vim.fn.fnamemodify(fname, ":h")
						local file = vim.fn.fnamemodify(fname, ":t")
						if dir and file then
							file = file:sub(-(ctx.width - #dir - 2))
							fname = dir .. "/…" .. file
						end
					end
					local dir, file = fname:match("^(.*)/(.+)$")
					return dir
							and {
								{ dir .. "/", hl = "dir" },
								{ file, hl = "file" },
							}
						or { { fname, hl = "file" } }
				end,
			},

			sections = {
				{
					pane = 1,
					{ section = "header" },
					{
						section = "keys",
						gap = 1,
						padding = 0,
						width = 99,
						height = 25,
					},
					{ section = "startup" },
				},
				{
					pane = 2, -- Moves the terminal to a different pane (right side)
					{
						section = "terminal",
						cmd = "echo '\n\n\n\n\n\n\n' && pokemon-colorscripts -r ; sleep .1",
						-- cmd = "kitten icat https://thispersondoesnotexist.com/",
						random = 99,
						height = 25,
						width = 35,
					},
				},
			},
		},
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
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>ft",
			function()
				Snacks.terminal.colorize()
				Snacks.terminal.toggle()
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
