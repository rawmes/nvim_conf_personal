---@type LazyPluginSpec
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		local lualine = require("lualine")

		-- Color table for highlights
		-- stylua: ignore
		local colors = {
		  bg       = '#202328',
		  fg       = '#bbc2cf',
		  yellow   = '#ECBE7B',
		  cyan     = '#008080',
		  darkblue = '#081633',
		  green    = '#98be65',
		  orange   = '#FF8800',
		  violet   = '#a9a1e1',
		  magenta  = '#c678dd',
		  blue     = '#51afef',
		  red      = '#ec5f67',
		}

		local active_mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			["␖"] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			["␓"] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				component_separators = { left = "／", right = "＼" },
				theme = {
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
				disabled_filetypes = {
					statusline = { "neo-tree", "undotree" },
				},
				always_divide_middle = true,
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				return "▊"
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = active_mode_color
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { left = 0, right = 1 }, -- We don't need space before this
			separator = "",
		})

		ins_left({
			-- mode component
			function()
				local current_mode = vim.fn.mode()
				local mode_list = {
					["n"] = "NORMAL",
					["no"] = "O-PENDING",
					["i"] = "INSERT",
					["v"] = "VISUAL",
					["V"] = "VISUAL-LINE",
					["␓"] = "VISUAL-BLOCK",
					["s"] = "SELECT",
					["S"] = "SELECT-LINE",
					["<C-v>"] = "SELECT-BLOCK",
					["R"] = "REPLACE",
					["Rv"] = "REPLACE-VIRTUAL",
					["c"] = "COMMAND",
					["cv"] = "EX-VIM",
					["ce"] = "EX-NORMAL",
					["rm"] = "--PROMPT",
					["r?"] = "CONFIRM",
					["|"] = "EXTERNAL",
				}

				return mode_list[current_mode]
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = active_mode_color
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { right = 1 },
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		})

		ins_left({ "location", separator = "" })

		ins_left({
			"progress",
			color = { fg = colors.fg, gui = "bold" },
			separator = "",
		})

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.cyan },
			},
		})

		ins_right({
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft =
					vim.api.nvim_get_option_value("filetype", { buf = 0 })
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
			color = { fg = "#ffffff", gui = "bold" },
		})

		ins_right({
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
			separator = "",
		})

		ins_right({
			"diff",
			symbols = { added = "[+]", modified = "[~]", removed = "[-]" },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
			separator = "",
		})

		ins_right({
			function()
				return "▊"
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = active_mode_color
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { left = 1 },
			separator = "",
		})

		local recording_ns = vim.api.nvim_create_namespace("macro_recording")

		local function show_macro_recording()
			vim.api.nvim_buf_clear_namespace(0, recording_ns, 0, -1)
			local reg = vim.fn.reg_recording()
			if reg == "" then
				return
			end

			local msg = "Recording @" .. reg
			vim.api.nvim_echo({ { msg, "WarningMsg" } }, false, {})
		end

		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				show_macro_recording()
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				-- Hide the message after a short delay
				vim.defer_fn(function()
					vim.api.nvim_echo({ { "", "Normal" } }, false, {})
				end, 100)
			end,
		})

		return config
	end,
}
