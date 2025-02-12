-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---@param mode string | table
---@param key_combination string
---@param command string | function
---@param desc string
---@param remap boolean | nil
function map_key(mode, key_combination, command, desc, remap)
	vim.keymap.set(
		mode,
		key_combination,
		command,
		{ remap = remap or false, desc = desc }
	)
end

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
