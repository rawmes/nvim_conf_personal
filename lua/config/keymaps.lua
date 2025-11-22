-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function toggle_boolean()
	local replacements = {
		["true"] = "false",
		["false"] = "true",
		["True"] = "False",
		["False"] = "True",
		["1"] = "0",
		["0"] = "1",
	}

	local replacement = replacements[vim.fn.expand("<cword>")]
	if replacement then
		vim.cmd("normal! ciw" .. replacement)
	end
end

local function create_func()
	vim.notify("created a func template")
	vim.api.nvim_feedkeys("func () -> void:\n\tpass", "i", false)
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<Up>f(i", true, false, true),
		"n",
		false
	)
end

---@param mode string | table
---@param key_combination string
---@param command string | function
---@param desc string
---@param remap boolean | nil
local function map_key(mode, key_combination, command, desc, remap)
	vim.keymap.set(
		mode,
		key_combination,
		command,
		{ remap = remap or false, desc = desc }
	)
end

local function display_current_track()
	local os_name = vim.loop.os_uname().sysname

	if os_name == "Darwin" then
		local info = vim.fn.system(
			"osascript -e 'tell application \"Spotify\" to if player state is playing then get {name, artist, album} of current track'"
		)
		if info == "" then
			vim.notify("No Tracks Playing...")
			return
		end

		local split = vim.split(info, ",")
		vim.notify(
			"Track Name : "
				.. split[1]
				.. "\nArtist: "
				.. split[2]
				.. "\nAlbum: "
				.. split[3]
		)
	end
end

vim.keymap.set("n", "<C-x>", toggle_boolean, { noremap = true, silent = true })
vim.keymap.set("i", "<C-f>", create_func, { noremap = true, silent = true })

-- Basic keymaps
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
vim.keymap.set({ "i", "v" }, "qv", function()
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<Esc>", true, true, true),
		"n",
		true
	)
end, { noremap = true, silent = true })

vim.keymap.set({ "i", "v" }, "<C-x>", '"_x')

map_key(
	{ "n", "i", "v" },
	"<C-,>",
	"<esc><cmd>bprev<cr>",
	"Previous Buffer",
	true
)
map_key({ "n", "i", "v" }, "<C-.>", "<esc><cmd>bnext<cr>", "Next Buffer", true)
map_key("n", "<F5>", "<cmd>UndotreeToggle<cr>", "undo tree")
map_key("n", "<leader>pp", "<cmd>%!jq .<cr>", "json pretty print")
map_key("n", "<leader>a", "ggVG", "Select entire file")
map_key("n", "<localleader>t", function()
	local current_time = vim.fn.system('date "+Time Now: %H:%M"')
	vim.notify(current_time)
end, "Current Date Time")
map_key("n", "<localleader>s", display_current_track, "Spotify now playing")
-- ===============================
-- CUSTOM REGISTER COPY/PASTE PREFIX KEYS
-- ===============================

-- Disable default Ctrl-c and Ctrl-v behavior
vim.keymap.set({ "n", "v", "i" }, "<C-c>", "<Nop>", { noremap = true })
vim.keymap.set({ "n", "v", "i" }, "<C-v>", "<Nop>", { noremap = true })

local registers = {
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
}

-- Copy: <C-c> + register
for _, reg in ipairs(registers) do
	-- Normal mode → copy line
	vim.keymap.set("n", "<C-c>" .. reg, function()
		vim.cmd('normal! "' .. reg .. "yy")
	end, { noremap = true, desc = "Yank line into register " .. reg })

	-- Visual mode → copy selection
	vim.keymap.set("v", "<C-c>" .. reg, function()
		vim.cmd('normal! "' .. reg .. "y")
	end, { noremap = true, desc = "Yank selection into register " .. reg })
end

-- Paste: <C-v> + register (normal mode only)
for _, reg in ipairs(registers) do
	vim.keymap.set("n", "<C-v>" .. reg, function()
		vim.cmd('normal! "' .. reg .. "p")
	end, { noremap = true, desc = "Paste from register " .. reg })
end
