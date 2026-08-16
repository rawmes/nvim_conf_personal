return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local servers = {
			"lua_ls",
			"bashls",
			"pylsp",
			"jsonls",
			"clangd",
			"ts_ls",
			"eslint",
			"html",
			"cssls",
			"emmet_ls",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_enable = false,
		})

		local configs = {
			lua_ls = {
				settings = {
					Lua = {
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
				on_init = function(client)
					local runtime_path = vim.split(package.path, ";")
					table.insert(runtime_path, "lua/?.lua")
					table.insert(runtime_path, "lua/?/init.lua")

					client.config.settings.Lua.runtime = {
						version = "LuaJIT",
						path = runtime_path,
					}
					client.config.settings.Lua.workspace.library = {
						vim.env.VIMRUNTIME,
						vim.fn.stdpath("config"),
					}
				end,
			},
			eslint = {
				on_attach = function(_, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			},
			emmet_ls = {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--log=verbose",
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_markers = {
					"compile_commands.json",
					"compile_flags.txt",
					".git",
				},
				init_options = { fallbackFlags = { "-std=c++17" } },
			},
		}

		for _, name in ipairs(servers) do
			vim.lsp.config(name, vim.tbl_deep_extend("force", {
				capabilities = capabilities,
			}, configs[name] or {}))
			vim.lsp.enable(name)
		end

		local godot_port = tonumber(vim.env.GDScript_Port or "6005")
		vim.lsp.config("gdscript", {
			cmd = vim.lsp.rpc.connect("127.0.0.1", godot_port),
			capabilities = capabilities,
			filetypes = { "gd", "gdscript", "gdscript3" },
			root_markers = { "project.godot", ".git" },
		})
		vim.lsp.enable("gdscript")
	end,

	init = function()
		local group = vim.api.nvim_create_augroup("user_lsp_keymaps", {
			clear = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf, silent = true }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "x" }, "<F3>", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
			end,
		})
	end,

	cmd = { "LspInfo", "LspInstall", "LspStart" },
}
